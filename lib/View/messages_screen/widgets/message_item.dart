import 'package:chats/View/messages_screen/widgets/audio_message.dart';
import 'package:chats/View/messages_screen/widgets/text_message.dart';

import '../../view_imports.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.messages});

  final Messages messages;

  @override
  Widget build(BuildContext context) {
    bool isSender = messages.senderId == 'user1';
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: isSender?  MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          /// show user profile image
         /* if(isSender)...[
            const CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage("assets/images/user_2.png"),
            ),
            const SizedBox(width: 10),
          ],*/
          messageType(messages),
          if (isSender == false) tick(messages),
        ],
      ),
    );
  }
}

Widget messageType(Messages messages){
  if (messages.text is String && !messages.text.contains('.')) {
    return TextMessage(message: messages);
  }else if (messages.text.contains('.mp3') || messages.text.contains('.wav')) {
    return AudioMessage(message: messages);
  }else{
    return const SizedBox();
  }
}

Icon tick(Messages messages) {
  if (messages.read == true){
    return const Icon(
      Icons.done_all_outlined,
      color: hBlueLight,
    );
  }else if(messages.read == false){
    return const Icon(
      Icons.done_all_outlined,
      color: hSecondaryColor,
    );
  }else if(messages.read == false){
    return const Icon(
      Icons.done,
      color: hSecondaryColor,
    );
  }else{
    return const Icon(
      Icons.clear,
      color: Colors.transparent,
    );
  }
}

