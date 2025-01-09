import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/common_seekbar.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/UI/screens/RingtonePreviewSection/ringtone_preview_controller.dart';
import 'package:wallpaper_app/UI/screens/RingtonePreviewSection/widgets/ringtone_image_view.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/UI/common/square_small_icon.dart';
import 'package:wallpaper_app/UI/screens/WallpaperPreviewSection/widgets/preview_bottom_bar.dart';
import 'package:wallpaper_app/infrastructure/AdHelper/banner_ad.dart';
import 'package:wallpaper_app/infrastructure/AdHelper/native_ad.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class RingtonePreviewScreen extends GetView<RingtonePreviewController> {
  const RingtonePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RingtonePreviewController>(
      init: RingtonePreviewController(),
      builder: (controller) {
      return Scaffold(
        backgroundColor: ColorConstants.transparent,
        body: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: Get.height,
              width: Get.width,
              child: controller.ringtones[controller.currentIndex.value].image ==
                  ""
                  ? Container()
                  : CachedNetworkImage(
                        imageUrl: getImageLink(url: controller.ringtones[controller.currentIndex.value].image ?? ""),
                        useOldImageOnUrlChange: true,
                        fit: BoxFit.cover,
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
                      itemCount: controller.ringtones.length,
                      onPageChanged: (value) {
                        controller.previousRingtone.value = controller.ringtones[controller.currentIndex.value].image == ""
                            ? ""
                            : getImageLink(url: controller.ringtones[controller.currentIndex.value].image ?? "");
                        controller.currentIndex.value = value;
                        controller.update();
                        controller.player.pause();
                        if(controller.ringtones[controller.currentIndex.value].image != ""){
                          controller.playSong(url: controller.ringtones[value].ringtone ?? "");
                        }
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
                          child: controller.ringtones[i].image == ""
                              ? const NativeAdView()
                              : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      HeadlineBodyOneBaseWidget(
                                        title: controller.ringtones[i].name ?? "",
                                        titleColor: ColorConstants.white,
                                        fontSize: 24,
                                        fontFamily: FontConstant.satoshiBold,
                                      ),
                                      Obx(
                                        ()=> RingtoneImageView(
                                          showAnimation: controller.currentIndex.value == i,
                                          stopAnimation: controller.isRingtonePlaying.value,
                                          image: controller.ringtones[i].image ?? "",
                                          ringtone: controller.ringtones[i].ringtone ?? "",
                                          onPlayPauseTap: controller.playPauseSong,
                                          playPauseImage: (controller.currentIndex.value == i && controller.isRingtonePlaying.value)
                                              ? ImageConstant.pauseIcon
                                              : ImageConstant.playIcon,
                                        ).paddingSymmetric(vertical: 16),
                                      ),
                                      StreamBuilder<PositionData>(
                                        stream: controller.positionDataStream,
                                        builder: (context, snapshot) {
                                          final positionData = snapshot.data;
                                          if(snapshot.hasData){
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SeekBar(
                                                  height: 2,
                                                  preview: true,
                                                  duration: controller.currentIndex.value == i ? positionData?.duration ?? Duration.zero : Duration.zero,
                                                  position: controller.currentIndex.value == i ? positionData?.position ?? Duration.zero : Duration.zero,
                                                  bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                                                  onChangeEnd: controller.player.seek,
                                                ),
                                                const SizedBox(width: 6),
                                                HeadlineBodyOneBaseWidget(
                                                  title: getDuration(positionData!.duration),
                                                  fontSize: 12,
                                                  maxLine: 1,
                                                  textOverflow: TextOverflow.ellipsis,
                                                  titleColor: ColorConstants.white.withOpacity(.5),
                                                  fontFamily: FontConstant.satoshiMedium,
                                                )
                                              ],
                                            );
                                          } else{
                                            return Container();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                          );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (controller.ringtones[controller.currentIndex.value].image == "")
                    Container()
                  else
                    PreviewBottomBar(
                      onFavouritesTap: controller.onFavouritesTap,
                      onDownloadTap: controller.onDownloadTap,
                      onShareTap: controller.onShareTap,
                      like: controller.ringtones[controller.currentIndex.value].like ?? 0,
                    ).paddingSymmetric(horizontal: 20),
                  SizedBox(height: 12,),

                  // const BannerAdView(),
                ],
              ),
            ),
          ],
        ),
      );
    },);
  }
}
