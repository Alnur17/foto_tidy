import 'package:foto_tidy/app/modules/profile/views/subscription_view.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/widgets/popup_helper.dart';
import 'package:get/get.dart';

class TagsController extends GetxController {
  var tags = <String>[].obs;

  // void addTag(String tagName) {
  //   if (tagName.trim().isNotEmpty) {
  //     if (tags.length >= 5) {
  //       // Show upgrade popup instead of adding
  //      showUpgradePopup();
  //       return;
  //     }
  //     tags.add(tagName.trim());
  //   }
  // }

  bool addTag(String tagName) {
    if (tagName.trim().isNotEmpty) {
      if (tags.length >= 5) {
        // show popup
        PopupHelper.showCustomPopup(
          title: 'Unlock Unlimited Tags',
          description:
              'Go Pro to add more than 5 tag.Organize your photos better with unlimited tags. Upgrade to Pro for advanced features!',
          iconPath: AppImages.crownCircle,
          onPrimaryPressed: () {
            Get.back();
            Get.to(() => SubscriptionView());
          },
          primaryButtonText: 'Upgrade to Pro',
          onSecondaryPressed: () {
            Get.back();
          },
          secondaryButtonText: 'Maybe Later',
        );
        return false; // not added
      }
      tags.add(tagName.trim());
      return true; // added
    }
    return false;
  }

  void removeTag(int index) {
    if (index >= 0 && index < tags.length) {
      tags.removeAt(index);
    }
  }

  void updateTag(int index, String newTagName) {
    if (newTagName.trim().isNotEmpty && index >= 0 && index < tags.length) {
      tags[index] = newTagName.trim();
    }
  }
}
