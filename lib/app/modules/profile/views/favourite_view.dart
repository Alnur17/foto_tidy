import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/profile/controllers/favorite_controller.dart';
import 'package:foto_tidy/app/modules/profile/views/subscription_view.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/app_text_style/styles.dart';
import 'package:foto_tidy/common/helper/favourite_card.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../gallery/controllers/gallery_controller.dart';

class FavouriteView extends StatefulWidget {
  final bool isPro;
  final bool isTrial;

  const FavouriteView({super.key, required this.isPro, required this.isTrial});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final GalleryController galleryController = Get.find();

  @override
  void initState() {
    super.initState();
    if (widget.isPro|| widget.isTrial) {
      favoriteController.fetchFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text('Favorite', style: appBarStyle),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset(AppImages.back, scale: 4),
        ),
      ),
      body: widget.isPro || widget.isTrial
          ? Obx(() {
              if (favoriteController.isFavoriteLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.orange),
                );
              }

              if (favoriteController.favorites.isEmpty) {
                return Center(
                  child: Text(
                    "No favorites found",
                    style: h3.copyWith(color: Colors.white),
                  ),
                );
              }

              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: favoriteController.favorites.length,
                itemBuilder: (context, index) {
                  final item = favoriteController.favorites[index];
                  final imageUrl = item.photo?.image ?? "";

                  return FavouriteCard(
                    imageUrl: imageUrl,
                    favoriteIcon: AppImages.favoriteFilled,
                    onFavoriteTap: () {
                      favoriteController.removeFavorite(
                        photoId: item.photo?.id ?? "",
                      );

                      galleryController.fetchMyGallery();
                    },
                  );
                },
              );
            })

          // ========================= LOCKED (NOT PRO) ========================
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.favoriteUnlocked, scale: 4),
                  sh16,
                  Text('Unlock Your Favorites',
                      style: h1.copyWith(fontSize: 20.sp)),
                  sh8,
                  Text(
                    'Save your favorite photos in Tag place. Access them anytime with just one tap.',
                    textAlign: TextAlign.center,
                    style: h5.copyWith(
                        color: AppColors.greyMedium, fontSize: 16.sp),
                  ),
                  sh16,
                  CustomButton(
                    text: 'Upgrade to Pro',
                    onPressed: () {
                      Get.to(() => SubscriptionView());
                    },
                    gradientColors: AppColors.buttonColor,
                    borderRadius: 12,
                  ),
                  sh20,
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Maybe Later',
                      style: h3.copyWith(color: AppColors.greyMedium),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
