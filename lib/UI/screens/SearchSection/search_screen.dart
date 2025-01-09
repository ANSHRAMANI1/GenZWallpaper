import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wallpaper_app/UI/common/blur_widget.dart';
import 'package:wallpaper_app/UI/common/common_background.dart';
import 'package:wallpaper_app/UI/common/common_loader.dart';
import 'package:wallpaper_app/UI/common/common_textfield.dart';
import 'package:wallpaper_app/UI/common/grid_image_view.dart';
import 'package:wallpaper_app/UI/screens/SearchSection/search_controller.dart';
import 'package:wallpaper_app/UI/screens/SearchSection/widgets/carousel_card.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/model/search_carousel_data_model.dart';

class SearchScreen extends GetView<SearchScreenController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: CommonBackground(
        topSpace: false,
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * .33,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                // border: Border(
                //   bottom: BorderSide(color: ColorConstants.white.withOpacity(.25)),
                //   right: BorderSide(color: ColorConstants.white.withOpacity(.25)),
                //   left: BorderSide(color: ColorConstants.white.withOpacity(.25)),
                // ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(
                      0.0,
                      2.0,
                    ),
                  )
                ],
              ),
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: controller.pageController,
                    physics: const ClampingScrollPhysics(),
                    onPageChanged: (value) {
                      controller.selectedPageIndex.value = value;
                    },
                    itemBuilder: (context, index) {
                      SearchCarouselDataModel data = controller.searchCarouselDataList.loop(index);
                      return CarouselCard(data: data);
                    },
                  ),
                  IntrinsicHeight(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorConstants.white.withOpacity(.25)),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      margin: const EdgeInsets.fromLTRB(20, 54, 20, 0),
                      child: Blur(
                        blurColor: Colors.black,
                        colorOpacity: .4,
                        borderRadius: BorderRadius.circular(100),
                        blur: 10,
                        child: commonTextField(
                          focusNode: controller.focusNode,
                          showLabel: false,
                          showOnFocusBorder: true,
                          showBorder: false,
                          isDense: true,
                          textAlignVertical: TextAlignVertical.center,
                          padding: const EdgeInsets.all(15),
                          addPadding: true,
                          onTap: () {
                            controller.filterWallpaper(value: "");
                            // controller.update();
                          },
                          onChanged: (value) {
                            controller.filterWallpaper(value: value);
                          },
                          onEditingComplete: () {
                            controller.focusNode.unfocus();
                          },
                          onFieldSubmitted: (p0) {
                            controller.focusNode.unfocus();
                          },
                          prefixIcon: Container(
                            padding:
                                const EdgeInsets.fromLTRB(15, 10, 10, 10),
                            child: SvgPicture.asset(
                              ImageConstant.searchIcon,
                              height: 20,
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                  controller.focusNode.hasFocus
                                      ? ColorConstants.white
                                      : ColorConstants.secondaryText,
                                  BlendMode.srcIn),
                            ),
                          ),
                          context: context,
                          hint: "Search wallpaper",
                          label: '',
                          controller: controller.txtSearch,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SmoothPageIndicator(
              controller: controller.pageController,
              count: controller.searchCarouselDataList.length,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                spacing: 6,
                activeDotColor: ColorConstants.white,
                dotColor: ColorConstants.white.withOpacity(.1),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const CommonLoader()
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 350,
                        ),
                        itemCount: controller.wallpapers.length,
                        // crossAxisCount: 2,
                        // mainAxisSpacing: 10,
                        // crossAxisSpacing: 10,
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.sizeOf(context).height * 0.15,
                            left: 20,
                            right: 20),
                        itemBuilder: (context, index) {
                          final data = controller.wallpapers[index];
                          return SizedBox(
                            child: GridImageView(
                              imageUrl: data.thumbnail ?? "",
                              premium: data.premium ?? 0,
                              screen: 'search',
                              onTap: () {
                                Get.toNamed(
                                    RoutesConstant.wallpaperPreviewScreen,
                                    arguments: ["search",controller.wallpapers,data.image],
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
