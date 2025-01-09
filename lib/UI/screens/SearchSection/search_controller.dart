import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/model/search_carousel_data_model.dart';
import 'package:wallpaper_app/infrastructure/model/wallpaper_data_model.dart';
import 'package:wallpaper_app/infrastructure/services/api_service.dart';

class SearchScreenController extends GetxController{
  RxList<WallpaperDataModel> wallpapersDataList = <WallpaperDataModel>[].obs;
  RxList<WallpaperDataModel> wallpapers = <WallpaperDataModel>[].obs;
  RxList<SearchCarouselDataModel> searchCarouselDataList = <SearchCarouselDataModel>[].obs;
  RxBool isLoading = false.obs;

  PageController pageController = PageController(initialPage: 1000);
  RxInt selectedPageIndex = 0.obs;

  animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
    );
  }

  RxList carouselImageList = [
    ImageConstant.animeImage,
    ImageConstant.abstractImage,
    ImageConstant.carsImage,
    ImageConstant.natureImage,
    ImageConstant.gamesImage,
    ImageConstant.photographyImage,
  ].obs;

  var focusNode = FocusNode();
  final txtSearch = TextEditingController();

  filterWallpaper({required String value}) async {
    isLoading.value = true;
    if (value != "") {
      wallpapers.value = wallpapersDataList.where((element) =>
          element.category!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    isLoading.value = false;
  }

  getCarouselData() async{
    searchCarouselDataList.value = await ApiService.getSearchCarousel();
  }

  getWallpaper() async{
    isLoading.value = true;
    wallpapersDataList.value = Get.find<HomeController>().wallpapers.isNotEmpty?Get.find<HomeController>().wallpapers:[];
    wallpapers.value = wallpapersDataList;
    isLoading.value = false;
  }

  changePage(){
    Timer.periodic(const Duration(seconds: 2), (timer) {
      animateToPage(selectedPageIndex.value++);
    });
  }

  RxBool searchClick = false.obs;

  init(){
    pageController = PageController(initialPage: searchCarouselDataList.length * 1000);
    selectedPageIndex.value = searchCarouselDataList.length * 1000;
    changePage();
    getWallpaper();
    searchClick.value = true;
  }

  @override
  void onInit() async{
    super.onInit();
    await getCarouselData();
  }
}

extension ListX<E> on List {
  E loop(int index) => this[index % length];
}