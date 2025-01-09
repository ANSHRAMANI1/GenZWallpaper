import 'package:get/get.dart';
import 'package:wallpaper_app/UI/screens/CategoriesSection/SubScreen/categories_wallpaper_screen.dart';
import 'package:wallpaper_app/UI/screens/CategoriesSection/category_binding.dart';
import 'package:wallpaper_app/UI/screens/HomeSection/home_screen.dart';
import 'package:wallpaper_app/UI/screens/LiveWallpaperPreviewSection/live_wallpaper_preview_binding.dart';
import 'package:wallpaper_app/UI/screens/LiveWallpaperPreviewSection/live_wallpaper_preview_screen.dart';
import 'package:wallpaper_app/UI/screens/MainSection/main_screen.dart';
import 'package:wallpaper_app/UI/screens/MainSection/main_screen_binding.dart';
import 'package:wallpaper_app/UI/screens/OnboardingSection/onboarding_screen.dart';
import 'package:wallpaper_app/UI/screens/ProfileSection/profile_binding.dart';
import 'package:wallpaper_app/UI/screens/ProfileSection/profile_screen.dart';
import 'package:wallpaper_app/UI/screens/RingtonePreviewSection/ringtone_preview_binding.dart';
import 'package:wallpaper_app/UI/screens/RingtonePreviewSection/ringtone_preview_screen.dart';
import 'package:wallpaper_app/UI/screens/SearchSection/search_screen.dart';
import 'package:wallpaper_app/UI/screens/SettingsSection/SubScreen/privacy_policy_screen.dart';
import 'package:wallpaper_app/UI/screens/SettingsSection/SubScreen/terms_and_condition_screen.dart';
import 'package:wallpaper_app/UI/screens/SettingsSection/settings_binding.dart';
import 'package:wallpaper_app/UI/screens/SettingsSection/settings_screen.dart';
import 'package:wallpaper_app/UI/screens/SplashSection/splash_binding.dart';
import 'package:wallpaper_app/UI/screens/SplashSection/splash_screen.dart';
import 'package:wallpaper_app/UI/screens/SubscriptionSection/subscription_binding.dart';
import 'package:wallpaper_app/UI/screens/SubscriptionSection/subscription_screen.dart';
import 'package:wallpaper_app/UI/screens/WallpaperPreviewSection/wallpaper_preview_binding.dart';
import 'package:wallpaper_app/UI/screens/WallpaperPreviewSection/wallpaper_preview_screen.dart';
import 'package:wallpaper_app/infrastructure/constant/routes_constant.dart';

class AppPages {

  static final pages = [
    GetPage(
      name: RoutesConstant.splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RoutesConstant.onboardingScreen,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: RoutesConstant.mainScreen,
      page: () => const MainScreen(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: RoutesConstant.homeScreen,
      page: () => const HomeScreen(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: RoutesConstant.categoryWallpaperScreen,
      page: () => const CategoriesWallpaperScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: RoutesConstant.searchScreen,
      page: () => const SearchScreen(),
      // binding: SearchBinding(),
    ),
    GetPage(
      name: RoutesConstant.subscriptionScreen,
      page: () => const SubscriptionScreen(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: RoutesConstant.wallpaperPreviewScreen,
      page: () => const WallpaperPreviewScreen(),
      binding: WallpaperPreviewBinding(),
    ),
    GetPage(
      name: RoutesConstant.liveWallpaperPreviewScreen,
      page: () => const LiveWallpaperPreviewScreen(),
      binding: LiveWallpaperPreviewBinding(),
    ),
    GetPage(
      name: RoutesConstant.ringtonePreviewScreen,
      page: () => const RingtonePreviewScreen(),
      binding: RingtonePreviewBinding(),
    ),
    GetPage(
      name: RoutesConstant.profileScreen,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: RoutesConstant.settingsScreen,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: RoutesConstant.termsAndConditionScreen,
      page: () => const TermsAndConditionsScreen(),
    ),
    GetPage(
      name: RoutesConstant.privacyPolicyScreen,
      page: () => const PrivacyPolicyScreen(),
    ),
  ];
}
