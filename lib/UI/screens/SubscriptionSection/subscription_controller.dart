import 'package:get/get.dart';

class SubscriptionController extends GetxController {

  RxInt selectedPlan = 0.obs;

  RxList<SubscriptionPlansModel> subscriptionPlan = <SubscriptionPlansModel>[
    SubscriptionPlansModel(duration: "Monthly",price: "20.00",trailText: "/month after 3 days free",),
    SubscriptionPlansModel(duration: "Yearly",price: "5.00",trailText: "/month after 3 days free",),
  ].obs;
}

class SubscriptionPlansModel {
  String price, trailText, duration;

  SubscriptionPlansModel({
    required this.price,
    required this.duration,
    required this.trailText,
  });
}
