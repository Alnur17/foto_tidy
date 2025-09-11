import 'package:flutter/material.dart';
import 'package:foto_tidy/app/modules/gallery/views/gallery_view.dart';
import 'package:foto_tidy/app/modules/tags/views/tags_view.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  List<Widget> _buildScreens() {
    return [
      const HomeView(),
      const GalleryView(),
      const TagsView(),
      ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(AppImages.homeFilled, scale: 4),
        inactiveIcon: Image.asset(AppImages.home, scale: 4),
        title: ("Home"),
        activeColorPrimary: AppColors.orange,
        inactiveColorPrimary: AppColors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(AppImages.galleryFilled, scale: 4),
        inactiveIcon: Image.asset(AppImages.gallery, scale: 4),
        title: ("Gallery"),
        activeColorPrimary: AppColors.orange,
        inactiveColorPrimary: AppColors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(AppImages.tagsFilled, scale: 4),
        inactiveIcon: Image.asset(AppImages.tags, scale: 4),
        title: ("Tags"),
        activeColorPrimary: AppColors.orange,
        inactiveColorPrimary: AppColors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(AppImages.profileFilled, scale: 4),
        inactiveIcon: Image.asset(AppImages.profile, scale: 4),
        title: ("Profile"),
        activeColorPrimary: AppColors.orange,
        inactiveColorPrimary: AppColors.transparent,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final PersistentTabController controller =
    PersistentTabController(initialIndex: 0);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PersistentTabView(
        padding: EdgeInsets.only(bottom: 8),
        margin: EdgeInsets.all(20),
        context,
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        backgroundColor: AppColors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(16.0),
          colorBehindNavBar: AppColors.white,
        ),
        navBarStyle: NavBarStyle.style3,
        navBarHeight: 75, // Taller navbar
      ),
    );
  }
}
