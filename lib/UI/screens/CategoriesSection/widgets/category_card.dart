import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/model/category_date_model.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.data});

  final CategoryDataModel data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        if(data.category == "Live Wallpaper"){
          Get.toNamed(RoutesConstant.liveWallpaperPreviewScreen,arguments: [Get.find<HomeController>().liveWallpapers,Get.find<HomeController>().liveWallpapers[0].image]);
        } else {
          Get.toNamed(RoutesConstant.categoryWallpaperScreen, arguments: data.category);
        }
      },
      child: Container(
        height: MediaQuery.sizeOf(context).height * .22,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: ColorConstants.black,
          borderRadius: BorderRadius.circular(24),
          // image: data.category == "Live Wallpaper"? null:DecorationImage(
          //   image: CachedNetworkImageProvider(data.image ?? ""),
          //   opacity: .7,
          //   fit: BoxFit.cover,
          // ),
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Opacity(
                    opacity: .8,
                    child: CachedNetworkImage(imageUrl: getImageLink(url: data.image ?? ""),fit: BoxFit.cover,width: double.maxFinite,),),),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.65)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomLeft,
              child: HeadlineBodyOneBaseWidget(
                title: data.category,
                fontSize: 32,
                titleColor: ColorConstants.white,
                fontFamily: FontConstant.satoshiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
