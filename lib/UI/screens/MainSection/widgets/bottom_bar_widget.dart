import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
    required this.active,
    required this.homeTap,
    required this.searchTap,
    required this.categoryTap,
    required this.settingTap,
  }) : super(key: key);

  final GestureTapCallback homeTap;
  final GestureTapCallback searchTap;
  final GestureTapCallback categoryTap;
  final GestureTapCallback settingTap;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 66,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 34),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.all(2),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(50),
            bottom: Radius.circular(50),
          ),
          child: Blur(
            blurColor: Colors.black,
            colorOpacity: .4,
            borderRadius: BorderRadius.circular(100),
            blur: 10,
            child: IntrinsicWidth(
              child: Stack(
                children: [
                  AnimatedPadding(
                    duration: const Duration(milliseconds: 150),
                    padding: EdgeInsets.only(
                        left: active == 0
                            ? 0
                            : active == 1
                                ? 59
                                : active == 2
                                    ? 119
                                    : 179),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      alignment: Alignment.center,
                      height: 58,
                      width: 58,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(300),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 62,
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        bottomIcons(
                          onTap: homeTap,
                          icon: ImageConstant.homeIcon,
                          index: 0,
                        ),
                        bottomIcons(
                          onTap: searchTap,
                          icon: ImageConstant.searchIcon,
                          index: 1,
                        ),
                        bottomIcons(
                          onTap: categoryTap,
                          icon: ImageConstant.categoryIcon,
                          index: 2,
                        ),
                        bottomIcons(
                          onTap: settingTap,
                          icon: ImageConstant.settingsIcon,
                          index: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomIcons({
    required GestureTapCallback onTap,
    required String icon,
    required int index,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        padding: const EdgeInsets.all(18),
        curve: Curves.bounceInOut,
        alignment: Alignment.center,
        height: 62,
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
        ),
        child: SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
              active == index ? ColorConstants.black : ColorConstants.white,
              BlendMode.srcIn),
        ),
      ),
    );
  }
}

// child: Container(
//   width: width,
//   height: height * (Platform.isIOS ? .15 : .1),
//   decoration: const BoxDecoration(
//     color: ColorConstants.transparent,
//     borderRadius: BorderRadius.only(
//       topLeft: Radius.circular(30),
//       topRight: Radius.circular(30),
//     ),
//   ),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       InkWell(
//         onTap: homeTap,
//         child: Container(
//           alignment: Alignment.center,
//           height: 60,
//           width: width / 5,
//           child: SvgPicture.asset(
//             ImageConstant.homeIcon,
//             width: 24.0,
//             height: 24.0,
//             colorFilter: ColorFilter.mode(
//                 active == 0 ? ColorConstants.blue : ColorConstants.white,
//                 BlendMode.srcIn),
//           ),
//         ),
//       ),
//       InkWell(
//         onTap: searchTap,
//         child: Container(
//           alignment: Alignment.center,
//           height: 60,
//           width: width / 5,
//           child: SvgPicture.asset(
//             ImageConstant.searchIcon,
//             width: 24.0,
//             height: 24.0,
//             colorFilter: ColorFilter.mode(
//                 active == 1 ? ColorConstants.blue : ColorConstants.white,
//                 BlendMode.srcIn),
//           ),
//         ),
//       ),
//       InkWell(
//         onTap: categoryTap,
//         child: Container(
//           alignment: Alignment.center,
//           height: 60,
//           width: width / 5,
//           child: SvgPicture.asset(
//             ImageConstant.categoryIcon,
//             width: 24.0,
//             height: 24.0,
//             colorFilter: ColorFilter.mode(
//                 active == 2 ? ColorConstants.blue : ColorConstants.white,
//                 BlendMode.srcIn),
//           ),
//         ),
//       ),
//       InkWell(
//         onTap: settingTap,
//         child: Container(
//           alignment: Alignment.center,
//           height: 60,
//           width: width / 5,
//           child: SvgPicture.asset(
//             ImageConstant.settingsIcon,
//             width: 24.0,
//             height: 24.0,
//             colorFilter: ColorFilter.mode(
//                 active == 3 ? ColorConstants.blue : ColorConstants.white,
//                 BlendMode.srcIn),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
