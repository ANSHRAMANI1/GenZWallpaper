import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/CategoriesSection/catregory_controller.dart';
import 'package:wallpaper_app/UI/screens/MainSection/main_screen_controller.dart';
import 'package:wallpaper_app/UI/screens/SettingsSection/settings_controller.dart';
import 'package:wallpaper_app/UI/screens/WallpaperPreviewSection/wallpaper_preview_controller.dart';

class MainScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
    // Get.lazyPut(() => HomeController());
    // Get.lazyPut(() => SearchScreenController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => WallpaperPreviewController(),fenix: true);
    Get.lazyPut(() => SettingsController(),fenix: true);
  }

}