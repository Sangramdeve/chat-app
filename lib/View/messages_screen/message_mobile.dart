import 'package:chats/View-models/message_state.dart';
import 'package:chats/View/messages_screen/widgets/message_item.dart';

import '../view_imports.dart';

class MessageMobile extends StatefulWidget {
  const MessageMobile({super.key, this.conversation, this.index, this.length});

  final Conversation? conversation;
  final int? index;
  final int? length;

  @override
  State<MessageMobile> createState() => _MessageMobileState();
}

class _MessageMobileState extends State<MessageMobile> {
  late MessageState messageState;

  @override
  void initState() {
    super.initState();
    messageState = Provider.of<MessageState>(context, listen: false);
  }

  @override
  void dispose() {
    if (widget.length == 0) {
      Future.microtask(() => messageState.storeConversation(widget.length));
    }else{
      Future.microtask(() => messageState.storeMessages(widget.index,widget.length));
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return SafeArea(
        child: Stack(
      children: [
        ColoredBox(
          color: hPrimaryColor,
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: UserDetailsBar(
                    userDetails: widget.conversation!.userDetails,
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: screenHeight * 0.10,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight - screenHeight * 0.14,
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[900] // Dark theme color
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPadding + 70.0),
                child: Consumer<MessageState>(builder: (context, snapshot, _) {
                  List<Messages> reversedMessages =
                      List.from(widget.conversation!.chats.reversed);
                  return SizedBox(
                    width: screenWidth,
                    child: ListView.builder(
                      reverse: true,
                      itemCount: reversedMessages.length,
                      itemBuilder: (context, index) =>
                          MessageItem(messages: reversedMessages[index]),
                    ),
                  );
                }),
              ),
            )),
        Positioned(
          bottom: bottomPadding,
          left: 0,
          right: 0,
          child: Consumer<MessageState>(builder: (context, snapshot, _) {
            return ChatInputField(
              onButtonPressed: () {
                snapshot.sendNewMessage(widget.index, widget.conversation);
              },
            );
          }),
        ),
      ],
    ));
  }
}
