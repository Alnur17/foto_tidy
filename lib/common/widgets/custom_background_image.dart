import 'package:flutter/material.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';

class CustomBackgroundImage extends StatelessWidget {
  final Widget child;
  final String? backImage;

  const CustomBackgroundImage({
    super.key,
    required this.child,
    this.backImage = AppImages.onboardingBackImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(backImage!),fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
