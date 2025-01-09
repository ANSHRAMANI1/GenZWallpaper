import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/common_background.dart';
import 'package:wallpaper_app/UI/common/custom_appbar.dart';
import 'package:wallpaper_app/UI/screens/ProfileSection/SubScreen/liked_ringtone_tab.dart';
import 'package:wallpaper_app/UI/screens/ProfileSection/SubScreen/liked_wallpaper_tab.dart';
import 'package:wallpaper_app/UI/screens/ProfileSection/profile_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColorConstants.background,
        body: CommonBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              const CustomAppBar(title: "My Profile"),
              const SizedBox(height: 24),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                    color: ColorConstants.orange, shape: BoxShape.circle),
                child: SvgPicture.asset(
                  ImageConstant.profileIcon,
                  height: 64,
                  width: 64,
                ),
              ),
              const SizedBox(height: 16),
              // const HeadlineBodyOneBaseWidget(
              //   title: "Liked Images",
              //   fontSize: 20,
              //   fontFamily: FontConstant.satoshiBold,
              //   height: 1.4,
              //   titleColor: ColorConstants.white,
              // ).paddingSymmetric(horizontal: 20),
              TabBar(
                dividerColor: ColorConstants.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  color: ColorConstants.white,
                  fontFamily: FontConstant.satoshiBold,
                ),
                indicatorColor: ColorConstants.white,
                indicatorWeight: 1.5,
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  color: ColorConstants.white.withOpacity(.6),
                  fontFamily: FontConstant.satoshiMedium,
                ),
                tabs: const [
                  Tab(text: "Liked Wallpapers"),
                  Tab(text: "Liked Ringtones"),
                ],
              ),
              const SizedBox(height: 12),
              const Expanded(
                child: TabBarView(
                  children: [
                    LikedWallpaperTabScreen(),
                    LikedRingtoneTabScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
