import 'package:flutter/material.dart';

class GifProgressBar extends StatelessWidget {
  GifProgressBar({super.key, this.radius = 25});
  double? radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        backgroundImage: const AssetImage("assets/gifs/loading_animation.gif"),
      ),
    );
  }
}
