import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/WallpaperPreviewSection/wallpaper_preview_controller.dart';

class WallpaperPreviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => WallpaperPreviewController(),fenix: true);
  }

}