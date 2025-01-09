import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/common_loader.dart';
import 'package:wallpaper_app/UI/common/common_seekbar.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/UI/common/no_data_available_widget.dart';
import 'package:wallpaper_app/UI/common/square_small_icon.dart';
import 'package:wallpaper_app/UI/screens/ProfileSection/profile_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/utils/ringtone_downloader.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class LikedRingtoneTabScreen extends GetView<ProfileController> {
  const LikedRingtoneTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return controller.ringtoneLoading.value
            ? SizedBox(
                height: MediaQuery.sizeOf(context).height * .75,
                child: const CommonLoader(),
              )
            : controller.ringtones.isEmpty
                ? const NoDataAvailableWidget()
                : ListView.builder(
                    itemCount: controller.ringtones.length,
                    padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 16,
                        bottom: MediaQuery.sizeOf(context).height * 0.15),
                    itemBuilder: (context, index) {
                      final data = controller.ringtones[index];
                      return InkWell(
                        onTap: (){
                          Get.toNamed(RoutesConstant.ringtonePreviewScreen,arguments: [
                            "profile",
                            ringtoneAdsDataList(ringtone: controller.ringtones),
                            data.ringtone
                          ]);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: ColorConstants.white.withOpacity(.1),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              AnimatedBuilder(
                                animation: controller.rotationController,
                                builder: (context, child) {
                                  return controller.selectedRingtoneIndex.value == index ? Transform.rotate(
                                    angle: controller.rotationController.value * 2 * math.pi,
                                    child: child,
                                  ) : Container(child: child);
                                },
                                child: SizedBox(
                                  height: 44,
                                  width: 44,
                                  child: Stack(
                                    children: [
                                      Hero(
                                        tag: "home${getImageLink(url: data.ringtone ?? "")}",
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(1000),
                                          child: CachedNetworkImage(
                                            imageUrl: getImageLink(url: data.image ?? ""),
                                            fit: BoxFit.cover,
                                            height: 44,
                                            width: 44,
                                            placeholder: (context, url) => Image.asset(ImageConstant.placeholderImg,fit: BoxFit.cover,height: 44,width: 44,),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(1),
                                        margin: const EdgeInsets.all(16),
                                        decoration: const BoxDecoration(
                                          color: ColorConstants.orange,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: ColorConstants.black,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    HeadlineBodyOneBaseWidget(
                                      title: data.name,
                                      fontSize: 16,
                                      maxLine: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      titleColor: ColorConstants.white,
                                      fontFamily: FontConstant.satoshiMedium,
                                    ),
                                    controller.selectedRingtoneIndex.value == index
                                        ? SizedBox(
                                      height: 18,
                                      child: StreamBuilder<PositionData>(
                                        stream: controller.positionDataStream,
                                        builder: (context, snapshot) {
                                          final positionData = snapshot.data;
                                          if(snapshot.data != null){
                                            if(snapshot.data!.duration == snapshot.data!.position){
                                              Timer(const Duration(seconds: 1),() {
                                                controller.selectedRingtoneIndex.value = (-1);
                                                controller.isRingtonePlaying.value = false;
                                                controller.update();
                                              },);
                                            }
                                          }
                                          return SeekBar(
                                            duration: positionData?.duration ?? Duration.zero,
                                            position: positionData?.position ?? Duration.zero,
                                            bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                                            onChangeEnd: controller.player.seek,
                                          );
                                        },
                                      ),
                                    )
                                        : HeadlineBodyOneBaseWidget(
                                      title: controller.ringtonesDurationDataList[index],
                                      fontSize: 12,
                                      maxLine: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      titleColor: ColorConstants.white.withOpacity(.5),
                                      fontFamily: FontConstant.satoshiMedium,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(1000),
                                onTap: (controller.selectedRingtoneIndex.value == index && controller.isRingtonePlaying.value)
                                    ? () => controller.playPauseSong()
                                    : () {
                                  if (controller.selectedRingtoneIndex.value != index) {
                                    controller.selectedRingtoneIndex.value = index;
                                    controller.playSong(url: data.ringtone ?? "");
                                  } else {
                                    controller.playPauseSong();
                                  }
                                },
                                child: SquareSmallButton(
                                  dimension: 24,
                                  imagePath: (controller.selectedRingtoneIndex.value == index && controller.isRingtonePlaying.value)
                                      ? ImageConstant.pauseIcon
                                      : ImageConstant.playIcon,
                                  iconColor: ColorConstants.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              InkWell(
                                onTap: () async{
                                  await RingtoneDownloader.downloadRingtone(data.ringtone ?? "",controller.playPauseSong);
                                },
                                borderRadius: BorderRadius.circular(1000),
                                child: const SquareSmallButton(
                                  dimension: 24,
                                  imagePath: ImageConstant.ringtoneDownloadIcon,
                                  iconColor: ColorConstants.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
      },
    );
  }
}
