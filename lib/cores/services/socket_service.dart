import 'package:chats/View-models/message_state.dart';
import 'package:chats/View/view_imports.dart';
import 'package:chats/cores/const/api_urls.dart';
import 'package:chats/cores/services/shared_pref_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  bool _socketConnected = false;
  late Conversation _conversations;
  Conversation get conversation => _conversations;

  bool get socketConnected => _socketConnected;

  void updateConversation(conversation){
    _conversations = conversation;
  }
  // Connect to the server
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
      Messages newMessage = Messages(
        messageId: "msg_${DateTime.now().millisecondsSinceEpoch}",
        senderId: data['senderId'],
        text: data['message'],
        timestamp: DateTime.now().toIso8601String(),
        read: _socketConnected ? true : false,
      );
      _conversations.chats.add(newMessage);
      _conversations = _conversations;
      print('Private message from ${data['senderId']}: ${data['message']}');
    });

    // Handle disconnection
    socket.onDisconnect((_) {
      print('Disconnected from server');
    });
  }

  // Send a private message to another user
  void sendMessage(String senderId, String receiverId, String message,String conversationId) {
    print('server $conversationId');
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
}
