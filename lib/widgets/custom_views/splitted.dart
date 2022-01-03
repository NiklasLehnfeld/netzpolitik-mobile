import 'package:flutter/cupertino.dart';
import 'dart:math' as Math;

class Splitted extends StatelessWidget {
  final Widget first;
  final Widget second;

  const Splitted({
    required this.first,
    required this.second,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
            children:[
              Positioned.fill(child: first),
              Positioned.fill(
                child: ClipPath(
                  clipper: SplitClipPath(),
                  child: second,
                ),
              )
            ]
        )
    );
  }
}

class SplitClipPath extends CustomClipper<Path> {
  double degToRad(num deg) => deg * (Math.pi / 180.0);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
