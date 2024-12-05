import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sm_assignment_1/utils/theme/app_sizes.dart';

class Glassmorphism extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;

  const Glassmorphism({
    super.key,
    this.width,
    this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.mediumPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
