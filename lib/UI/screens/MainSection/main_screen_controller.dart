import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/infrastructure/utils/notification_manager.dart';

class MainScreenController extends GetxController{
  RxInt selectedIndex = 0.obs;

  final pageController = PageController();

  animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeIn,
    );
  }

  void selectIndex(int index) => selectedIndex.value = index;

  @override
  void onInit() async{
    super.onInit();
    await NotificationManager.requestNotificationPermissions();
  }
}