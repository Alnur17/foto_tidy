import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../views/home_view.dart';

class HomeController extends GetxController {
  final ImagePicker _picker = ImagePicker();

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
        Get.to(() => CameraReviewScreen(imagePath: image.path));
      } else {
        Get.snackbar('No Photo', 'No photo was taken');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to take photo: $e');
    }
  }
}
