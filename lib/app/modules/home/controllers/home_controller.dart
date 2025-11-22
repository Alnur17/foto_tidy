import 'package:flutter/material.dart';
import 'package:foto_tidy/app/modules/home/views/tag_your_photo_from_gallery_view.dart';
import 'package:foto_tidy/common/app_color/app_colors.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../../../data/api.dart';
import '../../../data/base_client.dart';
import '../views/upload_image_view.dart';

class HomeController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  RxList<XFile> selectedImages = <XFile>[].obs;
  RxBool isLimitReached = false.obs;
  RxBool isSubscribed = false.obs;
  RxBool isLoading = false.obs;

  // Function to pick multiple images
  Future<void> pickImages({
    required BuildContext context,
  }) async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();

    // If user is subscribed → no limit at all
    if (isSubscribed.value) {
      selectedImages.addAll(pickedFiles);
      return;
    }

    // Normal user → limit = 5
    if (selectedImages.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You can upload a maximum of 5 images."),
        ),
      );

      return;
    }

    int availableSlots = 5 - selectedImages.length;

    if (pickedFiles.length > availableSlots) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You can upload a maximum of 5 images."),
        ),
      );
      selectedImages.addAll(pickedFiles.take(availableSlots));
    } else {
      selectedImages.addAll(pickedFiles);
    }

    isLimitReached.value = selectedImages.length >= 5;
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

  Future<void> uploadMultiplePhoto({required BuildContext context}) async {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select some images first.")),
      );
      return;
    }

    try {
      isLoading.value = true;
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(Api.uploadPhotos),
      );

      request.headers.addAll({
        "Accept": "application/json",
        "Content-Type": "multipart/form-data",
      });

      for (var img in selectedImages) {
        final mimeType = img.path.toLowerCase().endsWith(".png")
            ? MediaType("image", "png")
            : MediaType("image", "jpeg");

        request.files.add(
          await http.MultipartFile.fromPath(
            'files', // Change here if backend expects something else
            img.path,
            contentType: mimeType,
          ),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      debugPrint("Response Body: ${response.body}");

      var result = await BaseClient.handleResponse(response);

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        var uploadedData = result?['data'];
        Get.off(() => TagYourPhotoFromGalleryView(uploadedFiles: uploadedData));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Photos uploaded successfully!"),
            backgroundColor: AppColors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${result?['message']} "),
            backgroundColor: AppColors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error, $e"),
          backgroundColor: AppColors.red,
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
