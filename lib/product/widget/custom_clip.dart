import 'dart:ui';

import 'package:eventgo/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomClipPath extends StatelessWidget {
  final String title;
  final BuildContext context;
  const CustomClipPath({
    super.key,
    required this.title, required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClip(),
      child: Container(
        width: double.infinity,
        color: ColorConstants.primaryColor,
        height: context.sized.height * 0.2,
        child: Center(
            child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.white),
        )),
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();

    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 50, w, h - 50);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
