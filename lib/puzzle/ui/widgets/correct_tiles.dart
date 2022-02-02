import 'package:flutter/material.dart';

class CorrectTiles extends StatelessWidget {
  final int correctNo;
  const CorrectTiles(this.correctNo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      '$correctNo Tiles',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
