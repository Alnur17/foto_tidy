import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foto_tidy/app/modules/profile/controllers/profile_controller.dart';
import 'package:foto_tidy/common/app_images/app_images.dart';
import 'package:foto_tidy/common/widgets/custom_loader.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/helper/subscription_card.dart';
import '../../../../common/helper/subscription_feature_list.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_circular_container.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  final ProfileController profileController = Get.find();

  Widget _buildPlanCard({
    required String planKey,
    required String displayTitle,
    required Color accentColor,
    required Color backgroundColor,
    required Color toggleBgColor,
  })
  {
    final monthlyPkg = subscriptionController.getPackage(planKey, true);
    final yearlyPkg = subscriptionController.getPackage(planKey, false);

    if (monthlyPkg == null && yearlyPkg == null) return const SizedBox();

    final isPremium = planKey.contains('premium');
    final monthlyRx = subscriptionController.selectedPackageId;

    // Default to monthly if none selected
    final isMonthly = monthlyRx.value == null
        ? true
        : (monthlyRx.value == monthlyPkg?.id ||
                monthlyRx.value == yearlyPkg?.id)
            ? monthlyRx.value == monthlyPkg?.id
            : true;

    final currentPkg = isMonthly ? monthlyPkg : yearlyPkg;
    if (currentPkg == null) return const SizedBox();

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                displayTitle,
                style: h2.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: isPremium ? AppColors.golden : null,
                ),
              ),
              Text(
                '\$${currentPkg.price?.toStringAsFixed(2)}/${isMonthly ? 'month' : 'year'}',
                style: h3.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          sh8,

          // Description
          Text('For casual users who want more control', style: h6),

          // if (currentPkg.description.isNotEmpty == true)
          //   Text(
          //     currentPkg.description.join(' • '),
          //     style: h6.copyWith(color: AppColors.greyDark),
          //   ),
          sh16,

          // Features
          ...currentPkg.description.map((f) => Column(
                children: [
                  SubscriptionFeatureList(
                    featureItem: f,
                    imageColor: isPremium ? AppColors.golden : AppColors.blue,
                  ),
                  sh10,
                ],
              )),

          sh10,

          // Toggle
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: toggleBgColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 35.h,
                    borderRadius: 12.r,
                    text: 'Monthly',
                    onPressed: monthlyPkg == null
                        ? () {}
                        : () => subscriptionController.selectedPackageId.value =
                            monthlyPkg.id,
                    backgroundColor:
                        isMonthly ? AppColors.white : AppColors.transparent,
                    textColor: AppColors.black,
                  ),
                ),
                sw12,
                Expanded(
                  child: CustomButton(
                    height: 35.h,
                    borderRadius: 12.r,
                    text: 'Yearly',
                    onPressed: yearlyPkg == null
                        ? () {}
                        : () => subscriptionController.selectedPackageId.value =
                            yearlyPkg.id,
                    backgroundColor:
                        !isMonthly ? AppColors.white : AppColors.transparent,
                    textColor: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          sh12,

          // Price Summary
          Container(
            height: 48.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(isMonthly ? 'Monthly' : 'Annually', style: h5),
                Text(
                  '\$${currentPkg.price?.toStringAsFixed(2)}/${isMonthly ? 'mo' : 'yr'}',
                  style: h3,
                ),
              ],
            ),
          ),
          sh20,

          // Upgrade Button
          CustomButton(
            text: 'Upgrade to $displayTitle',
            onPressed: () {
              subscriptionController.createSubscription(
                  packageId: currentPkg.id ?? '');
            },
            backgroundColor: AppColors.orange,
            textColor: AppColors.white,
            height: 45.h,
            borderRadius: 12.r,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text('Subscription', style: appBarStyle),
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () => Navigator.pop(context),
            padding: 2,
          ),
        ),
      ),
      body: Obx(() {
        final hasBasic =
            subscriptionController.getPackage('pro_basic', true) != null ||
                subscriptionController.getPackage('pro_basic', false) != null;
        final hasPremium =
            subscriptionController.getPackage('pro_premium', true) != null ||
                subscriptionController.getPackage('pro_premium', false) != null;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sh12,
                Obx(() {
                  final sub = subscriptionController.mySubscription.value?.data;

                  if (sub == null) {
                    return SubscriptionCard(
                      title: 'My Subscription',
                      planName: 'Free Plan',
                      deadlineText: 'No Active Subscription',
                      daysLeft: '0 Days',
                    );
                  }

                  final planName =
                      sub.package?.title?.toUpperCase() ?? 'Unknown';
                  final daysLeft = subscriptionController.getRemainingDays();

                  return SubscriptionCard(
                    title: 'My Subscription',
                    planName: planName,
                    deadlineText: 'Subscription Deadline',
                    daysLeft: '$daysLeft Days Left',
                  );
                }),
                sh8,

                Obx(() {
                  final trial = profileController.profileData.value?.data?.isEnabledFreeTrial;
                  final trialDaysLeft = profileController.getTrialRemainingDays();

                  if (trial == true) {
                    return SubscriptionCard(
                      title: '7 Days Free Trial',
                      planName: 'Trial Plan',
                      deadlineText: 'Trial Deadline',
                      daysLeft: '$trialDaysLeft Days',
                    );
                  }

                  return profileController
                              .profileData.value?.data?.isEnabledFreeTrial ==
                          true
                      ? SizedBox.shrink()
                      : Container(
                          padding: EdgeInsets.all(16).r,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Start Your 7-Day Free Trial',
                                style: h2,
                                textAlign: TextAlign.center,
                              ),
                              sh5,
                              Text(
                                  'Experience all features for free for 7 days.',
                                  style: h5),
                              sh20,
                              subscriptionController.isLoading.value == true
                                  ? CustomLoader(color: AppColors.white)
                                  : CustomButton(
                                      text: 'Star Free Trial',
                                      onPressed: () {
                                        subscriptionController
                                            .freeTrialSubscription();
                                      },
                                      gradientColors: AppColors.buttonColor,
                                    ),
                            ],
                          ));
                }),
               sh20,
                Center(child: Image.asset(AppImages.crown, scale: 4)),
                sh20,
                Center(
                  child: Text('Upgrade to FotoTidy Pro',
                      style: h2, textAlign: TextAlign.center),
                ),
                sh12,
                Text(
                  'More power, more privacy, more freedom for your photos.',
                  style: h4.copyWith(color: AppColors.greyMedium),
                  textAlign: TextAlign.center,
                ),
                sh30,

                // FREE (STATIC)
                Text('Free',
                    style:
                        h1.copyWith(fontSize: 18.sp, color: AppColors.green)),
                sh12,
                const SubscriptionFeatureList(featureItem: '5 Custom Tags'),
                sh12,
                const SubscriptionFeatureList(
                    featureItem: 'Batch Upload of 15 Photos'),
                sh12,
                const SubscriptionFeatureList(featureItem: '1 Tag per photo'),
                sh12,
                const SubscriptionFeatureList(
                    featureItem: 'Basic features access'),
                sh30,

                // LOADING
                if (subscriptionController.isLoading.value)
                  const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.orange,
                  ))
                else ...[
                  // PRO BASIC
                  if (hasBasic)
                    _buildPlanCard(
                      planKey: 'pro_basic',
                      displayTitle: 'PRO BASIC',
                      accentColor: AppColors.blue,
                      backgroundColor: AppColors.white,
                      toggleBgColor: AppColors.silver,
                    ),

                  sh20,

                  // PRO PREMIUM
                  if (hasPremium)
                    _buildPlanCard(
                      planKey: 'pro_premium',
                      displayTitle: 'PRO PREMIUM',
                      accentColor: AppColors.golden,
                      backgroundColor: Colors.yellow[50]!,
                      toggleBgColor: Colors.yellow[100]!,
                    ),
                ],

                sh50,
              ],
            ),
          ),
        );
      }),
    );
  }
}
