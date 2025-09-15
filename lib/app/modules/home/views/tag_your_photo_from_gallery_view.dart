import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/home/views/photo_saved_successfully_view.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/app_text_style/styles.dart';

import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/helper/custom_filter_chip.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../gallery/controllers/gallery_controller.dart';

class TagYourPhotoFromGalleryView extends StatefulWidget {
  const TagYourPhotoFromGalleryView({super.key});

  @override
  State<TagYourPhotoFromGalleryView> createState() => _TagYourPhotoFromGalleryViewState();
}

class _TagYourPhotoFromGalleryViewState extends State<TagYourPhotoFromGalleryView> {
  final galleryController = Get.find<GalleryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        title: Text('Tag Your Photo', style: appBarStyle),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80.h, // height stays fixed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: galleryController.galleryImages.length, // your list of images
                itemBuilder: (context, index) {
                  final imagePath = galleryController.galleryImages[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w), // spacing between items
                    child: Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16).r,
                        color: AppColors.silver,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8).r,
                        child: imagePath.startsWith('http')
                            ? Image.network(imagePath, fit: BoxFit.cover)
                            : Image.file(File(imagePath), fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),
            sh12,
            // Image display
            Container(
              height: 300.h,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16).r,
                color: AppColors.silver,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16).r,
                child: Image.network(AppImages.profileImage,fit: BoxFit.cover,),
                // Image.file(
                //   File(widget.imagePath),
                //   fit: BoxFit.cover,
                //   width: Get.width,
                //   errorBuilder: (context, error, stackTrace) => const Center(
                //     child: Text('Failed to load image'),
                //   ),
                // ),
              ),
            ),
            sh20,
            Text('Chose Tag',style: h3,),
            sh12,
            // Category selection
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: galleryController.categories.map((category) {
                return Obx(
                      () => CustomFilterChip(
                    text: category,
                    isSelected:
                    galleryController.selectedCategory.value == category,
                    onTap: () {
                      galleryController.selectCategory(
                          category); // Update category using GetX
                    },
                  ),
                );
              }).toList(),
            ),
            sh20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Apply to all photos',style: h5,),
                Image.asset(AppImages.toggle,scale: 4,),
              ],
            ),
            sh20,
            // Save button
            CustomButton(
              text: 'Save All Photos',
              onPressed: () {
                if (galleryController.selectedCategory.value != null) {
                  Get.to(() =>
                      //PhotoSavedSuccessfullyView(imagePath: widget.imagePath));
                      PhotoSavedSuccessfullyView());
                } else {
                  Get.snackbar('No Category', 'Please select a category');
                }
              },
              gradientColors: AppColors.buttonColor,
              borderRadius: 12,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
