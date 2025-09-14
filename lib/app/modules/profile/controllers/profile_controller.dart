import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/app_images/app_images.dart';

class ProfileController extends GetxController {
  final isProUser = true.obs;
  final isFirstTimeLock = false.obs;

  final ImagePicker _picker = ImagePicker();

  // To store selected image
  Rx<File?> selectedImage = Rx<File?>(null);

  // Store profile image url (in case user has not updated yet)
  RxString profileImageUrl = AppImages.profileImage.obs;

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }
  // Save changes (e.g., after tapping "Save Changes" button)
  void saveProfileChanges() {
    if (selectedImage.value != null) {
      // Here you can call API to upload and update profile image
      // For now just replace the cached url with local file path
      profileImageUrl.value = selectedImage.value!.path;
    }
  }
}
