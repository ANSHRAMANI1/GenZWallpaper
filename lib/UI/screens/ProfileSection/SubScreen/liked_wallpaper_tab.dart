import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/common_loader.dart';
import 'package:wallpaper_app/UI/common/grid_image_view.dart';
import 'package:wallpaper_app/UI/common/no_data_available_widget.dart';
import 'package:wallpaper_app/UI/screens/ProfileSection/profile_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/utils/utils.dart';

class LikedWallpaperTabScreen extends GetView<ProfileController> {
  const LikedWallpaperTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? SizedBox(
              height: MediaQuery.sizeOf(context).height * .75,
              child: const CommonLoader(),
            )
          : controller.wallpapers.isEmpty
              ? const NoDataAvailableWidget()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 350,
                  ),
                  itemCount: controller.wallpapers.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).height * 0.15,
                      left: 20,
                      right: 20,
                      top: 20),
                  itemBuilder: (context, index) {
                    final data = controller.wallpapers[index];
                    return SizedBox(
                      child: GridImageView(
                        imageUrl: data.thumbnail ?? "",
                        premium: data.premium ?? 0,
                        onTap: () {
                          Get.toNamed(RoutesConstant.wallpaperPreviewScreen,
                              arguments: [
                                "profile",
                                wallpaperAdsDataList(wallpaper: controller.wallpapers),
                                data.image
                              ]);
                        },
                        screen: 'profile',
                      ),
                    );
                  },
                ),
    );
  }
}
