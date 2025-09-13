import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/app_text_style/styles.dart';
import 'package:foto_tidy/common/helper/favourite_card.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/size_box/custom_sizebox.dart';

class FavouriteView extends GetView {
  final bool isPro; // Add this variable to check if the user is Pro

  // Constructor with isPro as a parameter
  const FavouriteView({super.key, required this.isPro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Favorite',
          style: appBarStyle,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppImages.back,
            scale: 4,
          ),
        ),
      ),
      body: isPro
          ? GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 100,
              itemBuilder: (context, index) {
                return FavouriteCard(
                  imageUrl: AppImages.groupOfDogs,
                  favoriteIcon: AppImages.favoriteFilled,
                  onFavoriteTap: () {},
                );
              },
            )
          : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.favoriteUnlocked, // Show the image here
                  scale: 4,
                ),
                sh16,
                Text(
                  'Unlock Your Favorites',
                  style: h1.copyWith(fontSize: 20),
                ),
                sh8,
                Text(
                  'Save your favorite photos in Tag place. Access them anytime with just one tap.',
                  textAlign: TextAlign.center,
                  style: h5.copyWith(
                    color: AppColors.greyMedium,
                    fontSize: 16.sp,
                  ),
                ),
                sh16,
                CustomButton(
                  text: 'Upgrade to Pro',
                  onPressed: () {},
                  gradientColors: AppColors.buttonColor,
                  borderRadius: 12,
                ),
                sh20,
                GestureDetector(
                  onTap: () {
                    // Handle Maybe Later button press
                  },
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

//
// Container(
// padding: EdgeInsets.all(8),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12),
// color: AppColors.grey,
// image: DecorationImage(
// image: NetworkImage(AppImages.groupOfDogs),
// fit: BoxFit.cover,
// ),
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.end,
// children: [
// GestureDetector(
// onTap: () {},
// child: Image.asset(
// AppImages.favorite,
// scale: 4,
// ),
// ),
// ],
// ),
// );
