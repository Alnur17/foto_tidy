import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';

class CustomLoader extends StatelessWidget {
  final Color color;

  const CustomLoader({super.key, required this.color,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: LinearGradient(colors: AppColors.buttonColor),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
