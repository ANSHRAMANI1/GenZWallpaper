import 'package:flutter/material.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';

class SettingCard extends StatelessWidget {
  @override
  const SettingCard({
    this.subTitle,
    required this.title,
    required this.onTap,
    this.trailing,
    this.switchSpace,
    super.key,
  });
  
  final GestureTapCallback onTap;
  final String title;
  final String? subTitle;
  final Widget? trailing;
  final bool? switchSpace;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Blur(
          blur: 20,
          blurColor: ColorConstants.black,
          colorOpacity: .2,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: height * ((switchSpace ?? false) ? 0.01 : 0.019), horizontal: width * 0.04),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstants.white.withOpacity(.1),width: 1.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeadlineBodyOneBaseWidget(
                      title: title,
                      titleTextAlign: TextAlign.start,
                      titleColor: ColorConstants.white,
                      fontFamily: FontConstant.satoshiBold,
                      fontSize: 16,
                    ),
                    if(subTitle != null)
                    Flexible(
                      child: HeadlineBodyOneBaseWidget(
                        title: subTitle,
                        fontSize: 12,
                        titleColor: Colors.grey.shade400,
                        fontFamily: FontConstant.satoshiMedium,
                        maxLine: 2,
                        titleTextAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                 trailing ?? const Icon(
                  Icons.navigate_next,
                  color: ColorConstants.white,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void ratePopup(context) {
  //   final height = MediaQuery.sizeOf(context).height;
  //   final width = MediaQuery.sizeOf(context).width;
  //   showDialog(
  //       barrierColor: ColorConstants.black.withOpacity(.7),
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           contentPadding: EdgeInsets.zero,
  //           backgroundColor: ColorConstants.appBar,
  //           shape: RoundedRectangleBorder(
  //               side: BorderSide(color: ColorConstants.borderColor),
  //               borderRadius: BorderRadius.all(Radius.circular(16))),
  //           content: Container(
  //             height: height * 0.475,
  //             width: width * 0.893,
  //             child: Stack(
  //               children: [
  //                 Align(
  //                     alignment: Alignment.topLeft,
  //                     child: ClipRRect(
  //                         borderRadius:
  //                         BorderRadius.only(topLeft: Radius.circular(15)),
  //                         child: Image.asset(
  //                           ImageConstant.settingPremiumCardGlassMorphism,
  //                           fit: BoxFit.cover,
  //                         ))),
  //                 Align(
  //                   alignment: Alignment.topRight,
  //                   child: Padding(
  //                     padding: EdgeInsets.only(
  //                         right: width * 0.085,
  //                         top: height * 0.039),
  //                     child: IconButton(
  //                         onPressed: () {
  //                           Get.back();
  //                         },
  //                         icon: const Icon(Icons.close_sharp,
  //                             size: 28, color: ColorConstants.white)),
  //                   ),
  //                 ),
  //                 Column(
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(
  //                           top: height * 0.017,
  //                           left: width * 0.234,
  //                           right: width * 0.232,
  //                           bottom: height * 0.019),
  //                       child: Image.asset(ImageConstant.rate,
  //                           height: height * 0.197,
  //                           width: width * 0.42),
  //                     ),
  //                     Text(AppConstants.rate.tr,
  //                         style: TextStylePoppinsSemiBold18(
  //                             color: ColorConstants.white)),
  //                     Padding(
  //                       padding: EdgeInsets.only(
  //                           top: height * 0.022,
  //                           bottom: height * 0.004,
  //                           right: width * 0.136,
  //                           left: width * 0.136),
  //                       child: Text(AppConstants.likeApp.tr,
  //                           style: TextStylePoppinsBold16(
  //                               color: ColorConstants.white)),
  //                     ),
  //                     Text(AppConstants.think.tr,
  //                         style: TextStylePoppinsRegular12(
  //                             color: ColorConstants.white)),
  //                     Padding(
  //                       padding: EdgeInsets.only(
  //                           top: height * 0.026,
  //                           left: width * 0.058,
  //                           right: height * 0.026),
  //                       child: RatingBar.builder(
  //                         unratedColor: Color(0xFF28293D),
  //                         glowRadius: 20,
  //                         minRating: 4,
  //                         itemPadding: EdgeInsets.symmetric(
  //                             horizontal: width * 0.010),
  //                         updateOnDrag: true,
  //                         itemBuilder: (context, index) {
  //                           return //Icon(Icons.star,color: ColorConstants.purple2,);
  //                             SvgPicture.asset(ImageConstant.rateStar);
  //                         },
  //                         onRatingUpdate: (value) {
  //                           con.openStoreListing();
  //                         },
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}
