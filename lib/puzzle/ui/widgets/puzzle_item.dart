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
    return Material(
      color: Colors.transparent,
      child: InkWell(
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
    return Ink(
      decoration: BoxDecoration(
        color: isBlank ? Colors.transparent : Colors.blue[800],
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
