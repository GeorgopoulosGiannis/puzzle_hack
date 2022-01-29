import 'package:flutter/material.dart';

class PuzzleItem extends StatelessWidget {
  final String? text;
  final VoidCallback? onPointTap;
  const PuzzleItem({
    Key? key,
    required this.text,
    this.onPointTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEmpty = text == null;
    return GestureDetector(
      onTap: onPointTap,
      child: _ItemDecoration(
        isBlank: isEmpty,
        child: Center(
          child: isEmpty
              ? null
              : Text(
                  text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
        ),
      ),
    );
  }
}

class _ItemDecoration extends StatelessWidget {
  final bool isBlank;
  final Widget child;
  const _ItemDecoration({
    Key? key,
    this.isBlank = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isBlank
        ? child
        : Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[800]!,
                  offset: const Offset(-6, 6),
                )
              ],
              color: Colors.blue[800],
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
            ),
            child: child,
          );
  }
}
