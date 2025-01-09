import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/ProfileSection/profile_controller.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }

}