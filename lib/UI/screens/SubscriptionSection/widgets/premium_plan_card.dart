import 'package:flutter/material.dart';
import 'package:wallpaper_app/UI/common/headline_body_one_base_widget.dart';
import 'package:wallpaper_app/UI/screens/SubscriptionSection/subscription_controller.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';
import 'package:wallpaper_app/infrastructure/constant/font_constant.dart';

class PremiumPlanCard extends StatelessWidget {
  const PremiumPlanCard({super.key, required this.selected, required this.data, required this.onTap});

  final bool selected;
  final SubscriptionPlansModel data;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: selected ? ColorConstants.orange : ColorConstants.white.withOpacity(.4)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? ColorConstants.orange : ColorConstants.transparent,
                border: selected ? null : Border.all(color: ColorConstants.white),
              ),
              child: selected ? Container(
                height: 11.5,
                width: 11.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.white,
                ),
              ) : Container(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadlineBodyOneBaseWidget(
                    title: data.duration,
                    fontSize: 20,
                    fontFamily: FontConstant.satoshiMedium,
                    height: 1.4,
                    titleColor: ColorConstants.white,
                  ),
                  HeadlineBodyOneBaseWidget(
                    title: "\$ ${data.price}${data.trailText}",
                    fontSize: 16,
                    fontFamily: FontConstant.satoshiRegular,
                    height: 1.5,
                    titleColor: ColorConstants.white.withOpacity(selected ? .8 : .6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
