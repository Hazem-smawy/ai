import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final Color shadowColor;
  final Offset shadowOffset;
  final double shadowBlurRadius;
  final BoxDecoration decoration;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 15,
    this.opacity = 0.1,
    this.borderRadius = 0,
    this.borderWidth = 0,
    this.borderColor = Colors.white,
    this.shadowColor = Colors.black54,
    this.shadowOffset = const Offset(2, 2),
    this.shadowBlurRadius = 10.0,
    this.decoration = const BoxDecoration(
      color: Colors.black,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: shadowOffset,
              blurRadius: shadowBlurRadius,
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: decoration.copyWith(
              color: decoration.color?.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor.withOpacity(0.2),
                width: borderWidth,
              ),
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
