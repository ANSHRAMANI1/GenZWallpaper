import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/RingtonePreviewSection/ringtone_preview_controller.dart';

class RingtonePreviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RingtonePreviewController());
  }

}