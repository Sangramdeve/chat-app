import 'package:chats/models/hive_models/conversation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../cores/const/constants.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.conversation,
    required this.press,
  });

  final Conversation conversation;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    String timeStamp = conversation.chats.last.timestamp;

    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 20 * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                 CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(conversation.userDetails.imageUrl),
                ),
                if (conversation.userDetails.status)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: const BoxDecoration(
                        color: kPrimaryColor, // Changes with theme
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dynamic text color based on theme
                    Text(
                      conversation.userDetails.fullName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor, // Changes with theme
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Opacity adjustment for secondary text
                    Opacity(
                      opacity: 0.64,
                      child: Row(
                        children: [
                          Text(
                            _truncateString(conversation.chats.last.text,30),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color:  Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white : Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Dynamic color for timestamp and status icon
            Opacity(
              opacity: 0.64,
              child: Column(
                children: [
                  Text(
                    formatDate(timeStamp),
                    style: TextStyle(
                      color:  Theme.of(context).brightness == Brightness.dark
                          ? Colors.white : Colors.grey[900],
                    ),
                  ),
                  const Icon(
                    Icons.done_all_outlined,
                    color: hSecondaryColor, // Optionally adjust with theme
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _truncateString(String str, int maxLength) {
  if (str.length <= maxLength) {
    return str;
  } else {
    return str.substring(0, maxLength) + '...';
  }
}


String formatDate(String value) {
  // Clean the date string to extract the ISO date
  String isoDateString = value.replaceAll("ISODate('", "").replaceAll("')", "");

  // Parse the cleaned date string and convert to local time
  DateTime dateTime = DateTime.parse(isoDateString).toLocal();
  DateTime now = DateTime.now();

  // Calculate the time difference
  Duration difference = now.difference(dateTime);

  // Format time and date
  String formattedTime = DateFormat('kk:mm').format(dateTime);
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

  // Return time if within the last 24 hours, otherwise return the date
  if (difference.inHours < 24) {
    return formattedTime;
  } else {
    return formattedDate;
  }
}
