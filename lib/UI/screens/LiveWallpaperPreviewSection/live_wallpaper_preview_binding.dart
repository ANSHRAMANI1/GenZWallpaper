import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/LiveWallpaperPreviewSection/live_wallpaper_preview_controller.dart';

class LiveWallpaperPreviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LiveWallpaperPreviewController());
  }

}