import 'package:ecom_admin/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatelessWidget {
  static const String routeName = '/order_details';
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)!.settings.arguments as String;
    final order = Provider.of<OrderProvider>(context, listen: false).getOrderById(orderId);
    return Scaffold(
      body: ListView(
        children: [
          headerSection(title: 'Product Info: ',),
          Card(
            color: Colors.deepPurpleAccent,
            child: Column(
              children: order.orderDetails.map((e) => ListTile(
                title: Text(e.productName, style: const TextStyle(fontSize: 20),),
                trailing: Text('${e.quantity} x ${e.price}', style: const TextStyle(fontSize: 20),),
              )).toList(),
            ),
          )
        ],
      ),
    );
  }

  Padding headerSection({required String title}) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: const TextStyle(fontSize: 20),),
        );
  }
}
