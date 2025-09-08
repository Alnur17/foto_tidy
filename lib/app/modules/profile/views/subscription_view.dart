import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';

class SubscriptionView extends GetView {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'Subscription',
          style: appBarStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh20,
              Center(
                child: Image.asset(
                  AppImages.crown,
                  scale: 4,
                ),
              ),
              sh20,
              // Subscription header
              Center(
                child: Text(
                  'Upgrade to FotoTidy Pro',
                  style: h2,
                  textAlign: TextAlign.center,
                ),
              ),
              sh12,
              Text(
                'More power, more privacy, more freedom for your photos.',
                style: h4.copyWith(color: AppColors.greyMedium),
                textAlign: TextAlign.center,
              ),
              sh20,

              // Free subscription container
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Free',
                    style: h1.copyWith(
                      fontSize: 18,
                      color: AppColors.green,
                    ),
                  ),
                  sh12,
                  Text('5 Custom Tags'),
                  Text('Batch Upload of 15 Photos'),
                  Text('1 Tag per photo'),
                  Text('Basic features access'),
                ],
              ),
              sh20,

              // PRO BASIC subscription container
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                  border: Border.all(color: AppColors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PRO BASIC',
                        style: h3.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('\$2.59/month',
                        style: h3.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Unlimited Tags'),
                    Text('Batch Upload of 25 Photos'),
                    Text('Advanced Search'),
                    Text('Basic Sorting'),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Upgrade to Pro',
                      onPressed: () {},
                      backgroundColor: AppColors.blue,
                      textColor: AppColors.white,
                      height: 45,
                      borderRadius: 30,
                    ),
                  ],
                ),
              ),
              sh20,

              // PRO PREMIUM subscription container
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                  border: Border.all(color: AppColors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PRO PREMIUM',
                        style: h3.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('\$5.99/month',
                        style: h3.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Unlimited Tags'),
                    Text('Batch Upload of 50 Photos'),
                    Text('Advanced Sorting (All Types)'),
                    Text('AI-enhanced Sorting'),
                    SizedBox(height: 20),
                    CustomButton(
                      text: 'Upgrade to PRO PREMIUM',
                      onPressed: () {},
                      gradientColors: AppColors.buttonColor,
                      textColor: AppColors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
