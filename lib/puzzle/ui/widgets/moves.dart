import 'package:flutter/material.dart';

class Moves extends StatelessWidget {
  final int totalMoves;
  
  const Moves({
    Key? key,
    required this.totalMoves,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      '$totalMoves Moves',
      style:const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
