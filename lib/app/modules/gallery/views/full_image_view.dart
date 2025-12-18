import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foto_tidy/app/modules/gallery/controllers/gallery_controller.dart';
import 'package:foto_tidy/common/app_color/app_colors.dart';
import 'package:get/get.dart';

class FullImageView extends StatefulWidget {
  const FullImageView({
    super.key,
    required this.imageUrl,
    required this.photoId,

  });

  final String imageUrl;
  final String photoId;


  @override
  State<FullImageView> createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {

  final GalleryController galleryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Fullscreen Image
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(color: AppColors.orange,),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.contain,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          // Bottom Container
          Positioned(
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                     // saveImageToDevice(context, widget.imageUrl);
                    },
                    child: const Icon(
                      Icons.downloading_sharp,
                      color: AppColors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      galleryController.deleteSinglePhoto(photoId: widget.photoId, context: context);
                    },
                    child: const Icon(
                      Icons.delete_forever_outlined,
                      color: AppColors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
