import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_shop_app/providers/orders.dart' show Orders;
import 'package:udemy_shop_app/widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context).orders;
    return Scaffold(
      appBar: AppBar(title: const Text("Your Orders")),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(orderData[i]),
        itemCount: orderData.length,
      ),
    );
  }
}
