import 'package:chats/cores/const/constants.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? foregroundImageUrl;

  const AvatarWidget({
    super.key,
    this.foregroundImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/placeholder.jpg'),
        ),
        if (foregroundImageUrl != null && foregroundImageUrl!.isNotEmpty)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(foregroundImageUrl!), // Foreground image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        const Positioned(
          top: 65,
          child: Text(
            'Contact',
            style: TextStyle(color: hColorLight),
          ),
        )
      ],
    );
  }
}
