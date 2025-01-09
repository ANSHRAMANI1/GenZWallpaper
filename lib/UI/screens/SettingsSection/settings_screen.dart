import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_app/UI/common/common_background.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/UI/screens/SettingsSection/settings_controller.dart';
import 'package:wallpaper_app/UI/screens/SettingsSection/widgets/settings_card.dart';
import 'package:wallpaper_app/infrastructure/constant/app_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';
import 'package:wallpaper_app/infrastructure/package/open_store.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: CommonBackground(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
          children: [
            const HeadlineBodyOneBaseWidget(
              title: "Settings",
              fontSize: 24,
              titleColor: ColorConstants.white,
              fontFamily: FontConstant.satoshiBold,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 24),
            // const PurchasePremiumCard(),
            SettingCard(
              title: "Show Notification",
              switchSpace: true,
              onTap: () {
                controller.requestNotification();
              },
              trailing: Obx(
                () => Switch.adaptive(
                  value: controller.showNotification.value,
                  activeColor: ColorConstants.orange,
                  inactiveTrackColor: ColorConstants.transparent,
                  trackOutlineColor:
                  !controller.showNotification.value
                      ? MaterialStatePropertyAll(ColorConstants.white.withOpacity(.1))
                      : const MaterialStatePropertyAll(ColorConstants.transparent),
                  thumbColor: const MaterialStatePropertyAll(ColorConstants.white),
                  onChanged: (value) {
                    controller.requestNotification();
                  },
                ),
              ),
            ),
            SettingCard(
              title: "Share Friends",
              onTap: () {
                Share.share(AppConstants.shareAppTxt);
              },
            ),
            SettingCard(
              title: "Rate Us",
              onTap: () async {
                PackageInfo packageInfo = await PackageInfo.fromPlatform();

                OpenStore.instance.open(
                  appStoreId: "284815942",
                  androidAppBundleId: packageInfo.packageName,
                );
              },
            ),
            SettingCard(
              title: "Terms & Condition",
              onTap: () {
                Get.toNamed(RoutesConstant.termsAndConditionScreen);
              },
            ),
            SettingCard(
              title: "Privacy Policy",
              onTap: () {
                Get.toNamed(RoutesConstant.privacyPolicyScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
