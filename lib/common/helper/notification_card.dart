import 'package:flutter/material.dart';

import '../app_color/app_colors.dart';
import '../app_text_style/styles.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final Color? iconBgColor;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: iconBgColor ?? Colors.blue[50],
            ),
            child: Image.asset(
              iconPath,
              scale: 4,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: h3,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  subtitle,
                  style: h4.copyWith(
                    fontSize: 14,
                    color: AppColors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
