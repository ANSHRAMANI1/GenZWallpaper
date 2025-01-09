import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_controller.dart';
import 'package:wallpaper_app/UI/screens/SearchSection/search_controller.dart';
import 'package:wallpaper_app/UI/screens/SplashSection/splash_controller.dart';
import 'package:wallpaper_app/infrastructure/services/no_internet_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(InternetConnectionController(),permanent: true);
    Get.put(HomeController(),permanent: true);
    Get.put(SearchScreenController(),permanent: true);
  }
}