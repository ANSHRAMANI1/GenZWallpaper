import 'dart:async';

import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wallpaper_app/UI/screens/SplashSection/widgets/update_app_dialog.dart';
import 'package:wallpaper_app/infrastructure/constant/api_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/package/open_store.dart';
import 'package:wallpaper_app/infrastructure/services/google_sheet_service.dart';
import 'package:wallpaper_app/infrastructure/storage/shared_preference_service.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class SplashController extends GetxController {

  @override
  void onInit() async {
    super.onInit();
    setPremiumWallpaperLimit();
    getVersion();
  }

  RxString versionCode = "".obs;

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // try{
      Worksheet? productSheet = await GoogleSheetService.initWallpapers(workSheetId: ApiConstant.versionCodeId);
      final values = (await productSheet!.values.allRows())
          .skip(1)
          .toList();
      for (var data in values) {
        versionCode.value = data[0];
      }
    // } catch(e){
    //   Exception(e);
    // }

      await Future.delayed(const Duration(milliseconds: 1000));
      bool onboardingValue =
      await SharedPreferenceService.getShowOnboardingScreen;
      // _connectivitySubscription.cancel();
      Get.offAllNamed(onboardingValue
          ? RoutesConstant.onboardingScreen
          : RoutesConstant.mainScreen);
      // if(versionCode.value != ""){
      //   if (versionCode.value != packageInfo.version) {
      //     showUpdateDialog(packageInfo.packageName, "284815942");
      //   }
      // }
  }

  setPremiumWallpaperLimit() async{
    String date = await SharedPreferenceService.getDate;
    DateTime now = DateTime.now();
    String todayDate = getDate(now);

    if(date != todayDate){
      await SharedPreferenceService.saveDate(getDate(now));
      await SharedPreferenceService.savePremiumWallpaperLimit(0.toString());
    }
  }

  void showUpdateDialog(
      String androidApplicationId,
      String iOSAppId, {
        String message = "You can now update this app from store.",
        String titleText = 'Update Available',
        String dismissText = 'Later',
        String updateText = 'Update Now',
      }) async {
    updateAction() {
      launchAppStore(androidApplicationId, iOSAppId);
    }
    Get.dialog(
      UpdateAppDialogView(onUpdateTap: updateAction),
      useSafeArea: false,
      barrierDismissible: false
    );
  }

  void launchAppStore(String androidApplicationId, String iOSAppId) async {
    OpenStore.instance.open(
      appStoreId: iOSAppId,
      androidAppBundleId: androidApplicationId,
    );
  }
}
