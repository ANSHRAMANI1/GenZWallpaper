import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/SearchSection/search_controller.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SearchScreenController());
  }

}