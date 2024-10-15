import 'package:chats/View/view_imports.dart';

class MessageState with ChangeNotifier {
  final SocketService socketService = SocketService();
  final HiveServices hiveServices = HiveServices();
  late Conversation _conversations;

  Conversation get conversation => _conversations;

  Future<void> sendNewMessage(index, conversation) async {
    String senderId = "user2"; // Replace with the sender's ID
    String roomId = "room 1"; // Replace with the receiver's ID
    String message = "working!";
    print('Sending message from $senderId to $roomId: $message');

    Messages newMessage = Messages(
      messageId: "msg_${DateTime.now().millisecondsSinceEpoch}",
      senderId: senderId,
      text: message,
      timestamp: DateTime.now().toIso8601String(),
      read: false,
    );

    conversation.chats.add(newMessage);

    conversation.lastMessage = message;

    _conversations = conversation;
    //storeMessages(index);
    notifyListeners();
  }

  Future<void> storeMessages(index) async {
    try {
      await hiveServices.updateConversation(index, _conversations);
      print('message state: data uplode');
    } catch (e) {
      print('message state: $e');
    }
  }
}
