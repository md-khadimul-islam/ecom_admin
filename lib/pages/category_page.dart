import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';

  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Categories'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, p, child) => ListView.builder(
          itemCount: p.categoryList.length,
          itemBuilder: (context, index) {
            final category = p.categoryList[index];
            return ListTile(
              title: Text(category.name),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSingleTextInputDialog(
            context: context,
            title: 'Add Category',
            onSave: (value) {
              EasyLoading.show(status: 'Please wait');
              Provider.of<ProductProvider>(context, listen: false)
                  .addCategory(value)
                  .then((value) {
                EasyLoading.dismiss();
                showMsg(context, 'Category Saved');
              }).catchError((error) {
                EasyLoading.dismiss();
                showMsg(context, 'Could not save');
              });
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
