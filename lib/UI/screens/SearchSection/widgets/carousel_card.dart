import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/model/search_carousel_data_model.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.data});

  final SearchCarouselDataModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.sizeOf(context).height * .33,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(data.image ?? ""),
          fit: BoxFit.cover,
          opacity: .7
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          HeadlineBodyOneBaseWidget(
            title: data.title ?? "",
            fontSize: 16,
            height: 1.5,
            titleColor:
            ColorConstants.white.withOpacity(.8),
            fontFamily: FontConstant.satoshiMedium,
          ),
          HeadlineBodyOneBaseWidget(
            title: data.description ?? "",
            fontSize: 32,
            height: 1.25,
            titleTextAlign: TextAlign.center,
            titleColor: ColorConstants.white,
            fontFamily: FontConstant.satoshiBold,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
