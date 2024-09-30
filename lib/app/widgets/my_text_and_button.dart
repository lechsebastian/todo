import 'package:flutter/material.dart';

class MyTextAndButton extends StatelessWidget {
  const MyTextAndButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.textToTap,
  });

  final VoidCallback onTap;
  final String text;
  final String textToTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.grey[700]),
        ),
        InkWell(
            onTap: onTap,
            child: Text(
              textToTap,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
