import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class CustomRowHeader extends StatelessWidget {
  const CustomRowHeader({
    super.key,
    required this.title,
     this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: h3,
          ),
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: Text(
                'View All',
                style: h6.copyWith(
                  color: AppColors.blue,
                  //decoration: TextDecoration.underline, // optional for visual cue
                ),
              ),
            ),
        ],
      ),
    );
  }
}