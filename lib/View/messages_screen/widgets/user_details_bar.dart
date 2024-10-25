
import 'package:chats/models/hive_models/conversation.dart';
import 'package:flutter/material.dart';


class UserDetailsBar extends StatelessWidget {
  final UserData userDetails;
  const UserDetailsBar({
    super.key, required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
         CircleAvatar(
          backgroundImage: NetworkImage(userDetails.imageUrl),
          radius: 20,
        ),
        const SizedBox(width: 10),
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userDetails.fullName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              userDetails.status ? "Online" : "Offline",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.local_phone, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam, color: Colors.white),
          onPressed: () {},
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}



