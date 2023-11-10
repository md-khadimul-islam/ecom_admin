import 'dart:io';

import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/models/product_model.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:ecom_admin/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewProductPage extends StatefulWidget {
  static const String routeName = '/newproduct';

  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  String? localImagePath;
  CategoryModel? categoryModel;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('New Product'),
        actions: [
          IconButton(
            onPressed: _saveProduct,
            icon: const Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            _buildImageSection(),
            _buildCategorySection(),
            _buildTextFieldSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Product Image',
              style: TextStyle(fontSize: 20),
            ),
            localImagePath == null
                ? const Icon(
                    Icons.card_giftcard_outlined,
                    size: 150,
                  )
                : Image.file(
                    File(localImagePath!),
                    width: 150,
                    height: 150,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    _getImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text('Capture'),
                ),
                TextButton.icon(
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo_outlined),
                  label: const Text('Gallery'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _getImage(ImageSource source) async {
    final file =
        await ImagePicker().pickImage(source: source, imageQuality: 80);
    if (file != null) {
      setState(() {
        localImagePath = file.path;
      });
    }
  }

  Widget _buildCategorySection() {
    return Card(
      child: Consumer<ProductProvider>(
        builder: (context, provider, child) => SizedBox(
          child: DropdownButtonFormField<CategoryModel>(
            decoration: const InputDecoration(border: OutlineInputBorder()),
            value: categoryModel,
            hint: const Text('Select a category'),
            isExpanded: true,
            items: provider.categoryList
                .map(
                  (category) => DropdownMenuItem<CategoryModel>(
                    value: category,
                    child: Text(category.name),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(
                () {
                  categoryModel = value;
                },
              );
            },
            validator: (value) {
              if (value == null) {
                return 'This field must not be empty';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Widget _buildTextFieldSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Product Name',
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field must not be empty';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: TextFormField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Product Price',
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field must not be empty';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: TextFormField(
            controller: _descriptionController,
            keyboardType: TextInputType.text,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Product Description (Optional)',
              filled: true,
            ),
            validator: (value) {
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: TextFormField(
            controller: _stockController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Product Stock',
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field must not be empty';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  void _saveProduct() async {
    if (localImagePath == null) {
      showMsg(context, 'Please select a product image');
      return;
    }
    if (_formKey.currentState!.validate()) {
      final imageUrl = await Provider.of<ProductProvider>(context, listen: false).uploadImage(localImagePath!);
      final productModel = ProductModel(
        name: _nameController.text,
        category: categoryModel!,
        price: num.parse(_priceController.text),
        stock: num.parse(_stockController.text),
        imageUrl: imageUrl,
      );

      EasyLoading.show(status: 'Please wait');
      Provider.of<ProductProvider>(context, listen: false).addProduct(productModel)
      .then((value) {
        EasyLoading.dismiss();
        showMsg(context, 'Saved');
        _resetFields();
      })
      .catchError((error) {
        EasyLoading.dismiss();
        showMsg(context, 'Could not save');
      });
    }
  }

  void _resetFields() {
    setState(() {
      localImagePath = null;
      categoryModel = null;
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _stockController.clear();
    });
  }
}
