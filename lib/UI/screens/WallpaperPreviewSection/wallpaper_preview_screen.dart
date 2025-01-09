// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/UI/common/grid_image_view.dart';
import 'package:wallpaper_app/UI/common/premium_badge.dart';
import 'package:wallpaper_app/UI/common/square_small_icon.dart';
import 'package:wallpaper_app/UI/screens/WallpaperPreviewSection/wallpaper_preview_controller.dart';
import 'package:wallpaper_app/UI/screens/WallpaperPreviewSection/widgets/preview_bottom_bar.dart';
import 'package:wallpaper_app/infrastructure/AdHelper/banner_ad.dart';
import 'package:wallpaper_app/infrastructure/AdHelper/native_ad.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class WallpaperPreviewScreen extends GetView<WallpaperPreviewController> {
  const WallpaperPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpaperPreviewController>(
      init: WallpaperPreviewController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConstants.transparent,
          body: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: Get.height,
                width: Get.width,
                child: controller.wallpapers[controller.currentIndex.value]
                            .image ==
                        ""
                    ? Container()
                    // : Image.network(
                    //     getImageLink(url: controller.wallpapers[controller.currentIndex.value].image ?? ""),
                    //     fit: BoxFit.cover),
                : CachedNetworkImage(
                        imageUrl: getImageLink(url: controller.wallpapers[controller.currentIndex.value].thumbnail ?? ""),
                        useOldImageOnUrlChange: true,
                        fit: BoxFit.cover),
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
                          controller.previousWallpaper.value = controller.wallpapers[controller.currentIndex.value].thumbnail == ""
                              ? ""
                              : getImageLink(url: controller.wallpapers[controller.currentIndex.value].thumbnail ?? "");
                          controller.currentIndex.value = value;
                          controller.update();
                        },
                        itemBuilder: (context, i) {
                          var scale =
                              controller.currentIndex.value == i ? 1.0 : 0.9;
                          return TweenAnimationBuilder(
                            tween: Tween(begin: scale, end: scale),
                            duration: const Duration(milliseconds: 200),
                            builder: (context, double value, child) {
                              return Transform.scale(
                                scale: value,
                                child: child,
                              );
                            },
                            child: controller.wallpapers[i].image == ""
                                ? const NativeAdView()
                                : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  // child: Image.network(
                                  //   getImageLink(url: controller.wallpapers[i].image ?? ""),
                                  //   fit: BoxFit.cover,
                                  //   height: 350,
                                  //   // placeholder: (context, url) => Image.asset(ImageConstant.placeholderImg,fit: BoxFit.cover,height: 350),
                                  // ),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Hero(
                                        tag: controller.screen + controller.wallpapers[i].thumbnail!,
                                        child: CommonImageView(imageUrl: controller.wallpapers[i].thumbnail ?? ""),
                                        // child: CachedNetworkImage(
                                        //   imageUrl: getImageLink(url: controller.wallpapers[i].thumbnail ?? ""),
                                        //   fit: BoxFit.cover,
                                        //   height: 350,
                                        //   placeholder: (context, url) => Image.asset(ImageConstant.placeholderImg,fit: BoxFit.cover,height: 350),
                                        // ),
                                      ),
                                      if(controller.wallpapers[i].premium == 1)
                                        const Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.all(6),
                                            child: PremiumBadge(),
                                          ),
                                        ),
                                    ],
                                  ),
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
                      PreviewBottomBar(
                        onFavouritesTap: controller.onFavouritesTap,
                        onDownloadTap: controller.onDownloadTap,
                        onShareTap: controller.onShareTap,
                        like: controller.wallpapers[controller.currentIndex.value].like ?? 0,
                      ).paddingSymmetric(horizontal: 20),
                    SizedBox(height: 12,),

                    // const BannerAdView(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


/*

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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(200),
                                onTap: controller.onFavouritesTap,
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  margin: const EdgeInsets.all(4),
                                  child: SvgPicture.asset(
                                    controller.wallpapers[controller.currentIndex.value].like == 1 ? ImageConstant.filledLikeIcon : ImageConstant.noFillLikeIcon,
                                  ),
                                ),
                              ),
                              InkWell(
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
                              InkWell(
                                onTap: controller.onShareTap,
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  margin: const EdgeInsets.all(4),
                                  child: SvgPicture.asset(
                                    ImageConstant.shareIcon,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )

*/