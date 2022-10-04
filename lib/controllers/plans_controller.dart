import 'package:get/get.dart';
import 'package:wallets_control/models/plan_model.dart';
import 'package:wallets_control/shared/api_routes.dart';
import 'package:wallets_control/shared/shared_core.dart';

class PlansController extends GetConnect {
  RxList<PlanModel> plans = <PlanModel>[].obs;

  Rx<bool> isLoading = false.obs;

  Future<void> getPlans() async {
    try {
      isLoading.value = true;

      const url = ApiRoutes.plans;
      print(url);

      final Response response = await get(
        url,
        headers: {
          'Authorization': SharedCore.getAccessToken().value,
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        plans.value = (response.body['data'] as List)
            .map((plan) => PlanModel.fromJson(plan))
            .toList();
            
        isLoading.value = false;
      }
    } catch (e) {}
  }
}
