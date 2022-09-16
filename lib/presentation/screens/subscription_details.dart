import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wallets_control/shared/shared_core.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedCore.buildAppBar(
        title: 'Subscription',
      ),
      body: ListView(
        children: const [
          SizedBox(
            height: 150,
            child: Center(
              child: Text(
                'Plan Image here',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Plan'),
            trailing: Text('Premium'),
          ),
          Divider(),
          ListTile(
            title: Text('Expiry Date'),
            trailing: Text('1/1/2023'),
          ),
          Divider(),
          ListTile(
            title: Text('Max no. of wallets'),
            trailing: Text('5'),
          ),
        ],
      ),
    );
  }
}
