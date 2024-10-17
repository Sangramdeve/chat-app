import 'package:chats/View-models/message_state.dart';

import '../../view_imports.dart';

class ChatInputField extends StatefulWidget {
  final VoidCallback onButtonPressed;

  const ChatInputField({super.key, required this.onButtonPressed});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      minimum: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: isDarkMode ? neuDarkBGColor : neuLightBgColor,
                // Color adapts to theme
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isDarkMode ? neuDarkColor : Colors.grey.shade400,
                  // Border adapts to theme
                  width: 1,
                ),
              ),
              child:  Row(
                children: [
                  Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                  ),
                  SizedBox(width: 10),
                  Consumer<MessageState>(
                    builder: (context, snapshot,_) {
                      return Expanded(
                        child: TextField(
                          controller: snapshot.messageController,
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            border: InputBorder.none,
                          ),
                        ),
                      );
                    }
                  ),
                  Icon(
                    Icons.attach_file,
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.camera_alt_outlined,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [hPrimaryColor, hPrimaryColor.withOpacity(0.7)],
                // Gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                  color: hPrimaryColor.withOpacity(0.4), // Shadow effect
                ),
              ],
            ),
            child: IconButton(
              onPressed: widget.onButtonPressed,
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
