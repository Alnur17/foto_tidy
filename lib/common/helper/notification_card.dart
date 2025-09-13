import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';
import '../size_box/custom_sizebox.dart';
import '../widgets/custom_button.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String image;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.silver),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(image, scale: 4),
              sw5,
              Expanded(
                child: Text(
                  title,
                  style: h3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(time, style: h6.copyWith(color: AppColors.greyMedium)),
            ],
          ),
          sh8,
          Text(subtitle, style: h5.copyWith(color: AppColors.greyMedium)),
          sh8,
          CustomButton(
            text: 'View Offer',
            onPressed: () {},
            gradientColors: AppColors.buttonColor,
            width: 150.w,
            height: 36.h,
          ),
        ],
      ),
    );
  }
}