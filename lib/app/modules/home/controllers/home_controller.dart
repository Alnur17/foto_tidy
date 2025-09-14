import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../views/upload_image_view.dart';

class HomeController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  RxList<String> galleryImages = RxList<String>();

  // Pick an image using image_picker or file_picker
  Future<String?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    }
    return null;
  }

  // // Add image to gallery
  // void addImageToGallery(String imagePath) {
  //   galleryImages.add(imagePath);
  //   update(); // Refresh the UI
  // }

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
