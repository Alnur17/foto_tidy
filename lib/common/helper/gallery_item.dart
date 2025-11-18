import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:get/get.dart';

import '../app_color/app_colors.dart';

class GalleryItem extends StatelessWidget {
  final String imageUrl;
  final bool isFavorite;
  final bool isProUser;
  final VoidCallback onFavoriteToggle;

  const GalleryItem({
    super.key,
    required this.imageUrl,
    this.isFavorite = false,
    this.isProUser = false,
    required this.onFavoriteToggle,

  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The image
        Container(
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: Get.width,
              height: Get.height,
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
        ),
        // Show favorite button only if the user is Pro
        if (isProUser)
          Positioned(
            top: 8.h, // Adjust the top positioning
            right: 8.w, // Adjust the right positioning
            child: GestureDetector(
              onTap: onFavoriteToggle,
              child: Container(
                padding: EdgeInsets.only(
                  top: 6.h,
                  bottom: 4.h,
                  left: 4.w,
                  right: 4.w,
                ),
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.black87,
                ),
                child: Image.asset(
                  isFavorite ? AppImages.favoriteFilled : AppImages.favorite,
                  scale: 4,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
