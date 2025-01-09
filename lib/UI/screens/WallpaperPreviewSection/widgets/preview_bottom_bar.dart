import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';

class PreviewBottomBar extends StatelessWidget {
  const PreviewBottomBar({
    super.key,
    required this.onFavouritesTap,
    required this.onDownloadTap,
    required this.onShareTap,
    required this.like,
  });

  final GestureTapCallback onFavouritesTap;
  final GestureTapCallback onDownloadTap;
  final GestureTapCallback onShareTap;
  final int like;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              onTap: onFavouritesTap,
              child: Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.all(4),
                child: SvgPicture.asset(
                  like == 1
                      ? ImageConstant.filledLikeIcon
                      : ImageConstant.noFillLikeIcon,
                ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(200),
              onTap: onDownloadTap,
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
              onTap: onShareTap,
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
    );
  }
}
