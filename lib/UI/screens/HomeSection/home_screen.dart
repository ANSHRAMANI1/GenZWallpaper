import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/UI/common/common_loader.dart';
import 'package:wallpaper_app/UI/screens/CategoriesSection/widgets/category_card.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/SubScreen/live_wallpaper_tab.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/SubScreen/ringtone_tab.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/SubScreen/trending_wallpaper_tab.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/SubScreen/wallpaper_tab.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.only(top: controller.isPinned.value ? 0 : 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstant.backgroundImg), fit: BoxFit.fill),
            ),
            child: DefaultTabController(
              length: Platform.isAndroid ? 5 : 4,
              child: NestedScrollView(
                controller: controller.sliverScrollController,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      titleSpacing: 0,
                      leadingWidth: 0,
                      automaticallyImplyLeading: false,
                      toolbarHeight: 40,
                      expandedHeight: 40,
                      backgroundColor: ColorConstants.transparent,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const HeadlineBodyOneBaseWidget(
                            title: "Gen Z",
                            fontSize: 24,
                            titleColor: ColorConstants.white,
                            fontFamily: FontConstant.satoshiBold,
                            fontWeight: FontWeight.bold,
                          ),
                          InkWell(
                            onTap: () async{
                              Get.toNamed(RoutesConstant.profileScreen);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.white.withOpacity(.1),
                                border: Border.all(
                                  color: ColorConstants.white.withOpacity(.25),
                                ),
                              ),
                              child: SvgPicture.asset(ImageConstant.profileIcon),
                            ),
                          ),
                        ],
                      ).paddingSymmetric(vertical: 0, horizontal: 20),
                    ),
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      scrolledUnderElevation: 0,
                      pinned: true,
                      leadingWidth: 0,
                      expandedHeight: 0,
                      toolbarHeight: controller.isPinned.value ? 60 : 24,
                      backgroundColor: ColorConstants.transparent,
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.zero,
                        background: Blur(
                          colorOpacity: controller.isPinned.value ? .4 : 0,
                          blurColor: ColorConstants.black,
                          blur: 24,
                          child: Container(),
                        ),
                        expandedTitleScale: 1,
                        title: TabBar(
                          dividerColor: ColorConstants.transparent,
                          indicatorSize: TabBarIndicatorSize.label,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
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
                          tabs: [
                            const Tab(text: "Trending Wallpaper"),
                            const Tab(text: "Trending Category"),
                            if(Platform.isAndroid)
                              const Tab(text: "Live Wallpaper"),
                            const Tab(text: "Wallpapers"),
                            const Tab(text: "Ringtones"),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: TabBarView(
                    children: [
                      const TrendingWallpaperTabWrapper(),
                      const TrendingCategoryTabWrapper(),
                      if(Platform.isAndroid)
                        const LiveWallpaperTabWrapper(),
                      const WallpaperTabWrapper(),
                      const RingtoneTabWrapper(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}


/// Trending category tab wrapper
class TrendingCategoryTabWrapper extends StatefulWidget {
  const TrendingCategoryTabWrapper({super.key});

  @override
  State<TrendingCategoryTabWrapper> createState() => _TrendingCategoryTabWrapperState();
}

class _TrendingCategoryTabWrapperState extends State<TrendingCategoryTabWrapper> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => controller.isCategoryPlaying.value
          ? const CommonLoader()
          : ListView.builder(
              itemCount: controller.categoriesDataList.length,
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: MediaQuery.sizeOf(context).height * 0.12,
                top: 10,
              ),
              itemBuilder: (context, index) {
                return controller.categoriesDataList[index].trending == 1 ? (Platform.isIOS &&
                        controller.categoriesDataList[index].category ==
                            "Live Wallpaper")
                    ? Container()
                    : CategoryCard(data: controller.categoriesDataList[index]) : Container();
              },
            ),
    );
  }
}

