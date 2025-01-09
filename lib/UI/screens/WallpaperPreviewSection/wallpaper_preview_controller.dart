import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_controller.dart';
import 'package:wallpaper_app/UI/screens/ProfileSection/profile_controller.dart';
import 'package:wallpaper_app/UI/screens/WallpaperPreviewSection/widgets/premium_wallpaper_download_dialog.dart';
import 'package:wallpaper_app/infrastructure/model/wallpaper_data_model.dart';
import 'package:wallpaper_app/infrastructure/storage/database_helper.dart';
import 'package:wallpaper_app/infrastructure/storage/shared_preference_service.dart';
import 'package:wallpaper_app/infrastructure/utils/image_downloader.dart';

class WallpaperPreviewController extends GetxController {
  RxString screen = "".obs;
  RxList<WallpaperDataModel> wallpapers = <WallpaperDataModel>[].obs;
  RxInt currentIndex = 0.obs;
  RxString previousWallpaper = "".obs;

  PageController pageController = PageController();

  onDownloadTap() async{
    if(wallpapers[currentIndex.value].premium == 1){
      String premiumLimit = await SharedPreferenceService.getPremiumWallpaperLimit;
      Get.dialog(
        PremiumWallpaperDialog(
          showWatchAd: int.parse(premiumLimit) < 5,
          onWatchAdTap: () async {
            Get.back();
            await ImageDownloader.downloadImage(wallpapers[currentIndex.value].image ?? ""/*,showRewardAd: true*/);
          },
        ),
      );
    } else{
      await ImageDownloader.downloadImage(wallpapers[currentIndex.value].image ?? "");
    }
  }

  onShareTap() async {
    if(wallpapers[currentIndex.value].premium == 1) {
      String premiumLimit = await SharedPreferenceService.getPremiumWallpaperLimit;
      Get.dialog(
        PremiumWallpaperDialog(
          showWatchAd: int.parse(premiumLimit) < 5,
          onWatchAdTap: () async {
            Get.back();
            ImageDownloader.shareImage(wallpapers[currentIndex.value].image ?? "");
          },
        ),
      );
    }else{
      ImageDownloader.shareImage(wallpapers[currentIndex.value].image ?? "");
    }
  }

  onFavouritesTap() async{
    DatabaseHelper db = DatabaseHelper();

    // List<WallpaperDataModel> sampleDataList = await db.getWallpaperFavouritesData();
    //
    // WallpaperDataModel wallpaperDataModel = sampleDataList[sampleDataList.indexWhere((element) => element.image == wallpapers[currentIndex.value].image)];

    if(wallpapers[currentIndex.value].like == 0){
      db.insertWallpaperFavourites(
        WallpaperDataModel(
          image: wallpapers[currentIndex.value].image ?? "",
          thumbnail: wallpapers[currentIndex.value].thumbnail ?? "",
          like: 1,
          category: wallpapers[currentIndex.value].category ?? "",
          premium: wallpapers[currentIndex.value].premium ?? 0,
        ),
      );
    }else{
      db.deleteWallpaperFavourites(
        WallpaperDataModel(
          image: wallpapers[currentIndex.value].image ?? "",
          thumbnail: wallpapers[currentIndex.value].thumbnail ?? "",
          like: 1,
          category: wallpapers[currentIndex.value].category ?? "",
          premium: wallpapers[currentIndex.value].premium ?? 0,
        ),
      );
    }

    wallpapers[currentIndex.value].like = wallpapers[currentIndex.value].like == 1 ? 0 : 1;
    update();

    // if(screen.value != "home"){
    //   Get.find<HomeController>().getWallpaper();
    //   Get.find<HomeController>().getTrendingWallpaper();
    // }
    if(screen.value == "profile"){
      Get.find<ProfileController>().getFavouritesWallpaper();
      Get.find<HomeController>().getWallpaper();
      Get.find<HomeController>().getTrendingWallpaper();
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      screen.value = Get.arguments[0];
      wallpapers.value = Get.arguments[1];
      currentIndex.value = wallpapers.indexWhere((element) => element.image == Get.arguments[2]);
      pageController = PageController(
          initialPage: currentIndex.value,
          viewportFraction: .75,
          keepPage: true);
      // addAdsBetweenWallpapers();
    }
  }
}
