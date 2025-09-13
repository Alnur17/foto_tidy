import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../app_color/app_colors.dart';

class FavouriteCard extends StatelessWidget {
  final String imageUrl;
  final String favoriteIcon;
  final VoidCallback onFavoriteTap;
  final double padding;

  const FavouriteCard({
    super.key,
    required this.imageUrl,
    required this.favoriteIcon,
    required this.onFavoriteTap,
    this.padding = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.grey,
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onFavoriteTap,
            child: Image.asset(
              favoriteIcon,
              scale: 4,
            ),
          ),
        ],
      ),
    );
  }
}
