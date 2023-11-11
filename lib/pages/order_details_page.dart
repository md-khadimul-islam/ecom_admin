import 'package:ecom_admin/customwidgets/radio_group.dart';
import 'package:ecom_admin/models/order_model.dart';
import 'package:ecom_admin/providers/order_provider.dart';
import 'package:ecom_admin/utils/constants.dart';
import 'package:ecom_admin/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  static const String routeName = '/order_details';

  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late OrderModel order;
  late String groupValue;

  @override
  void didChangeDependencies() {
    final orderId = ModalRoute.of(context)!.settings.arguments as String;
    order = Provider.of<OrderProvider>(context).getOrderById(orderId);
    groupValue = order.orderStatus;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          headerSection(title: 'Product Info: '),
          productSection(order),
          headerSection(title: 'Customer Info: '),
          userSection(order),
          headerSection(title: 'Order Status: '),
          orderStatusSection(),
        ],
      ),
    );
  }

  ListTile orderStatusSection() {
    return ListTile(
          title: Text(
            order.orderStatus,
            style: const TextStyle(fontSize: 20),
          ),
          trailing: order.orderStatus == OrderStatus.pending || order.orderStatus == OrderStatus.processing ?IconButton(
            onPressed: () {
              _showOrderStatusDialog(order);
            },
            icon: const Icon(
              Icons.edit_outlined,
              size: 30,
            ),
          ) : null,
        );
  }

  Card userSection(OrderModel order) {
    return Card(
      color: Colors.cyan,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order.appUser.displayName ?? order.appUser.email,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              order.appUser.phoneNumber ?? 'Phone number not found',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${order.appUser.userAddress?.streetAddress},${order.appUser.userAddress?.city},${order.appUser.userAddress?.zipcode}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Card productSection(OrderModel order) {
    return Card(
      color: Colors.deepPurpleAccent,
      child: Column(
        children: order.orderDetails
            .map((cartModel) => ListTile(
                  title: Text(
                    cartModel.productName,
                    style: const TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    '${cartModel.quantity} x ${cartModel.price}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Padding headerSection({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  void _showOrderStatusDialog(OrderModel order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Order Status'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StatefulBuilder(
            builder: (context, setBuildState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioGroup(
                  text: OrderStatus.pending,
                  value: OrderStatus.pending,
                  groupValue: groupValue,
                  onChange: (value) {
                    setBuildState(() {
                      groupValue = value;
                    });
                  },
                ),
                RadioGroup(
                  text: OrderStatus.processing,
                  value: OrderStatus.processing,
                  groupValue: groupValue,
                  onChange: (value) {
                    setBuildState(() {
                      groupValue = value;
                    });
                  },
                ),
                RadioGroup(
                  text: OrderStatus.delivered,
                  value: OrderStatus.delivered,
                  groupValue: groupValue,
                  onChange: (value) {
                    setBuildState(() {
                      groupValue = value;
                    });
                  },
                ),
                RadioGroup(
                  text: OrderStatus.cancelled,
                  value: OrderStatus.cancelled,
                  groupValue: groupValue,
                  onChange: (value) {
                    setBuildState(() {
                      groupValue = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<OrderProvider>(context, listen: false).updateOrderStatus(order.orderId, groupValue);
              Navigator.pop(context);
            },
            child: const Text('UPDATE'),
          ),
        ],
      ),
    );
  }
}
