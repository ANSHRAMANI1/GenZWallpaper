import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/UI/common/square_small_icon.dart';
import 'package:wallpaper_app/UI/screens/LiveWallpaperPreviewSection/live_wallpaper_preview_controller.dart';
import 'package:wallpaper_app/infrastructure/AdHelper/banner_ad.dart';
import 'package:wallpaper_app/infrastructure/AdHelper/native_ad.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class LiveWallpaperPreviewScreen extends GetView<LiveWallpaperPreviewController> {
  const LiveWallpaperPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveWallpaperPreviewController>(
        init: LiveWallpaperPreviewController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: Get.height,
                  width: Get.width,
                  child: controller.wallpapers[controller.currentIndex.value].image == ""
                      ? Container(color: ColorConstants.black,)
                      : Container(
                          width: double.maxFinite,
                          color: ColorConstants.background,
                          child: Image.network(getImageLink(url: controller.wallpapers[controller.currentIndex.value].thumbnail ?? ""),fit: BoxFit.cover),
                          // child: VideoPlayer(controller.videoPlayerController),
                        ),
                ),
                Blur(
                  blurColor: Colors.black,
                  colorOpacity: .4,
                  blur: 16,
                  child: SizedBox(
                    height: Get.height,
                    width: Get.width,
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Get.back(),
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: ColorConstants.white.withOpacity(.1),
                              border: Border.all(
                                  color: ColorConstants.white.withOpacity(.25)),
                              shape: BoxShape.circle,
                            ),
                            child: const SquareSmallButton(
                              imagePath: ImageConstant.backIcon,
                              dimension: 20,
                              iconColor: ColorConstants.white,
                            ),
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 20, vertical: 20),
                      Expanded(
                        child: PageView.builder(
                          controller: controller.pageController,
                          itemCount: controller.wallpapers.length,
                          onPageChanged: (value) {
                            controller.currentIndex.value = value;
                            controller.videoPlayerController.dispose();
                            if(controller.wallpapers[value].image != ""){
                              controller.initVideoPlayer(controller.wallpapers[value].image ?? "");
                            }
                            controller.update();
                          },
                          itemBuilder: (context, index) {
                            var scale = controller.currentIndex.value == index ? 1.0 : 0.9;
                            return TweenAnimationBuilder(
                              tween: Tween(begin: scale, end: scale),
                              duration: const Duration(milliseconds: 200),
                              builder: (context, double value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: child,
                                );
                              },
                              child: controller.wallpapers[index].image == ""
                                  ? const NativeAdView()
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: controller.currentIndex.value != index
                                    ? Image.network(getImageLink(url: controller.wallpapers[index].thumbnail ?? ""),fit: BoxFit.cover)
                                    // ? CommonImageView(imageUrl: controller.wallpapers[index].thumbnail ?? "")
                                    : controller.isVideoLoaded.value
                                        ? Container(
                                            width: double.maxFinite,
                                            // color: ColorConstants.background,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(getImageLink(url: controller.wallpapers[index].thumbnail ?? ""),),
                                                fit: BoxFit.cover
                                              )
                                            ),
                                            child: VideoPlayer(controller.videoPlayerController),
                                          )
                                        : Image.network(getImageLink(url: controller.wallpapers[index].thumbnail ?? ""),fit: BoxFit.cover),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (controller.wallpapers[controller.currentIndex.value].image ==
                          "")
                        Container()
                      else
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(
                              color: ColorConstants.white.withOpacity(.25),
                            ),
                          ),
                          child: Blur(
                            blurColor: Colors.black,
                            colorOpacity: .25,
                            borderRadius: BorderRadius.circular(100),
                            blur: 10,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(200),
                              onTap: controller.onDownloadTap,
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                margin: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: ColorConstants.white,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  ImageConstant.downloadIcon,
                                ),
                              ),
                            ),
                          ),
                        ).paddingSymmetric(horizontal: 20,),
                      SizedBox(height: 12,),
                      // const BannerAdView(),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
