import 'package:flutter/material.dart';
import 'package:foto_tidy/common/size_box/custom_sizebox.dart';

import '../app_color/app_colors.dart';
import '../app_images/app_images.dart';
import '../app_text_style/styles.dart';

class SubscriptionFeatureList extends StatelessWidget {
  final Color? imageColor;
  final String featureItem;

  const SubscriptionFeatureList({
    super.key,
    this.imageColor,
    required this.featureItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImages.rightChecked,
          scale: 4,
          color: imageColor ?? AppColors.green,
        ),
        sw5,
        Text(
          featureItem,
          style: h5,
        ),
      ],
    );
  }
}
