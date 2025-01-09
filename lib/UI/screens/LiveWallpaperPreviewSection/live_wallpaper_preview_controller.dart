import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:wallpaper_app/UI/common/common_snackbar.dart';
import 'package:wallpaper_app/infrastructure/model/wallpaper_data_model.dart';
import 'package:wallpaper_app/infrastructure/utils/image_downloader.dart';

class LiveWallpaperPreviewController extends GetxController{

  RxList<WallpaperDataModel> wallpapers = <WallpaperDataModel>[].obs;
  RxInt currentIndex = 0.obs;
  RxString previousWallpaper = "".obs;
  
  PageController pageController = PageController();

  late VideoPlayerController videoPlayerController;

  RxBool isVideoLoaded = false.obs;

  onDownloadTap() async{
    bool photos = await Permission.photos.isGranted;
    bool storage = await Permission.storage.isGranted;

    if (photos || storage) {
      showSnackbar(msg: "Setting Wallpaper...");
      await ImageDownloader.setLiveWallpaper(
          wallpapers[currentIndex.value].image ?? "");
    } else {
      await Permission.photos.request();
      await Permission.storage.request();
      showSnackbar(msg: "Setting Wallpaper...");
      await ImageDownloader.setLiveWallpaper(
          wallpapers[currentIndex.value].image ?? "");
    }
  }

  initVideoPlayer(String url){
    isVideoLoaded.value = false;
    update();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize()
      ..setLooping(true).then((_) {
        isVideoLoaded.value = true;
          videoPlayerController.setVolume(0);
          videoPlayerController.play();
          update();
      });
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      wallpapers.value = Get.arguments[0];
      currentIndex.value = wallpapers.indexWhere((element) => element.image == Get.arguments[1]);
      pageController = PageController(
          initialPage: currentIndex.value,
          viewportFraction: .75,
      );

      initVideoPlayer(wallpapers[currentIndex.value].image ?? "");
      // addAdsBetweenWallpapers();
    }
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayerController.dispose();
  }
}