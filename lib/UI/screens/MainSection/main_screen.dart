import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/CategoriesSection/categories_screen.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_screen.dart';
import 'package:wallpaper_app/UI/screens/MainSection/main_screen_controller.dart';
import 'package:wallpaper_app/UI/screens/MainSection/widgets/bottom_bar_widget.dart';
import 'package:wallpaper_app/UI/screens/SearchSection/search_controller.dart';
import 'package:wallpaper_app/UI/screens/SearchSection/search_screen.dart';
import 'package:wallpaper_app/UI/screens/SettingsSection/settings_screen.dart';
import 'package:wallpaper_app/infrastructure/constant/color_constant.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async{
          SystemNavigator.pop();
        },
        child: Scaffold(
          backgroundColor: ColorConstants.background,
          resizeToAvoidBottomInset: false,
          body: Obx(
            () => Stack(
              children: [
                PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) => controller.selectIndex(value),
                  controller: controller.pageController,
                  children: const [
                    HomeScreenWrapper(),
                    SearchScreenWrapper(),
                    CategoryScreenWrapper(),
                    SettingsScreenWrapper(),
                  ],
                ),
                BottomBarWidget(
                  active: controller.selectedIndex.value,
                  homeTap: () => controller.animateToPage(0),
                  searchTap: () {
                    if(!Get.find<SearchScreenController>().searchClick.value){
                      Get.find<SearchScreenController>().init();
                    }
                    controller.animateToPage(1);
                  },
                  categoryTap: () => controller.animateToPage(2),
                  settingTap: () => controller.animateToPage(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// bottom screens

class HomeScreenWrapper extends StatefulWidget {
  const HomeScreenWrapper({super.key});

  @override
  State<HomeScreenWrapper> createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const HomeScreen();
  }
}

class SearchScreenWrapper extends StatefulWidget {
  const SearchScreenWrapper({super.key});

  @override
  State<SearchScreenWrapper> createState() => _SearchScreenWrapperState();
}

class _SearchScreenWrapperState extends State<SearchScreenWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SearchScreen();
  }
}

class CategoryScreenWrapper extends StatefulWidget {
  const CategoryScreenWrapper({super.key});

  @override
  State<CategoryScreenWrapper> createState() => _CategoryScreenWrapperState();
}

class _CategoryScreenWrapperState extends State<CategoryScreenWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CategoriesScreen();
  }
}

class SettingsScreenWrapper extends StatefulWidget {
  const SettingsScreenWrapper({super.key});

  @override
  State<SettingsScreenWrapper> createState() => _SettingsScreenWrapperState();
}

class _SettingsScreenWrapperState extends State<SettingsScreenWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SettingsScreen();
  }
}
