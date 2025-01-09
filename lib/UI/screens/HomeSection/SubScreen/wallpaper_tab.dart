import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/common_loader.dart';
import 'package:wallpaper_app/UI/common/grid_image_view.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class WallpaperTabScreen extends GetView<HomeController> {
  const WallpaperTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RefreshIndicator.adaptive(
        onRefresh: () async{
          await controller.getWallpaper();
        },
        child: controller.isLoading.value
            ? SizedBox(
                height: MediaQuery.sizeOf(context).height * .75,
                child: const CommonLoader(),
              )
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
                padding: EdgeInsets.only(
                    bottom: MediaQuery.sizeOf(context).height * 0.15,
                    left: 20,
                    right: 20,
                    top: 20,
                ),
                itemBuilder: (context, index) {
                  final data = controller.wallpapers[index];
                  return GridImageView(
                    imageUrl: data.thumbnail ?? "",
                    premium: data.premium ?? 0,
                    onTap: () {

                      Get.toNamed(RoutesConstant.wallpaperPreviewScreen,
                          arguments: [
                            "home",
                            wallpaperAdsDataList(wallpaper: controller.wallpapers),
                            data.image
                          ]);
                    },
                    screen: 'home',
                  );
                },
              ),
      ),
    );
  }
}


///wallpapers tab
class WallpaperTabWrapper extends StatefulWidget {
  const WallpaperTabWrapper({super.key});

  @override
  State<WallpaperTabWrapper> createState() => _WallpaperTabWrapperState();
}

class _WallpaperTabWrapperState extends State<WallpaperTabWrapper> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const WallpaperTabScreen();
  }
}