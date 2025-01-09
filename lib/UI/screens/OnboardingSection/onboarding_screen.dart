import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/common_background.dart';
import 'package:wallpaper_app/UI/common/common_button.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/storage/shared_preference_service.dart';
import 'package:wallpaper_app/infrastructure/utils/notification_manager.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: CommonBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.transparent,
                          Colors.transparent.withOpacity(.2),
                          Colors.black,
                          Colors.black,
                          Colors.transparent.withOpacity(.2),
                          Colors.transparent,
                        ],
                        stops: const [0.0,.1,0.4,0.6,0.9 ,1],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: ImageConstant.imgOnBoarding,
                    // child: Image.asset(
                    //   ImageConstant.onboardingImg,
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
              const HeadlineBodyOneBaseWidget(
                title: "Every way to find Free content",
                fontSize: 32,
                titleColor: ColorConstants.white,
                fontFamily: FontConstant.satoshiBold,
                height: 1.25,
              ),
              const SizedBox(height: 12),
              HeadlineBodyOneBaseWidget(
                title: "Discover Wallpaper plus endless pool of wallpapers & sound to serve your purpose.",
                fontSize: 16,
                titleColor: ColorConstants.white.withOpacity(.6),
                fontFamily: FontConstant.satoshiRegular,
                height: 1.5,
              ),
              const SizedBox(height: 24),
              CommonButton(
                onTap: () async{
                  await NotificationManager.createElevenAMNotification();
                  Get.offAllNamed(RoutesConstant.mainScreen);
                  await SharedPreferenceService.saveShowOnboardingScreen(false);
                },
                title: "Explore Now",
                titleColor: ColorConstants.background,
              ),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}
