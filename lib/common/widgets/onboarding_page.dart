
import 'package:flutter/material.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/size_box/custom_sizebox.dart';

import '../app_text_style/styles.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          sh60,
          Image.asset(
            AppImages.logo,
            scale: 4,
          ),
          sh20,
          Text(
            title,
            textAlign: TextAlign.center,
            style: h2,
          ),
          sh20,
          Text(
            description,
            textAlign: TextAlign.center,
            style: h5,
          ),
          sh30,
          Image.asset(
            image,
            scale: 4,
          ),
        ],
      ),
    );
  }
}
