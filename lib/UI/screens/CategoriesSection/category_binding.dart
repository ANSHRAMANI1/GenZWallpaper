import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/CategoriesSection/catregory_controller.dart';

class CategoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }

}