import 'package:get/get.dart';
import 'package:wallpaper_app/infrastructure/storage/shared_preference_service.dart';

class SettingsController extends GetxController{
  RxBool showNotification = false.obs;

  requestNotification() async{
    showNotification.value = !showNotification.value;
    await SharedPreferenceService.saveShowNotification(showNotification.value);
  }

  @override
  void onInit() async{
    showNotification.value = await SharedPreferenceService.getShowNotification;
    await SharedPreferenceService.saveShowNotification(showNotification.value);
    super.onInit();
  }
}