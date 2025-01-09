import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/UI/common/square_small_icon.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class RingtoneImageView extends StatefulWidget {
  const RingtoneImageView({
    super.key,
    required this.showAnimation,
    required this.image,
    required this.ringtone, required this.stopAnimation, required this.onPlayPauseTap, required this.playPauseImage,
  });

  final bool showAnimation;
  final bool stopAnimation;
  final String image;
  final String ringtone;
  final String playPauseImage;
  final GestureTapCallback onPlayPauseTap;

  @override
  State<RingtoneImageView> createState() => _RingtoneImageViewState();
}

class _RingtoneImageViewState extends State<RingtoneImageView>
    with SingleTickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: rotationController,
          builder: (context, child) {
            return widget.showAnimation
                ? Transform.rotate(
                    angle: rotationController.value * 2 * math.pi,
                    child: child,
                  )
                : Container(child: child);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000),
            child: CachedNetworkImage(
              imageUrl: getImageLink(url: widget.image),
              fit: BoxFit.cover,
              height: 280,
              width: 280,
              color: ColorConstants.black.withOpacity(.25),
              colorBlendMode: BlendMode.darken,
              placeholder: (context, url) => Image.asset(
                ImageConstant.placeholderImg,
                fit: BoxFit.cover,
                height: 280,
                width: 280,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            widget.onPlayPauseTap();
            if(widget.stopAnimation){
              rotationController.stop(canceled: false);
            }else{
              rotationController.forward();
              rotationController.repeat();
            }
          },
          child: SquareSmallButton(
              dimension: 80,
              imagePath: widget.playPauseImage,
              iconColor: ColorConstants.white,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }
}
