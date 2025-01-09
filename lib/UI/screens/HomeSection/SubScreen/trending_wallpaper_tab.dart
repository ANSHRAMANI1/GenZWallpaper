import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/common_loader.dart';
import 'package:wallpaper_app/UI/common/grid_image_view.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/model/wallpaper_data_model.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class TrendingWallpaperTab extends GetView<HomeController> {
  const TrendingWallpaperTab({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async{
        await controller.getTrendingWallpaper();
      },
      child: Obx(
        () => controller.isLoading.value
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
                itemCount: controller.trendingWallpapers.length,
                // crossAxisCount: 2,
                // mainAxisSpacing: 10,
                // crossAxisSpacing: 10,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.sizeOf(context).height * 0.15,
                    left: 20,
                    right: 20,
                    top: 20),
                itemBuilder: (context, index) {
                  final data = controller.trendingWallpapers[index];
                  return SizedBox(
                    child: GridImageView(
                      imageUrl: data.thumbnail ?? "",
                      premium: data.premium ?? 0,
                      onTap: () {
                        Get.toNamed(RoutesConstant.wallpaperPreviewScreen,
                            arguments: [
                              "trending wallpaper",
                              wallpaperAdsDataList(
                                  wallpaper: controller.trendingWallpapers),
                              data.image
                            ]);
                      },
                      screen: 'trending wallpaper',
                    ),
                  );
                },
              ),
      ),
    );
  }
}

/// Trending wallpaper tab wrapper
class TrendingWallpaperTabWrapper extends StatefulWidget {
  const TrendingWallpaperTabWrapper({super.key});

  @override
  State<TrendingWallpaperTabWrapper> createState() =>
      _TrendingWallpaperTabWrapperState();
}

class _TrendingWallpaperTabWrapperState
    extends State<TrendingWallpaperTabWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const TrendingWallpaperTab();
  }
}
