import 'package:flutter/material.dart';

class Moves extends StatelessWidget {
  const Moves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '0 Moves',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
