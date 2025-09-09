import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/profile/views/privacy_and_policy_view.dart';
import 'package:foto_tidy/app/modules/profile/views/subscription_view.dart';
import 'package:foto_tidy/app/modules/profile/views/terms_and_conditions_view.dart';

import 'package:get/get.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_list_tile.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../auth/login/views/login_view.dart';
import '../controllers/profile_controller.dart';
import 'change_password_view.dart';
import 'edit_profile_view.dart';
import 'favourite_view.dart';

class ProfileView extends GetView<ProfileController> {
  final bool showBackButton;

  ProfileView({super.key, this.showBackButton = false});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        scrolledUnderElevation: 0,
        title: const Text('Profile'),
        automaticallyImplyLeading: showBackButton,
        leading: showBackButton
            ? GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppImages.back,
                  scale: 4,
                ),
              )
            : null,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sh20,
              Center(
                child: Column(
                  children: [
                    Obx(() {
                      final imagePath = profileController.profileImageUrl.value;
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.whiteDark,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: imagePath.startsWith("http")
                              ? CachedNetworkImage(
                                  imageUrl: imagePath,
                                  height: Get.height.h,
                                  width: Get.width.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.bottomBarText,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                )
                              : Image.file(
                                  File(imagePath),
                                  height: Get.height.h,
                                  width: Get.width.w,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    }),
                    sh12,
                    Text(
                      'Alex Richards',
                      style: h3.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'alex.Richards@**90.com',
                      style: h5.copyWith(
                          fontWeight: FontWeight.w500, color: AppColors.grey),
                    ),
                  ],
                ),
              ),
              sh30,
              Text(
                'Account',
                style: h3,
              ),
              Text(
                'Update your info to your account',
                style: h5.copyWith(color: AppColors.grey),
              ),
              //sh12,
              Column(
                children: [
                  CustomListTile(
                    onTap: () {
                      Get.to(() => EditProfileView());
                    },
                    leadingImage: AppImages.accountInfo,
                    title: 'Account Information',
                    trailingImage: AppImages.arrowRight,
                  ),
                  CustomListTile(
                    onTap: () {
                      Get.to(() => SubscriptionView());
                    },
                    leadingImage: AppImages.languageTwo,
                    title: 'Subscription',
                    trailingImage: AppImages.arrowRight,
                  ),
                  CustomListTile(
                    onTap: () {
                      Get.to(() => FavouriteView(
                            isPro: false,
                          ));
                    },
                    leadingImage: AppImages.favoriteFilled,
                    title: 'Favourite',
                    trailingImage: AppImages.arrowRight,
                  ),
                ],
              ),
              sh16,
              Text(
                'Privacy',
                style: h3,
              ),
              Text(
                'View your privacy',
                style: h5.copyWith(color: AppColors.grey),
              ),
              Column(
                children: [
                  CustomListTile(
                    onTap: () {
                      Get.to(() => ChangePasswordView());
                    },
                    leadingImage: AppImages.changePass,
                    title: 'Change Password ',
                    trailingImage: AppImages.arrowRight,
                  ),
                  CustomListTile(
                    onTap: () {
                      Get.to(() => TermsAndConditionsView());
                    },
                    leadingImage: AppImages.terms,
                    title: 'Terms and conditions',
                    trailingImage: AppImages.arrowRight,
                  ),
                  CustomListTile(
                    onTap: () {
                      Get.to(() => PrivacyAndPolicyView());
                    },
                    leadingImage: AppImages.privacy,
                    title: 'Privacy and Policies',
                    trailingImage: AppImages.arrowRight,
                  ),
                ],
              ),
              sh16,
              CustomListTile(
                onTap: () {
                  _showLogoutDialog(context);
                },
                leadingImage: AppImages.logout,
                title: 'Log Out',
                trailingImage: AppImages.arrowRight,
              ),
              sh116,
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.logoutBig,
                height: 60,
                width: 60,
              ),
              sh16,
              Text(
                "Are you sure you want to log out of your account?",
                textAlign: TextAlign.center,
                style: h3.copyWith(fontWeight: FontWeight.w500),
              ),
              sh20,
              CustomButton(
                text: "Confirm Log Out",
                borderRadius: 12,
                backgroundColor: AppColors.red,
                textColor: AppColors.white,
                onPressed: () {
                  Get.offAll(() => LoginView());
                },
              ),
              sh12,
              CustomButton(
                text: "Cancel",
                borderRadius: 12,
                backgroundColor: AppColors.silver,
                textColor: AppColors.black,
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
