import 'package:get/get.dart';

import 'package:foto_tidy/app/modules/profile/controllers/change_password_controller.dart';
import 'package:foto_tidy/app/modules/profile/controllers/subscription_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
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
