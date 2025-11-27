import 'package:get/get.dart';

import 'package:foto_tidy/app/modules/profile/controllers/change_password_controller.dart';
import 'package:foto_tidy/app/modules/profile/controllers/favorite_controller.dart';
import 'package:foto_tidy/app/modules/profile/controllers/gallery_lock_controller.dart';
import 'package:foto_tidy/app/modules/profile/controllers/subscription_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryLockController>(
      () => GalleryLockController(), fenix: true
    );
    Get.lazyPut<FavoriteController>(
      () => FavoriteController(),
    );
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(),
    );
    Get.lazyPut<SubscriptionController>(
      () => SubscriptionController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
