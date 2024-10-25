import 'package:flutter/material.dart';

import '../../../cores/const/constants.dart';

class AvatarWidget extends StatelessWidget {
  final String? foregroundImageUrl;

  const AvatarWidget({
    super.key,
    this.foregroundImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        border: Border.all(
          color: backgroundColor,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        heightFactor: 0.9,
        child: CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(foregroundImageUrl!),
        ),
      ),
    );
  }
}
