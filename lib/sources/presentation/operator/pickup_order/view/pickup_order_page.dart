import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'pickup_order_view.dart';

class PickupOrderPage extends StatefulWidget {
  const PickupOrderPage({super.key});

  @override
  State<PickupOrderPage> createState() => PickupOrderPageState();
}

class PickupOrderPageState extends State<PickupOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(title: "Pickup Order"),
      body: const PickupOrderView(),
    );
  }
}
