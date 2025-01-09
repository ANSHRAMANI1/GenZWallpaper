import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/common/common_background.dart';
import 'package:wallpaper_app/UI/common/common_button.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/UI/common/square_small_icon.dart';
import 'package:wallpaper_app/UI/screens/SubscriptionSection/subscription_controller.dart';
import 'package:wallpaper_app/UI/screens/SubscriptionSection/widgets/premium_plan_card.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/image_constant.dart';

class SubscriptionScreen extends GetView<SubscriptionController> {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: ColorConstants.white.withOpacity(.1),
                    border: Border.all(
                        color: ColorConstants.white.withOpacity(.25)),
                    shape: BoxShape.circle,
                  ),
                  child: const SquareSmallButton(
                    imagePath: ImageConstant.backIcon,
                    dimension: 20,
                    iconColor: ColorConstants.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Image.asset(
                    ImageConstant.premiumCardImg,
                    height: MediaQuery.sizeOf(context).height * .32,
                    // height: 250,
                  ).paddingSymmetric(vertical: 54,horizontal: 50),
                  const HeadlineBodyOneBaseWidget(
                    title: "Payment Method",
                    fontSize: 16,
                    fontFamily: FontConstant.satoshiBold,
                    height: 1.5,
                    titleColor: ColorConstants.white,
                  ).paddingSymmetric(vertical: 12, horizontal: 20),
                  ...List.generate(
                    controller.subscriptionPlan.length,
                    (index) => Obx(
                      () => PremiumPlanCard(
                        onTap: () {
                          controller.selectedPlan.value = index;
                        },
                        selected: controller.selectedPlan.value == index,
                        data: controller.subscriptionPlan[index],
                      ).paddingSymmetric(horizontal: 20,vertical: 6),
                    ),
                  ),
                    const SizedBox(height: 10),
                  CommonButton(title: "Subscribe Now", onTap: (){},).paddingSymmetric(horizontal: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget subscribeNowButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      margin: const EdgeInsets.only(bottom: 24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            colors: [
              // ColorConstants.orange,
              Color(0xFFF39654),
              Color(0xFFF07721),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: const HeadlineBodyOneBaseWidget(
        title: "Subscribe Now",
        fontSize: 16,
        fontFamily: FontConstant.satoshiMedium,
        height: 1.5,
        titleColor: ColorConstants.white,
      ),
    );
  }
}
