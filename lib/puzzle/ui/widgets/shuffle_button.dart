import 'package:flutter/material.dart';

class ShuffleButton extends StatelessWidget {
  final VoidCallback onTap;
  const ShuffleButton({
    Key? key,
    required this.onTap,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextButton.icon(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            );
          }),
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
            (states) {
              if (states.contains(MaterialState.pressed) ) {
                return const EdgeInsets.all(20);
              }
              return const EdgeInsets.all(15);
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.purple;
              }
              return Colors.blue;
            },
          ),
        ),
        onPressed: onTap,
        icon: const Icon(
          Icons.shuffle,
          color: Colors.white,
          size: 30,
        ),
        label: const Text(
          'Shuffle',
          style: TextStyle(
            fontSize: 21,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
