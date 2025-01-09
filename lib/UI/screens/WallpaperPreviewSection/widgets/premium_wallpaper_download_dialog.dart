import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/UI/common/common_button.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';

class PremiumWallpaperDialog extends StatelessWidget {
  const PremiumWallpaperDialog({super.key, required this.onWatchAdTap, required this.showWatchAd});

  final GestureTapCallback onWatchAdTap;
  final bool showWatchAd;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorConstants.transparent,
      child: Blur(
        blurColor: Colors.black,
        colorOpacity: .4,
        blur: 10,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Blur(
                blurColor: Colors.black,
                colorOpacity: .4,
                blur: 10,
                borderRadius: BorderRadius.circular(36),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.black.withOpacity(.2),
                    border: Border.all(color: ColorConstants.white.withOpacity(.25)),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: (){
                            Get.back();
                          },
                          child: Blur(
                            blurColor: Colors.white,
                            colorOpacity: .1,
                            blur: 20,
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              // alignment: Alignment.topRight,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle
                              ),
                              child: const Icon(Icons.close_rounded,color: ColorConstants.white,),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14,left: 14,right: 14),
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Colors.white,
                                Colors.white.withOpacity(.8),
                                // Colors.transparent.withOpacity(.2),
                                Colors.transparent.withOpacity(.2),
                                Colors.transparent,
                                Colors.transparent,
                              ],
                              stops: const [0.0,.4,0.6,0.9 ,1],
                            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ImageConstant.imgUpdateApp,
                          // child: Image.asset(
                          //   ImageConstant.updateAppImage,
                          //   fit: BoxFit.cover,
                          //   alignment: Alignment.topCenter,
                          //   width: double.maxFinite,
                          // ),
                        ),
                      ),
                      const HeadlineBodyOneBaseWidget(
                        // title: "Get Premium Now",
                        title: "Watch ad now",

                        fontSize: 24,
                        titleColor: ColorConstants.white,
                        fontFamily: FontConstant.satoshiBold,
                        height: 1.25,
                        titleTextAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      HeadlineBodyOneBaseWidget(
                        // title: "Upgrade to premium and get more downloads.",
                        title: "Watch video ad and download wallpaper",
                        fontSize: 14,
                        titleColor: ColorConstants.white.withOpacity(.7),
                        fontFamily: FontConstant.satoshiRegular,
                        height: 1.57,
                        titleTextAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // CommonButton(
                      //   onTap: () {
                      //     Get.back();
                      //     Get.toNamed(RoutesConstant.subscriptionScreen);
                      //   },
                      //   title: "Upgrade to Premium",
                      //   bottomSpace: false,
                      //   updateSpace: true,
                      // ),
                      if(showWatchAd)
                      ...[
                        const SizedBox(height: 6),
                        CommonButton(
                          onTap: onWatchAdTap,
                          title: "Watch Ads",
                          titleColor: ColorConstants.white,
                          backgroundColor: ColorConstants.transparent,
                          bottomSpace: false,
                          updateSpace: true,
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
