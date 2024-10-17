import 'package:chats/View/view_imports.dart';

class MessageState with ChangeNotifier {
  final SocketService socketService = SocketService();
  final HiveServices hiveServices = HiveServices();
  late Conversation _conversations;
  final TextEditingController _messageController = TextEditingController();
  int _count = 0;

  Conversation get conversation => _conversations;

  TextEditingController get messageController => _messageController;

  Future<void> sendNewMessage(index, conversation) async {
    String senderId = await SharedPrefServices.getPreference('uid');
    String receiverId = conversation.members.firstWhere((id) => id != senderId);

    Messages newMessage = Messages(
      messageId: "msg_${DateTime.now().millisecondsSinceEpoch}",
      senderId: senderId,
      text: _messageController.text,
      timestamp: DateTime.now().toIso8601String(),
      read: false,
    );

    print(
        'Sending message from $senderId to $receiverId: ${_messageController.text} newMessage: $newMessage');

    conversation.chats.add(newMessage);

    conversation.lastMessage = _messageController.text;

    _conversations = conversation;
    _messageController.clear();
    _count++;
    notifyListeners();
  }

  Future<void> storeMessages(index, length) async {
    try {
      int hiveIndex = length - 1 - index;
      if (index == 0) {
        await hiveServices.updateConversation(hiveIndex, _conversations);
        clearConversation();
      } else if (_count > 0) {
        await hiveServices.deleteConversation(hiveIndex);
        await hiveServices.addConversation(_conversations);
        clearConversation();
      }
      print('MessageState storeMessages: Data updated');
    } catch (e) {
      print('MessageState: Error storing message - $e');
    }
  }

  Future<void> storeConversation(length) async {
    try {
      if (length == 0) {
        await hiveServices.addConversation(_conversations);
        clearConversation();
      }
      print('MessageState newConversation: Data updated');
    } catch (e) {
      print('MessageState: Error storing message - $e');
    }
  }

  void clearConversation() {
    _conversations = Conversation(
      members: [],
      lastMessage: '',
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
