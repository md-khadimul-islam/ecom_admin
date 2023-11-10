import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_admin/pages/product_details_page.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewProductPage extends StatefulWidget {
  static const String routeName = '/viewproduct';
  const ViewProductPage({super.key});

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('View Product'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, p, child) => ListView.builder(
          itemCount: p.productList.length,
          itemBuilder: (context, index) {
            final product = p.productList[index];
            return ListTile(
              onTap: () => Navigator.pushNamed(context, ProductDetailsPage.routeName, arguments:product.id ),
              leading: SizedBox(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(seconds: 2),
                  fadeInCurve: Curves.easeInOut,
                  imageUrl: product.imageUrl,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error),),
                ),
              ),
              title: Text(product.name),
              subtitle: Text('Stock: ${product.stock}', style: const TextStyle(fontSize: 15),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star_outline, color: Colors.amber, size: 50,),
                  Text(product.avgRating.toStringAsFixed(1),style: Theme.of(context).textTheme.labelLarge,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
