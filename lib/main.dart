import 'package:ecom_admin/pages/category_page.dart';
import 'package:ecom_admin/pages/dashboard_screen.dart';
import 'package:ecom_admin/pages/launcher_screen.dart';
import 'package:ecom_admin/pages/login_screen.dart';
import 'package:ecom_admin/pages/new_product_page.dart';
import 'package:ecom_admin/pages/product_details_page.dart';
import 'package:ecom_admin/pages/view_product_page.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LauncherScreen.routeName,
      builder: EasyLoading.init(),
      routes: {
        LauncherScreen.routeName : (_) => const LauncherScreen(),
        LoginScreen.routeName : (_) => const LoginScreen(),
        DashboardScreen.routeName : (_) => const DashboardScreen(),
        NewProductPage.routeName : (_) => const NewProductPage(),
        ViewProductPage.routeName : (_) => const ViewProductPage(),
        CategoryPage.routeName : (_) => const CategoryPage(),
        ProductDetailsPage.routeName : (_) => const ProductDetailsPage(),
      },
    );
  }
}