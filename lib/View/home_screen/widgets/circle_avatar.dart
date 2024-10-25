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
        Positioned(
          bottom: -15, // Adjust position for better visibility
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Padding for the label
            decoration: BoxDecoration(
              color: Colors.black54, // Semi-transparent background
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: const Text(
              'Contact',
              style: TextStyle(
                color: Colors.white, // White text for contrast
                fontSize: 12, // Smaller font size
              ),
            ),
          ),
        ),
      ],
    );
  }
}
