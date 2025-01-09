// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wallpaper_app/UI/common/common_seekbar.dart';
import 'package:wallpaper_app/infrastructure/model/ringtone_data_model.dart';
import 'package:wallpaper_app/infrastructure/model/wallpaper_data_model.dart';
import 'package:wallpaper_app/infrastructure/storage/database_helper.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class ProfileController extends GetxController with GetSingleTickerProviderStateMixin{

  RxList<WallpaperDataModel> wallpapers = <WallpaperDataModel>[].obs;
  RxList<RingtoneDataModel> ringtones = <RingtoneDataModel>[].obs;
  RxList<String> ringtonesDurationDataList = <String>[].obs;

  RxBool isLoading = true.obs;
  RxBool ringtoneLoading = true.obs;
  RxBool categoriesLoading = true.obs;
  RxBool isRingtonePlaying = false.obs;
  DatabaseHelper db = DatabaseHelper();

  RxInt selectedRingtoneIndex = (-1).obs;

  getFavouritesWallpaper() async{

    isLoading.value = true;
    wallpapers.clear();
    wallpapers.value = await DatabaseHelper().getWallpaperFavouritesData();
    // for(var d in demoDataList){
    //   wallpapers.addIf(d.like == 1, d);
    // }
    isLoading.value = false;
  }

  getFavouritesRingtone() async{

    ringtoneLoading.value = true;
    ringtones.clear();
    ringtones.value = await DatabaseHelper().getRingtoneFavouritesData();
    // for(var d in demoDataList){
    //   ringtones.addIf(d.like == 1, d);
    // }
    await getRingtoneDurationData();
    ringtoneLoading.value = false;
    update();
  }

  final player = AudioPlayer();
  playSong({required String url})async{
    player.pause();
    if(!player.playing){
      final duration = await player.setUrl(url);
      log("Duration of song ${duration!.inSeconds}");
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

  Future<String> getRingtoneDuration({required String url})async{
    final duration = await player.setUrl(url);
    log("Duration of song ${duration!.inSeconds}");
    return getDuration(duration);
  }

  Future<void> getRingtoneDurationData()async{
    for(var d in ringtones){
      ringtonesDurationDataList.add(await getRingtoneDuration(url: d.ringtone ?? ""));
    }
  }

  late AnimationController rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();

  Stream<PositionData> get positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void onInit() {
    super.onInit();
    getFavouritesWallpaper();
    getFavouritesRingtone();
  }

  @override
  void onClose() {
    rotationController.dispose();
    super.onClose();
  }
}