// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wallpaper_app/UI/common/common_seekbar.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_controller.dart';
import 'package:wallpaper_app/UI/screens/ProfileSection/profile_controller.dart';
import 'package:wallpaper_app/infrastructure/model/ringtone_data_model.dart';
import 'package:wallpaper_app/infrastructure/storage/database_helper.dart';
import 'package:wallpaper_app/infrastructure/utils/ringtone_downloader.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class RingtonePreviewController extends GetxController{

  RxString screen = "".obs;
  RxList<RingtoneDataModel> ringtones = <RingtoneDataModel>[].obs;
  RxInt currentIndex = 0.obs;

  RxString previousRingtone = "".obs;

  RxBool isRingtonePlaying = true.obs;

  PageController pageController = PageController();

  // late AnimationController rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();

  final player = AudioPlayer();
  playSong({required String url})async{
    player.pause();
    if(!player.playing){
      // ignore: unused_local_variable
      final duration = await player.setUrl(getImageLink(url: url));
    }
    player.setLoopMode(LoopMode.all);
    player.play();
  }

  Stream<PositionData> get positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  playPauseSong(){
    if(player.playing){
      player.pause();
      // rotationController.stop(canceled: false);
      isRingtonePlaying.value = false;
    }else{
      player.play();
      // rotationController.forward();
      // rotationController.repeat();
      isRingtonePlaying.value = true;

    }
    update();
  }

  onDownloadTap() async{
    // showLoadingDialog();
    // AdHelper.createRewardedAd(
    //   onDismissed: () {},
    //   onUserEarnedReward: () async {
    //     Get.back();
    //
    //     bool photos = await Permission.photos.isGranted;
    //     bool storage = await Permission.storage.isGranted;
    //
    //     if (photos || storage) {
    //       showSnackbar(msg: "Ringtone Downloading");
    await RingtoneDownloader.downloadRingtone(ringtones[currentIndex.value].image ?? "",playPauseSong);
    //     } else {
    //       await Permission.photos.request();
    //       await Permission.storage.request();
    //       showSnackbar(msg: "Ringtone Downloading");
    //       await RingtoneDownloader.downloadRingtone(
    //           ringtones[currentIndex.value].image ?? "");
    //     }
    //   },
    // );
  }

  onShareTap() async {
    RingtoneDownloader.shareRingtone(ringtones[currentIndex.value].image ?? "");
  }

  onFavouritesTap() async{
    DatabaseHelper db = DatabaseHelper();

    // List<RingtoneDataModel> sampleDataList = await db.getRingtoneFavouritesData();
    //
    // RingtoneDataModel ringtoneDataModel = sampleDataList[sampleDataList.indexWhere((element) => element.image == ringtones[currentIndex.value].image)];

    if(ringtones[currentIndex.value].like == 0){
      db.insertRingtoneFavourites(
        RingtoneDataModel(
            image: ringtones[currentIndex.value].image ?? "",
            like: 1,
            premium: ringtones[currentIndex.value].premium ?? 0,
            ringtone: ringtones[currentIndex.value].ringtone ?? "",
            name: ringtones[currentIndex.value].name ?? "",
        ),
      );
    } else{
      db.deleteRingtoneFavourites(
        RingtoneDataModel(
          image: ringtones[currentIndex.value].image ?? "",
          like: 0,
          premium: ringtones[currentIndex.value].premium ?? 0,
          ringtone: ringtones[currentIndex.value].ringtone ?? "",
          name: ringtones[currentIndex.value].name ?? "",
        ),
      );
    }

    ringtones[currentIndex.value].like = ringtones[currentIndex.value].like == 1 ? 0 : 1;
    update();

    // if(screen.value != "home"){
    //   Get.find<HomeController>().getRingtone();
    // }
    if(screen.value == "profile"){
      Get.find<ProfileController>().getFavouritesRingtone();
      Get.find<HomeController>().getRingtone();
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      screen.value = Get.arguments[0];
      ringtones.value = Get.arguments[1];
      currentIndex.value = ringtones.indexWhere((element) => element.ringtone == Get.arguments[2]);
      pageController = PageController(
          initialPage: currentIndex.value,
          viewportFraction: .85,
          keepPage: true,
      );
      playSong(url: ringtones[currentIndex.value].ringtone ?? "");
      // addAdsBetweenWallpapers();
    }
  }


  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
