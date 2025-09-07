import 'package:get/get.dart';

import '../modules/gallery/bindings/gallery_binding.dart';
import '../modules/gallery/views/gallery_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/tags/bindings/tags_binding.dart';
import '../modules/tags/views/tags_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GALLERY,
      page: () => const GalleryView(),
      binding: GalleryBinding(),
    ),
    GetPage(
      name: _Paths.TAGS,
      page: () => const TagsView(),
      binding: TagsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
