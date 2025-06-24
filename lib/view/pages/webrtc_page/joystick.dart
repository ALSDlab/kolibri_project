import 'package:flutter/material.dart';

class Joystick extends StatelessWidget {
  final Function(DragUpdateDetails) onDrag;
  const Joystick({super.key, required this.onDrag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onDrag,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Icon(Icons.touch_app, color: Colors.white),
      ),
    );
  }
}