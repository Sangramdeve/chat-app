import 'package:chats/View/view_imports.dart';
import 'package:chats/cores/const/api_urls.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageState with ChangeNotifier {
  final HiveServices hiveServices = HiveServices();
  late Conversation _conversations;
  final TextEditingController _messageController = TextEditingController();
  int _count = 0;
  String _senderId = '';
  String _message = '';
  late IO.Socket socket;
  bool _socketConnected = false;

  bool get socketConnected => _socketConnected;

  Conversation get conversation => _conversations;

  TextEditingController get messageController => _messageController;

  String get senderId => _senderId;

  String get message => _message;

  void updateConversation(conversation)async {
    _conversations = conversation;
    _senderId = await SharedPrefServices.getPreference('uid');
    notifyListeners();
  }

  void connect() async{
    String userId  = await SharedPrefServices.getPreference('uid');
    // Establish connection with Node.js server
    socket = IO.io(ApiUrls.baseUrl, IO.OptionBuilder()
        .setTransports(['websocket']) // Set WebSocket as transport
        .disableAutoConnect() // Disable auto-connect
        .build());

    // Connect to the server
    socket.connect();

    // Join the server with userId
    socket.onConnect((_) {
      _socketConnected = true;
      socket.emit('join', userId);
      print('Connected to server');
    });

    // Listen for private messages from the server
    socket.on('private_message', (data) {
      print('Private message from ${data['senderId']}: ${data['message']}');
      getNewMessageFromWebSocket(data);
    });

    // Handle disconnection
    socket.onDisconnect((_) {
      print('Disconnected from server');
    });
  }
  // Send a private message to another user
  void sendMessage(String senderId, String receiverId, String message,String conversationId) {
    socket.emit('private_message', {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'conversationId': conversationId,
    });
  }
  // Disconnect the socket
  void disconnect() {
    socket.disconnect();
  }

  Future<void> getNewMessageFromWebSocket(Map<String, dynamic> data) async {
    Messages newMessage = Messages(
      messageId: "msg_${DateTime.now().millisecondsSinceEpoch}",
      senderId: data['senderId'],
      text: data['message'],
      timestamp: DateTime.now().toIso8601String(),
      read: _socketConnected ? true : false,
    );

    debugPrint(
        'getting message from ${newMessage.senderId}, newMessage: $newMessage');

    _conversations.chats.add(newMessage);

    _conversations = _conversations;
    notifyListeners();
  }

  Future<void> sendNewMessage() async {
    _message = _messageController.text;
    Messages newMessage = Messages(
      messageId: "msg_${DateTime.now().millisecondsSinceEpoch}",
      senderId: senderId,
      text: _messageController.text,
      timestamp: DateTime.now().toIso8601String(),
      read: _socketConnected ? true : false,
    );

    debugPrint('Sending message from $senderId, newMessage: $newMessage');

    _conversations.chats.add(newMessage);

    _messageController.clear();
    _count++;
    notifyListeners();
  }

  Future<void> storeMessages(index, length) async {
    try {
      int hiveIndex = length - 1 - index;
      if (index == 0) {
        if (_count == 0) {
          return;
        }
        await hiveServices.updateConversation(hiveIndex, _conversations);
        clearConversation();
        debugPrint('MessageState storeMessages(): Data updated');
      } else if (_count > 0) {
        await hiveServices.deleteConversation(hiveIndex);
        await hiveServices.addConversation(_conversations);
        clearConversation();
        debugPrint('MessageState storeMessages(): Data deleted and updated');
      }
    } catch (e) {
      debugPrint('MessageState: Error storing message - $e');
    }
  }

  Future<void> storeConversation(length) async {
    try {
      if (length == 0) {
        await hiveServices.addConversation(_conversations);
        clearConversation();
      }
      print('MessageState newConversation(): Data updated');
    } catch (e) {
      print('MessageState: Error storing message - $e');
    }
  }

  void clearConversation() {
    _conversations = Conversation(
      conversationId: '',
      members: [],
      chats: [],
      userDetails: UserData(
          uid: '',
          fullName: '',
          imageUrl: '',
          lastSeen: '',
          status: false), // Reset user details if applicable
    );

    _messageController.clear();
    _count = 0;
  }
}
