import 'package:get/get.dart';

import '../../../../common/app_images/app_images.dart';

class GalleryController extends GetxController {
  // available categories
  final categories = ["All", "Family", "Work", "Travel", "Pets", "Food"];

  // selected category
  var selectedCategory = "All".obs;

  // conditional flags
  var isGalleryLocked = false.obs; // default locked
  var isProUser = true.obs;      // default free user


  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  final galleryImages = [
    AppImages.profileImage,
    AppImages.profileImageTwo,
    AppImages.groupOfDogs,
    AppImages.profileImage,
    AppImages.profileImageTwo,
    AppImages.groupOfDogs,

    AppImages.profileImageTwo,
    AppImages.groupOfDogs,
    AppImages.profileImage,
    AppImages.profileImageTwo,
    AppImages.groupOfDogs,
    AppImages.profileImageTwo,
    AppImages.groupOfDogs,
    AppImages.profileImage,
    AppImages.profileImageTwo,
    AppImages.groupOfDogs,
  ];
}
