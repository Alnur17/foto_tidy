import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';

class CustomBackgroundColor extends StatelessWidget {
  final Widget child;
  final List<Color>? gradiantColor;

  const CustomBackgroundColor({
    super.key,
    required this.child,
    this.gradiantColor = AppColors.authBackColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradiantColor!,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
