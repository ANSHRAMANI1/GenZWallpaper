import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/SettingsSection/settings_controller.dart';

class SettingsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }

}