import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../views/upload_image_view.dart';

class HomeController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  RxList<XFile> selectedImages = <XFile>[].obs; // RxList for selected images
  RxBool isLimitReached = false.obs; // Flag to check if the image limit is reached

  // Function to pick multiple images from gallery
  Future<void> pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      selectedImages.addAll(pickedFiles); // Add selected images to the list

      // Check if the number of images exceeds the limit of 5
      if (selectedImages.length >= 5) {
        isLimitReached.value = true;
      }
    }
  }

  // Function to remove an image from the list
  void removeImage(XFile image) {
    selectedImages.remove(image);
    if (selectedImages.length < 5) {
      isLimitReached.value = false; // Reset the limit flag if under 5 images
    }
  }

  // Function to initiate photo capture
  Future<void> takePhoto() async {
    try {
      final permissionStatus = await Permission.camera.request();
      if (!permissionStatus.isGranted) {
        Get.snackbar(
            'Permission Denied', 'Please grant camera access to take photos');
        return;
      }

      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        Get.to(() => UploadImageView(imagePath: image.path));
      } else {
        Get.snackbar('No Photo', 'No photo was taken');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to take photo: $e');
    }
  }

}
