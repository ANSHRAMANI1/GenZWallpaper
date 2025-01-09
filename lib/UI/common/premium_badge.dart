import 'package:flutter/material.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/UI/common/square_small_icon.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';

class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Blur(
      colorOpacity: .1,
      blurColor: ColorConstants.black,
      borderRadius: BorderRadius.circular(1000),
      blur: 4,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorConstants.black.withOpacity(.1),
            border: Border.all(color: ColorConstants.white)
        ),
        child: const SquareSmallButton(
          dimension: 20,
          imagePath: ImageConstant.premiumIcon,
          iconColor: Color(0xFFFFC531),
        ),
      ),
    );
  }
}
