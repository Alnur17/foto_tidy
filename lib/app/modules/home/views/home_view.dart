import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/gallery/views/full_image_view.dart';
import 'package:foto_tidy/app/modules/gallery/views/gallery_view.dart';
import 'package:foto_tidy/app/modules/home/controllers/home_controller.dart';
import 'package:foto_tidy/app/modules/home/views/browse_photos_view.dart';
import 'package:foto_tidy/app/modules/home/views/notifications_view.dart';
import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
import 'package:foto_tidy/app/modules/tags/controllers/tags_controller.dart';
import 'package:foto_tidy/common/app_color/app_colors.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/custom_filter_chip.dart';
import '../../../../common/helper/gallery_item.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_loader.dart';
import '../../gallery/controllers/gallery_controller.dart';
import '../../profile/controllers/favorite_controller.dart';
import '../../profile/controllers/gallery_lock_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeController = Get.put(HomeController());
  final galleryController = Get.put(GalleryController());
  final galleryLockController = Get.put(GalleryLockController());
  final profileController = Get.put(ProfileController());
  final tagsController = Get.put(TagsController());
  final favoriteController = Get.put(FavoriteController());

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await profileController.fetchProfile();
    await galleryController.fetchMyGallery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.background,
        title: Image.asset(
          AppImages.logo,
          scale: 4,
          height: 44.h,
          width: 78.w,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => NotificationsView());
            },
            child: Image.asset(
              AppImages.notification,
              scale: 4,
              color: AppColors.black,
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     Get.to(() => ProfileView(
          //       showBackButton: true,
          //     ));
          //   },
          //   child: Obx(() {
          //     final imagePath = profileController.profileImageUrl.value;
          //     return CircleAvatar(
          //       radius: 20,
          //       backgroundColor: AppColors.whiteDark,
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(20),
          //         child: imagePath.startsWith("http")
          //             ? CachedNetworkImage(
          //           imageUrl: imagePath,
          //           height: Get.height.h,
          //           width: Get.width.w,
          //           fit: BoxFit.cover,
          //           placeholder: (context, url) => const Center(
          //             child: CircularProgressIndicator(
          //               color: AppColors.orange,
          //             ),
          //           ),
          //           errorWidget: (context, url, error) => const Icon(
          //             Icons.error,
          //             color: Colors.red,
          //           ),
          //         )
          //             : Image.file(
          //           File(imagePath),
          //           height: Get.height.h,
          //           width: Get.width.w,
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     );
          //   }),
          // ),
          sw20,
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sh12,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Organize Your Photos',
                  style: h2,
                ),
                sh8,
                Text(
                  'Take or browse photos to get started',
                  style: h4,
                ),
                sh12,
                CustomButton(
                  text: 'Take Photo',
                  onPressed: () {
                    homeController.takePhoto(context: context);
                  },
                  gradientColors: AppColors.buttonColor,
                  borderRadius: 12,
                  height: 40,
                  centerImageWithText: true,
                  imageAssetPath: AppImages.camera,
                ),
                sh8,
                CustomButton(
                  text: 'Browse Photos',
                  onPressed: () {
                    Get.to(() => BrowsePhotosView());
                  },
                  borderColor: AppColors.borderColor,
                  borderRadius: 12,
                  textColor: AppColors.black,
                  height: 40,
                  centerImageWithText: true,
                  imageAssetPath: AppImages.browsePhotos,
                ),
              ],
            ),
          ),
          sh16,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gallery',
                  style: h3,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => GalleryView());
                  },
                  child: Text(
                    'View All',
                    style: h5.copyWith(color: AppColors.blue),
                  ),
                )
              ],
            ),
          ),
          sh12,
          SizedBox(
            height: 35.h,
            child: Obx(() {
              final tags = tagsController.allTagsList;
              final selected = galleryController.selectedCategory.value;
              final isLoading = tagsController.isLoading.value;

              if (isLoading) {
                return Center(
                  child: SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.orange,
                    ),
                  ),
                );
              }

              if (tags.isEmpty) {
                return Center(
                  child: Text(
                    "No tags available",
                    style: h5.copyWith(color: AppColors.grey),
                  ),
                );
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  final tagName = tag.title ?? '';
                  final tagId = tag.id?.toString() ?? '';
                  final isSelected = selected == tagName;

                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: CustomFilterChip(
                      text: tagName,
                      isSelected: isSelected,
                      onTap: () {
                        galleryController.selectCategory(tagId, tagName);
                      },
                    ),
                  );
                },
              );
            }),
          ),
          sh12,

          /// ---------- STORAGE INFO (Only for Free Users) ----------
          Obx(() {
            final data = profileController.profileData.value?.data;
            if (data == null) return SizedBox();
            if (data.isActiveSubscription == true) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Storage Used: ${data.freeStorage ?? 0} MB / ${data.storageLimit ?? 0} MB",
                style: h5.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }),

          sh12,
          Expanded(
            child: Obx(() {
              final data = profileController.profileData.value?.data;

              final isGalleryLock = data?.isGalleryLock ?? false;
              //final isActiveLock = data?.isActiveLock ?? false;

              // Conditions for showing PIN screen
              //final shouldAskPin = isGalleryLock && isActiveLock;

              return isGalleryLock
                  ? _buildLockedGallery()
                  : _buildGalleryGrid();
            }),
          ),
        ],
      ),
    );
  }

  /// Locked gallery view
  Widget _buildLockedGallery() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.changePassPro,
              scale: 4,
            ),
            sh12,
            Text(
              'Enter PIN to Unlock',
              style: h2.copyWith(fontWeight: FontWeight.w700),
            ),
            sh12,
            Text(
              'Please enter your 4-digit PIN to continue',
              style: h4,
            ),
            sh12,
            PinCodeTextField(
              appContext: context,
              mainAxisAlignment: MainAxisAlignment.center,
              separatorBuilder: (context, index) => sw12,
              controller: galleryLockController.submitPinTEController,
              length: 4,
              obscureText: false,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 50,
                activeColor: AppColors.white,
                activeFillColor: AppColors.white,
                inactiveColor: AppColors.borderColor,
                inactiveFillColor: AppColors.white,
                selectedColor: AppColors.blue,
                selectedFillColor: AppColors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: AppColors.transparent,
              cursorColor: AppColors.blue,
              enablePinAutofill: true,
              enableActiveFill: true,
              onCompleted: (pin) {},
              onChanged: (value) {},
              beforeTextPaste: (text) {
                log("Allowing to paste $text");
                return true;
              },
            ),
            sh20,
            Obx(
              () => galleryLockController.isLoading.value
                  ? CustomLoader(color: AppColors.white)
                  : CustomButton(
                      text: 'Submit',
                      onPressed: () {
                        galleryLockController.unlockGalleryLockKey(
                          galleryLockController.submitPinTEController.text,
                          context,
                        );
                      },
                      gradientColors: AppColors.buttonColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryGrid() {
    return Obx(() {
      if (galleryController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.orange),
        );
      }

      final gallery = galleryController.galleryList;

      final isProUser =
          profileController.profileData.value?.data?.isActiveSubscription ??
              false;

      if (gallery.isEmpty) {
        return Center(
          child: Text(
            "No gallery images found",
            style: h4.copyWith(color: AppColors.grey),
          ),
        );
      }

      return GridView.builder(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 116.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.9,
        ),
        itemCount: gallery.length,
        itemBuilder: (context, index) {
          final item = gallery[index];
          final isFav = RxBool(item.isFavorite ?? false);
          return GalleryItem(
            onImageTap: () {
              Get.to(() => FullImageView(
                    imageUrl: item.image ?? '',
                    photoId: item.id ?? '',
                  ));
            },
            isProUser: isProUser,
            imageUrl: item.image ?? '',
            isFavorite: item.isFavorite ?? false,
            onFavoriteToggle: () async {
              final userId =
                  profileController.profileData.value?.data?.id ?? "";
              final photoId = item.id ?? "";

              if (userId.isEmpty || photoId.isEmpty) {
                print("❌ Missing userId or photoId");
                return;
              }

              // -------- INSTANT UI UPDATE --------
              isFav.value = !isFav.value;

              // -------- API CALL --------
              if (isFav.value) {
                await favoriteController.addFavorite(
                  userId: userId,
                  photoId: photoId,
                );
              } else {
                await favoriteController.removeFavorite(photoId: photoId);
              }

              // -------- OPTIONAL REFRESH --------
              await galleryController.fetchMyGallery();
            },
          );
        },
      );
    });
  }
}
