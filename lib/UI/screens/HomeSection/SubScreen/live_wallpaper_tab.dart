import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/UI/common/common_loader.dart';
import 'package:wallpaper_app/UI/common/grid_image_view.dart';
import 'package:wallpaper_app/UI/common/square_small_icon.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class LiveWallpaperTab extends GetView<HomeController> {
  const LiveWallpaperTab({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async{
        await controller.getLiveWallpaper();
      },
      child: Obx(
        () => controller.liveWallpaperLoading.value
            ? SizedBox(
                height: MediaQuery.sizeOf(context).height * .75,
                child: const CommonLoader(),
              )
            : GridView.builder(
                itemCount: controller.liveWallpapers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 350
                ),
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.sizeOf(context).height * 0.15,
                    left: 20,
                    right: 20,
                    top: 20,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RoutesConstant.liveWallpaperPreviewScreen,arguments: [wallpaperAdsDataList(wallpaper: controller.liveWallpapers),controller.liveWallpapers[index].image]);
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          // alignment: Alignment.bottomLeft,
                          children: [
                            CommonImageView(imageUrl: controller.liveWallpapers[index].thumbnail ?? ""),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Blur(
                                  borderRadius: BorderRadius.circular(1000),
                                  blur: 10,
                                  blurColor: ColorConstants.black,
                                  colorOpacity: .2,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: ColorConstants.white.withOpacity(.25))
                                    ),
                                    child: const SquareSmallButton(
                                      dimension: 24,
                                      imagePath: ImageConstant.liveWallpaperIcon,
                                      iconColor: ColorConstants.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}


class LiveWallpaperTabWrapper extends StatefulWidget {
  const LiveWallpaperTabWrapper({super.key});

  @override
  State<LiveWallpaperTabWrapper> createState() => _LiveWallpaperTabWrapperState();
}

class _LiveWallpaperTabWrapperState extends State<LiveWallpaperTabWrapper> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const LiveWallpaperTab();
  }
}