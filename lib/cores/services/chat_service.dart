import 'package:chats/cores/const/api_urls.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatServices {
  IO.Socket? socket;

  void initSocketConnection() {
    socket = IO.io(ApiUrls.sendMessages, <String, dynamic>{
      'transports': ['websockets'],
      'autoConnect': false,
    });
    socket?.connect();

    // Listen for connection event
    socket?.on('connect', (_) {
      print('Connected to server');
    });

    // Listen for disconnect event
    socket?.on('disconnect', (_) {
      print('Disconnected from server');
    });

    // Listen for incoming messages
    socket?.on('message', (data) {
      print('New message received: $data');
      // Handle the incoming message and update UI or cache
    });
  }

  void sendMessages(String conversationId, String message) {
    if (socket?.connected == true) {
      socket?.emit('sendMessage',
          {'conversationId': conversationId, 'message': message});
      print('Message sent: $message');
    } else {
      print('Socket is not connected');
    }
  }

  void disconnect() {
    socket?.disconnect();
  }
}
