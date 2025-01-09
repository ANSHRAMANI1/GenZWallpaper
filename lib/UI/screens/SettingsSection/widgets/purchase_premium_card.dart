import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/UI/common/common_button.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';

class PurchasePremiumCard extends StatelessWidget {
  const PurchasePremiumCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Blur(
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
            ShaderMask(
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
                  stops: const [0.0, .4, 0.6, 0.9, 1],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image(
                    image: ImageConstant.imgUpdateApp.image,
                    height: 160,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                  )),
            ),
            const HeadlineBodyOneBaseWidget(
              title: "Get Premium Now",
              fontSize: 24,
              titleColor: ColorConstants.white,
              fontFamily: FontConstant.satoshiBold,
              height: 1.25,
              titleTextAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            HeadlineBodyOneBaseWidget(
              title: "Upgrade to premium and get more downloads.",
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
          ],
        ),
      ),
    );
  }
}
