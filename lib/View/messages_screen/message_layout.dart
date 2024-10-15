import 'package:chats/View/messages_screen/message_mobile.dart';
import 'package:chats/View/messages_screen/message_web.dart';

import '../view_imports.dart';

class MessageLayout extends StatefulWidget {
  const MessageLayout({super.key, required this.conversation,this.index});

  final Conversation conversation;
  final int? index;

  @override
  State<MessageLayout> createState() => _MessageLayoutState();
}

class _MessageLayoutState extends State<MessageLayout> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 600) {
          return const MessageWeb();
        } else {
          return MessageMobile(
            conversation: widget.conversation,
            index: widget.index,
          );
        }
      },
    ));
  }
}

/* @override
  void initState() {
    super.initState();
    String userId = "user1"; // Replace with the current user's ID
    socketService.connect(userId);
  }
*/

/* @override
  void dispose() {
    socketService.disconnect();
    super.dispose();
  }*/
