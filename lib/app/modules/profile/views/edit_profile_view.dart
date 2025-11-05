import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../common/app_color/app_colors.dart';
import '../../../../../common/app_images/app_images.dart';
import '../../../../../common/app_text_style/styles.dart';
import '../../../../../common/size_box/custom_sizebox.dart';
import '../../../../../common/widgets/custom_button.dart';
import '../../../../../common/widgets/custom_textfield.dart';
import '../../../../common/widgets/custom_loader.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final ProfileController profileController = Get.find();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() {
    final user = profileController.profileData.value?.data;
    profileController.nameTEController.text = user?.name ?? '';
    profileController.emailTEController.text = user?.email ?? '';
    profileController.contactTEController.text = user?.contractNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.mainColor,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Image.asset(AppImages.back, scale: 4),
          ),
        ),
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh20,
              Center(
                child: Obx(() {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.white,
                        child: ClipOval(
                          child: profileController.selectedImage.value != null
                              ? Image.file(
                                  profileController.selectedImage.value!,
                                  height: Get.height.h,
                                  width: Get.width.w,
                                  fit: BoxFit.cover,
                                )
                              : CachedNetworkImage(
                                  imageUrl: profileController.profileImageUrl.value,
                                  height: Get.height.h,
                                  width: Get.width.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error,
                                          color: Colors.red),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => profileController.pickImageFromGallery(),
                          child: const CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColors.black,
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              sh40,
              Text('Full Name', style: h5),
              sh8,
              CustomTextField(
                hintText: 'Enter your Name',
                controller: profileController.nameTEController,
              ),
              sh12,
              Text('Email', style: h5),
              sh8,
              CustomTextField(
                hintText: 'Enter Email',
                controller: profileController.emailTEController,
              ),
              sh12,
              Text('Phone', style: h5),
              sh8,
              IntlPhoneField(
                controller: profileController.contactTEController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  fillColor: AppColors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.black),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: AppColors.red),
                  ),
                ),
                initialCountryCode: 'BD',
                onChanged: (phone) {
                  log("Phone Number ${phone.number}");
                },
              ),
              sh20,
              Obx(
                () => profileController.isLoading.value == true
                    ? CustomLoader(color: AppColors.white)
                    : CustomButton(
                        text: 'Save Changes',
                        onPressed: () {
                          profileController
                              .updateProfile();
                        },
                        gradientColors: AppColors.buttonColor,
                      ),
              ),
              sh20,
            ],
          ),
        ),
      ),
    );
  }
}
