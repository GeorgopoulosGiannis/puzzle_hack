import 'package:flutter/material.dart';

class InfoEntry extends StatelessWidget {
  final String text;
  const InfoEntry({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 30,
        shadows: [
          Shadow(
            color: Colors.white,
            blurRadius: 10,
          )
        ],
      ),
    );
  }
}
