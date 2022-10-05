import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:wallets_control/controllers/plans_controller.dart';
import 'package:wallets_control/models/plan_model.dart';
import 'package:wallets_control/shared/shared_core.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  final plansController = Get.find<PlansController>();

  @override
  void initState() {
    super.initState();
    getPlans();
  }

  Future<void> getPlans() async {
    await plansController.getPlans();
  }

  ListTile buildPlanListTile({
    required String title,
    required String trailing,
  }) {
    return ListTile(
      title: Text(title),
      trailing: Text(trailing),
      contentPadding: const EdgeInsets.all(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedCore.buildAppBar(
        title: 'Plans',
      ),
      body: Obx(() => plansController.isLoading.value
          ? Center(
              child: SharedCore.buildLoaderIndicator(),
            )
          : plansController.plans.isEmpty
              ? const Center(
                  child: Text('No plans available'),
                )
              : ListView.builder(
                  itemCount: plansController.plans.length,
                  itemBuilder: (context, i) {
                    final planItem = plansController.plans[i];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                planItem.planName,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              buildPlanListTile(
                                title: 'Amount',
                                trailing: planItem.amount.toString(),
                              ),
                              Divider(),
                              buildPlanListTile(
                                title: 'Wallets Limit',
                                trailing: planItem.walletsLimit.toString(),
                              ),
                              Divider(),
                              buildPlanListTile(
                                title: 'Expiry',
                                trailing: planItem.expiry,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
