import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../app_color/app_colors.dart';

class GalleryItem extends StatelessWidget {
  final String imageUrl;

  const GalleryItem({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.orange,
            ),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: AppColors.red,
          ),
        ),
      ),
    );
  }
}
