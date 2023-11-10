import 'package:ecom_admin/auth/auth_service.dart';
import 'package:ecom_admin/customwidgets/dashboard_item_view.dart';
import 'package:ecom_admin/models/dashboard_item.dart';
import 'package:ecom_admin/pages/launcher_screen.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout().then((value) =>
                  Navigator.pushReplacementNamed(
                      context, LauncherScreen.routeName));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        leading: const Icon(Icons.menu),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: DashboardItem.DashboardItemList.length,
        itemBuilder: (context, index) {
          final item = DashboardItem.DashboardItemList[index];
          return DashboardItemView(item: item);
        },
      ),
    );
  }
}
