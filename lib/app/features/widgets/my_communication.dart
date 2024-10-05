import 'package:flutter/material.dart';

class MyCommunication extends StatelessWidget {
  const MyCommunication({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 18));
  }
}
