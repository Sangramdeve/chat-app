import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  // Connect to the server
  void connect(String userId) {
    // Establish connection with Node.js server
    socket = IO.io('http://10.0.2.2:8000', IO.OptionBuilder()
        .setTransports(['websocket']) // Set WebSocket as transport
        .disableAutoConnect() // Disable auto-connect
        .build());

    // Connect to the server
    socket.connect();

    // Join the server with userId
    socket.onConnect((_) {
      print('Connected to server');
      socket.emit('join', userId);
    });

    // Listen for private messages from the server
    socket.on('private_message', (data) {
      print('Private message from ${data['senderId']}: ${data['message']}');
    });

    // Handle disconnection
    socket.onDisconnect((_) {
      print('Disconnected from server');
    });
  }

  // Send a private message to another user
  void sendMessage(String senderId, String receiverId, String message) {
    socket.emit('private_message', {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
    });
  }

  // Disconnect the socket
  void disconnect() {
    socket.disconnect();
  }
}
