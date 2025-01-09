import 'dart:io';

class AppConstants{
  static const String appName = "Gen Z - AI wallpaper & Ringtone";
  static const bool isTest = false;
  //test google
  static String nativeId = isTest ?
  Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511' :
  Platform.isAndroid
      ? 'ca-app-pub-5033699399153898/5431419561'
      : 'ca-app-pub-5033699399153898/3926766204';

  static String rewardId = isTest ?
  Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313' :
  Platform.isAndroid
      ? ' ca-app-pub-5033699399153898/5010314407'
      : 'ca-app-pub-5033699399153898/3505661043';

  static String interstitialAd = isTest ?
  Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910' :
  Platform.isAndroid
      ? 'ca-app-pub-5033699399153898/3929801483'
      : 'ca-app-pub-5033699399153898/9579280656';

  static String bannerAdsId = isTest ?
  Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716' :
  Platform.isAndroid
      ? 'ca-app-pub-5033699399153898/4621072210'
      : 'ca-app-pub-5033699399153898/3466767056';

  static String openAppAdId = isTest ?
  Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/3419835294'
      : 'ca-app-pub-3940256099942544/5662855259' :
  Platform.isAndroid
      ? 'ca-app-pub-5033699399153898/4776813442'
      : 'ca-app-pub-5033699399153898/3902715475';


  static const String appLinkTextConstant =
      "https://play.google.com/store/apps/details?id=com.wallpaper.app";
  static const String iOSAppLinkTextConstant =
      "https://apps.apple.com/us/app/weposto/id284815942";

  static String shareAppTxt = '''🌟 Elevate your device's style with $appName 🌟

Transform your screen with a stunning collection of wallpapers handpicked for you. From breathtaking landscapes to sleek abstract designs, ${AppConstants.appName} has it all.

🎨 Explore thousands of high-definition wallpapers and find the perfect match for your device. With easy-to-use features, setting up your new wallpaper is a breeze!

✨ Features:

Explore a vast library of wallpapers in various categories.
Save your favorites for quick access.
Share your favorite wallpapers with friends effortlessly.
📱 Download $appName now and let your device shine!

${Platform.isIOS ? iOSAppLinkTextConstant : appLinkTextConstant}

#Genz #ringtone #livewallpaper #WallpaperApp #Personalization
                ''';


  ///Privacy Policy

  // static const String privacyPolicyTxt = '''
  // <p>Artonest Pvt Ltd. built the $appName app as an Ad Supported app. This Service is provided by DUIUX Infotech Pvt Ltd. at no cost and is intended for use as is. This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service. If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at $appName unless otherwise defined in this Privacy Policy.<br><br><b>Information Collection and Use</b><br><br>For a better experience, while using our Service, we use device related basic informations like device ID, device Manufacturer, device Model, device OS Version to analyze data for trends and statistics. The information that we request will be retained by us and used as described in this privacy policy. The app does use third party services that may collect information used to identify you. Link to privacy policy of third party service providers used by the app :<br><br><b>Google Play Services</b><br><b>AdMob</b><br><b>Firebase Analytics</b><br><br><b>Log Data</b><br><br>We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.<br><br><b>Cookies</b><br><br>Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service. Service Providers We may employ third-party companies and individuals due to the following reasons: To facilitate our Service; To provide the Service on our behalf; To perform Service-related services; or To assist us in analyzing how our Service is used. We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose. <br><br><b>Security</b><br><br> We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security. <br><br><b>Links to Other Sites</b><br><br> This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services. <br><br><b>Children’s Privacy</b><br><br> These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions. Changes to This Privacy Policy</b> We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page. <br><br><b>Contact Us</b><br><br> If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at mailto:support@duiuxinfotech.com.</p>
  // ''';
//
static const String privacyPolicyTxt = '''
At BestOnest, we are committed to safeguarding your privacy and ensuring your data is handled responsibly. This Privacy Policy explains how we collect, use, disclose, and protect your information when you use our applications and services for iOS, iWatch, and iMac platforms. By using our services, you agree to the collection and use of information as outlined in this policy.

<b>Information We Collect</b>

We collect both personal and non-personal information to deliver and enhance our services.

<b>Personal Information</b>

<b>• User-Provided Data</b> : When you interact with our services, you may provide personal information, such as your name, email address, and payment details.

<b>• Account Information</b> : If you create an account, we may store additional information such as your preferences and settings.

<b>Non-Personal Information</b>

<b>• Device Information</b> : We collect device-related details such as operating system, device type, and usage statistics to optimize app performance.

<b>• Usage Data</b> : We collect anonymized data such as app usage patterns, in-app behavior, and feature preferences to improve user experience.

<b>How We Use Your Information</b>

We use the information we collect to:

 • Provide and improve our applications and services.

 • Personalize your user experience and deliver tailored content.

 • Respond to your inquiries, feedback, or service requests.

 • Send you updates, newsletters, and other relevant communications (you can opt-out at any time).

 • Ensure the security and integrity of our applications and services.

<b>Sharing and Disclosure</b>

We value your trust and handle your personal information with care.

<b>• No Third-Party Sale</b> : We do not sell, trade, or rent your personal information to third parties.

<b>• Service Providers</b> : We may share your information with trusted service providers who assist us in operating our apps or conducting business. These providers are bound by confidentiality agreements and will use your information only as directed by us.

<b>• Legal Compliance</b> : We may disclose information when required by law or to protect our legal rights.

<b>Data Security</b>

BestOnest implements industry-standard security measures to protect your data. However, no system is 100% secure, and we cannot guarantee absolute security. We continuously review and update our security protocols to mitigate risks.

<b>Children's Privacy</b>

Our services are not intended for individuals under the age of 10. We do not knowingly collect or solicit personal information from children. If we become aware that a child under 10 has provided us with personal information, we will take steps to delete such data.

<b>Third-Party Links</b>

Our apps and services may contain links to third-party websites. We are not responsible for the privacy practices of these sites. We recommend reviewing the privacy policies of any external services you engage with.

<b>Your Rights</b>

Depending on your jurisdiction, you may have the right to:

 • Access, update, or delete your personal information.

 • Withdraw consent for certain data processing activities.

 • Request a copy of the data we hold about you.

To exercise these rights, please contact us at <a href="mailto:bestonest.info@gmail.com">bestonest.info@gmail.com</a>.

<b>Changes to This Privacy Policy</b>

We may update this Privacy Policy to reflect changes in our practices or legal requirements. Any updates will be posted on our website, and we will notify you of significant changes. Your continued use of our services after the posting of changes constitutes your acceptance of the updated policy.

<b>Contact Us</b>

If you have any questions or concerns about this Privacy Policy, please contact us at:

<b>BestOnest</b>


Email: <a href="mailto:bestonest.info@gmail.com">bestonest.info@gmail.com</a><br>
Website: <a href="https://www.bestonest.com">www.bestonest.com</a>
  ''';

}