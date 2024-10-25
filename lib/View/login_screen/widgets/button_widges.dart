import 'package:chats/cores/const/constants.dart';
import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {

  final String text;
  final VoidCallback onTap;
  final String? iconUrl;

  const CustomButtons({

    super.key,
    required this.text,
    required this.onTap,
    required this.iconUrl,
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        style: TextButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade300),
          )
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center content horizontally
          children: [
            if (iconUrl != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0), // Decreased padding
                child: Image.asset(
                  iconUrl!,
                  width: 28, // Decreased icon size
                  height: 28, // Decreased icon size
                ),
              ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18, // Decreased text size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
