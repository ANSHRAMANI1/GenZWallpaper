import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/common_background.dart';
import 'package:wallpaper_app/UI/common/common_loader.dart';
import 'package:wallpaper_app/UI/common/custom_appbar.dart';
import 'package:wallpaper_app/UI/common/grid_image_view.dart';
import 'package:wallpaper_app/UI/common/no_data_available_widget.dart';
import 'package:wallpaper_app/UI/screens/CategoriesSection/catregory_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class CategoriesWallpaperScreen extends GetView<CategoryController> {
  const CategoriesWallpaperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: CommonBackground(
        topSpace: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            CustomAppBar(title: Get.arguments),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const CommonLoader()
                    : controller.wallpapers.isEmpty
                        ? const NoDataAvailableWidget()
                        : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              mainAxisExtent: 350,
                            ),
                            itemCount: controller.wallpapers.length,
                            // crossAxisCount: 2,
                            // mainAxisSpacing: 10,
                            // crossAxisSpacing: 10,
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.sizeOf(context).height * 0.15,
                                left: 20,
                                right: 20),
                            itemBuilder: (context, index) {
                              final data = controller.wallpapers[index];
                              return SizedBox(
                                child: GridImageView(
                                  imageUrl: data.thumbnail ?? "",
                                  screen: "category",
                                  premium: data.premium ?? 0,
                                  onTap: () {
                                    // List<WallpaperDataModel> wallpaperDataList = controller.wallpapers;
                                    // for(int i = 0; i<=wallpaperDataList.length;i++){
                                    //   if(i%3 == 2){
                                    //     wallpaperDataList.insert(i, WallpaperDataModel(image: "",category: ""));
                                    //   }
                                    // }
                                    Get.toNamed(
                                        RoutesConstant.wallpaperPreviewScreen,
                                        arguments: [
                                          "category",
                                          wallpaperAdsDataList(wallpaper: controller.wallpapers),
                                          data.image
                                        ]);
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
