import 'package:ecom_admin/providers/order_provider.dart';
import 'package:ecom_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_details_page.dart';

class OrderListPage extends StatelessWidget {
  static const String routeName = '/orderlist';
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('All Orders'),
      ),
      body: Consumer<OrderProvider> (
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.orderList.length,
          itemBuilder: (context, index) {
            final order = provider.orderList[index];
            return ListTile(
              onTap: () => Navigator.pushNamed(context, OrderDetailsPage.routeName, arguments: order.orderId),
              title: Text(order.orderId, style: const TextStyle(fontSize: 20),),
              subtitle: Text(order.orderStatus, style: const TextStyle(fontSize: 20),),
              trailing: Text('$currencySymbol ${order.totalAmount}', style: const TextStyle(fontSize: 20),),
            );
          },
        ),
      ),
    );
  }
}
