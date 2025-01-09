import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/SubscriptionSection/subscription_controller.dart';

class SubscriptionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SubscriptionController());
  }

}