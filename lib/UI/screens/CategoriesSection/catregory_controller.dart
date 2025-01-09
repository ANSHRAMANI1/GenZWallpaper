import 'dart:developer';

import 'package:get/get.dart';
import 'package:wallpaper_app/infrastructure/constant/api_constant.dart';
import 'package:wallpaper_app/infrastructure/model/wallpaper_data_model.dart';
import 'package:wallpaper_app/infrastructure/services/api_service.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class CategoryController extends GetxController{
  RxList<WallpaperDataModel> wallpapers = <WallpaperDataModel>[].obs;
  RxBool isLoading = true.obs;

  getWallpaper(String category) async {
    isLoading.value = true;
    List<WallpaperDataModel> data = await saveWallpaperToLocal(await ApiService.getWallpapers(workSheetId: getCategoryId(category)));
    wallpapers.value = data.where((element) => element.category?.toLowerCase() == category.toLowerCase()).toList();
    log(wallpapers.toString());
    wallpapers.shuffle();
    isLoading.value = false;
  }

  int getCategoryId(String category) {
    int sheetId = 0;
    switch (category) {
      case "4K":
        sheetId = ApiConstant.animeSheetId;
        break;
      case "Nature":
        sheetId = ApiConstant.assassinsCreedSheetId;
        break;
      case "Galaxy":
        sheetId = ApiConstant.godOfWarSheetId;
        break;
      case "Flower":
        sheetId = ApiConstant.futuristicSheetId;
        break;
    }
    return sheetId;
  }

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null){
      getWallpaper(Get.arguments);
    }
  }
}