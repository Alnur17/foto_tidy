import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:get/get.dart';
import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/subscription_feature_list.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_circular_container.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView {
  SubscriptionView({super.key});

  final SubscriptionController controller = Get.put(SubscriptionController());

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
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 2,
          ),
        ),
      ),
      body: Obx(
        () => Padding(
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
                    SubscriptionFeatureList(featureItem: '5 Custom Tags'),
                    sh12,
                    SubscriptionFeatureList(
                        featureItem: 'Batch Upload of 15 Photos'),
                    sh12,
                    SubscriptionFeatureList(featureItem: '1 Tag per photo'),
                    sh12,
                    SubscriptionFeatureList(
                        featureItem: 'Basic features access'),
                  ],
                ),
                sh20,

                // PRO BASIC subscription container
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.white,
                    //border: Border.all(color: AppColors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PRO BASIC',
                            style: h2.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '\$2.99/month',
                            style: h3.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                                'For casual users who want more control',
                                style: h6),
                          ),
                          sw12,
                          Text(
                            '\$29.99/year',
                            style: h5,
                          ),
                        ],
                      ),
                      sh12,
                      SubscriptionFeatureList(
                        featureItem: 'Unlimited Tags',
                        imageColor: AppColors.blue,
                      ),
                      sh12,
                      SubscriptionFeatureList(
                        featureItem: 'Batch Upload of 25 Photos',
                        imageColor: AppColors.blue,
                      ),
                      sh12,
                      SubscriptionFeatureList(
                        featureItem: 'Advanced Search',
                        imageColor: AppColors.blue,
                      ),
                      sh12,
                      SubscriptionFeatureList(
                        featureItem: 'Basic Sorting',
                        imageColor: AppColors.blue,
                      ),
                      sh20,
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.silver,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                height: 35,
                                borderRadius: 12,
                                text: 'Monthly',
                                onPressed: () {
                                  controller.isMonthlySelected.value = true;
                                },
                                backgroundColor:
                                    controller.isMonthlySelected.value
                                        ? AppColors.white
                                        : AppColors.transparent,
                                textColor: AppColors.black,
                              ),
                            ),
                            sw12,
                            Expanded(
                              child: CustomButton(
                                height: 35,
                                borderRadius: 12,
                                text: 'Yearly',
                                onPressed: () {
                                  controller.isMonthlySelected.value = false;
                                },
                                backgroundColor:
                                    !controller.isMonthlySelected.value
                                        ? AppColors.white
                                        : AppColors.transparent,
                                textColor: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      sh12,
                      Obx(() {
                        return Container(
                          height: 48.h,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.isMonthlySelected.value
                                    ? 'Monthly'
                                    : 'Annually',
                                style: h5,
                              ),
                              Text(
                                controller.isMonthlySelected.value
                                    ? '\$2.99/month'
                                    : '\$29.99/year',
                                style: h3,
                              ),
                            ],
                          ),
                        );
                      }),
                      sh20,
                      CustomButton(
                        text: 'Upgrade to Pro',
                        onPressed: () {},
                        backgroundColor: AppColors.orange,
                        textColor: AppColors.white,
                        height: 45,
                        borderRadius: 12,
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
                    color: Colors.yellow[50],
                    //border: Border.all(color: AppColors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PRO PREMIUM',
                            style: h2.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColors.golden,
                            ),
                          ),
                          Text(
                            '\$5.99/month',
                            style: h3.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                                'For casual users who want more control',
                                style: h6),
                          ),
                          sw12,
                          Text(
                            '\$59.99/year',
                            style: h5,
                          ),
                        ],
                      ),
                      sh12,
                      SubscriptionFeatureList(
                        featureItem: 'Includes all in Basic',
                        imageColor: AppColors.golden,
                      ),
                      sh12,
                      SubscriptionFeatureList(
                        featureItem: 'Unlimited Batch Uploads',
                        imageColor: AppColors.golden,
                      ),
                      sh12,
                      SubscriptionFeatureList(
                        featureItem: 'Multiple Tags per Photo',
                        imageColor: AppColors.golden,
                      ),
                      sh12,
                      SubscriptionFeatureList(
                        featureItem: 'Advanced Sorting (All Types)',
                        imageColor: AppColors.golden,
                      ),
                      sh20,
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.yellow[100],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                height: 35,
                                borderRadius: 12,
                                text: 'Monthly',
                                onPressed: () {
                                  controller.isMonthlySelectedForPremium.value =
                                      true;
                                },
                                backgroundColor:
                                    controller.isMonthlySelectedForPremium.value
                                        ? AppColors.white
                                        : AppColors.transparent,
                                textColor: AppColors.black,
                              ),
                            ),
                            sw12,
                            Expanded(
                              child: CustomButton(
                                height: 35,
                                borderRadius: 12,
                                text: 'Yearly',
                                onPressed: () {
                                  controller.isMonthlySelectedForPremium.value =
                                      false;
                                },
                                backgroundColor: !controller
                                        .isMonthlySelectedForPremium.value
                                    ? AppColors.white
                                    : AppColors.transparent,
                                textColor: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      sh12,
                      Obx(() {
                        return Container(
                          height: 48.h,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.isMonthlySelectedForPremium.value
                                    ? 'Monthly'
                                    : 'Annually',
                                style: h5,
                              ),
                              Text(
                                controller.isMonthlySelectedForPremium.value
                                    ? '\$5.99/month'
                                    : '\$59.99/year',
                                style: h3,
                              ),
                            ],
                          ),
                        );
                      }),
                      sh20,
                      CustomButton(
                        text: 'Upgrade to Pro',
                        onPressed: () {},
                        backgroundColor: AppColors.orange,
                        textColor: AppColors.white,
                        height: 45,
                        borderRadius: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
