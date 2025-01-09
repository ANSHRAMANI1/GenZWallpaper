// ignore_for_file: depend_on_referenced_packages

import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wallpaper_app/UI/common/common_seekbar.dart';
import 'package:wallpaper_app/infrastructure/constant/api_constant.dart';
import 'package:wallpaper_app/infrastructure/model/category_date_model.dart';
import 'package:wallpaper_app/infrastructure/model/ringtone_data_model.dart';
import 'package:wallpaper_app/infrastructure/model/wallpaper_data_model.dart';
import 'package:wallpaper_app/infrastructure/services/api_service.dart';
import 'package:wallpaper_app/infrastructure/storage/database_helper.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';
import 'package:rxdart/rxdart.dart' as rx;

class HomeController extends GetxController with GetTickerProviderStateMixin{
  RxList<WallpaperDataModel> wallpapers = <WallpaperDataModel>[].obs;
  RxList<WallpaperDataModel> trendingWallpapers = <WallpaperDataModel>[].obs;
  RxList<WallpaperDataModel> liveWallpapers = <WallpaperDataModel>[].obs;
  RxList<RingtoneDataModel> ringtones = <RingtoneDataModel>[].obs;
  RxList<String> ringtonesDurationDataList = <String>[].obs;
  RxList<CategoryDataModel> categoriesDataList = <CategoryDataModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool ringtoneLoading = true.obs;
  RxBool liveWallpaperLoading = true.obs;
  RxBool categoriesLoading = true.obs;
  RxBool isRingtonePlaying = false.obs;
  RxBool isCategoryPlaying = false.obs;
  DatabaseHelper db = DatabaseHelper();

  final ScrollController sliverScrollController = ScrollController();
  RxBool isPinned = false.obs;

  RxInt selectedRingtoneIndex = (-1).obs;

  setSelectedRingtoneIndexToZero(PositionData? positionData) async{
    await Future.delayed(const Duration(seconds: 1));
    selectedRingtoneIndex.value = (-1);
    update();
  }

  List<WallpaperDataModel> shuffleAndAddEmptyStrings(List<WallpaperDataModel> list) {
    // Shuffle the list randomly
    list.shuffle(Random());

    // Find all empty strings in the list
    List<int> emptyIndices = [];
    for (int i = 0; i < list.length; i++) {
      if (list[i].image == '') emptyIndices.add(i);
    }

    // Ensure index == 3 contains an empty string or add a new one
    for (int i = 0; i < list.length; i++) {
      if (i % 3 == 0) {
        if (emptyIndices.isNotEmpty) {
          // Move an existing empty string to this position
          int emptyIndex = emptyIndices.removeAt(0);
          list[i].image = '';
          if (emptyIndex != i) list[emptyIndex] = list[i]; // Swap logic if needed
        } else {
          // Add a new empty string at index if none exist
          list.insert(i, WallpaperDataModel(image: '',category: '',like: 0,premium: 0,thumbnail: ''));
        }
      }
    }

    return list;
  }

  final player = AudioPlayer();
  playSong({required String url})async{
    player.pause();
    if(!player.playing){
      final duration = await player.setUrl(url);
      dev.log("Duration of song ${duration!.inSeconds}");
    }
    isRingtonePlaying.value = true;
    player.play();
    update();
  }

  playPauseSong(){
    if(player.playing){
      player.pause();
      rotationController.stop(canceled: false);
      isRingtonePlaying.value = false;
    }else{
      player.play();
      rotationController.forward();
      rotationController.repeat();
      isRingtonePlaying.value = true;
    }
    update();
  }

  late AnimationController rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();

  Stream<PositionData> get positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));


  getWallpaper() async {
    wallpapers.value = await saveWallpaperToLocal(await ApiService.getWallpapers(workSheetId: 0));
    dev.log("User wallpaper data value ===> ${wallpapers.map((e)=>e.image).toList()}");

    wallpapers.shuffle();
  }

  getTrendingWallpaper() async {
    trendingWallpapers.value = await saveWallpaperToLocal(await ApiService.getWallpapers(workSheetId: ApiConstant.trendingSheetId));

    trendingWallpapers.shuffle();
  }

  getLiveWallpaper() async{
    liveWallpaperLoading.value = true;
    liveWallpapers.value = await ApiService.getWallpapers(workSheetId: ApiConstant.liveWallpaperSheetId);
    liveWallpaperLoading.value = false;
  }

  getRingtone() async {
    ringtoneLoading.value = true;
    ringtones.value = await saveRingtoneToLocal(await ApiService.getRingtone());
    ringtones.shuffle();
    await getRingtoneDurationData();
    ringtoneLoading.value = false;
    update();
  }

  final demo = AudioPlayer();

  Future<String> getRingtoneDuration({required String url})async{
    try{
      final duration = await player.setUrl(url);
      return getDuration(duration!);
    } catch(e){
      Exception(e);
      return "";
    }
  }

  getCategories()async{
    isCategoryPlaying.value = true;
    categoriesDataList.value = await ApiService.getCategories();
    isCategoryPlaying.value = false;
  }

  Future<void> getRingtoneDurationData()async{
      for(var d in ringtones){
        ringtonesDurationDataList.add(await getRingtoneDuration(url: getImageLink(url: d.ringtone ?? "")));
      }
  }

  init() async{
    getCategories();
    getTrendingWallpaper();
    if(Platform.isAndroid){
      getLiveWallpaper();
    }
    isLoading.value = true;
    await getWallpaper();
    isLoading.value = false;
    await getRingtone();
  }

  @override
  void onInit() async{
    super.onInit();
    await init();
    sliverScrollController.addListener(() {
      if (sliverScrollController.hasClients &&
          sliverScrollController.offset > kToolbarHeight) {
        if(!isPinned.value){
          isPinned.value = true;
          update();
        }
      } else if (sliverScrollController.hasClients &&
          sliverScrollController.offset < kToolbarHeight) {
        if(isPinned.value){
          isPinned.value = false;
          update();
        }
      }
    });
  }
}