import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/common_background.dart';
import 'package:wallpaper_app/UI/common/common_loader.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/UI/screens/CategoriesSection/widgets/category_card.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';

class CategoriesScreen extends GetView<HomeController> {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: CommonBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadlineBodyOneBaseWidget(
              title: "Categories",
              fontSize: 24,
              titleColor: ColorConstants.white,
              fontFamily: FontConstant.satoshiBold,
            ).paddingSymmetric(vertical: 22,horizontal: 20),
            Expanded(
              child: Obx(
                ()=> controller.isCategoryPlaying.value ? const CommonLoader() : ListView.builder(
                  itemCount: controller.categoriesDataList.length,
                  padding: EdgeInsets.only(
                    right: 20,
                    left: 20,
                    bottom: MediaQuery.sizeOf(context).height * 0.12,
                  ),
                  itemBuilder: (context, index) {
                    return (Platform.isIOS && controller.categoriesDataList[index].category == "Live Wallpaper") ? Container() :CategoryCard(data: controller.categoriesDataList[index]);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
