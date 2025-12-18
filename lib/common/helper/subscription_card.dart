import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String planName;
  final String deadlineText;
  final String daysLeft;

  const SubscriptionCard({
    super.key,
    required this.title,
    required this.planName,
    required this.deadlineText,
    required this.daysLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: h2),
          sh8,
          Text(planName, style: h3),
          sh8,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(deadlineText, style: h5)),
                Text(daysLeft, style: h6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
