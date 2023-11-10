import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/category_model.dart';
import 'package:ecom_admin/models/product_model.dart';

class DbHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const collectionAdmin = 'Admins';
  static const collectionCategory = 'Categories';
  static const collectionProduct = 'Products';
  static const String collectionUsers = 'Users';
  static const String collectionCart = 'MyCart';
  static const String collectionRating = 'Ratings';
  static const String collectionOrder = 'Orders';

  static Future<bool> isAdmin (String uid) async {
    final snapshot = await _db.collection(collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addCategory(CategoryModel category) {
    final doc = _db.collection(collectionCategory).doc();
    category.id = doc.id;
    return doc.set(category.toJson());
  }

  static Future<void> addProduct(ProductModel product) {
    final doc = _db.collection(collectionProduct).doc();
    product.id = doc.id;
    return doc.set(product.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories () =>
      _db.collection(collectionCategory)
          .orderBy('name', descending: false)
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts () =>
      _db.collection(collectionProduct)
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrders () =>
      _db.collection(collectionOrder)
          .snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser () =>
      _db.collection(collectionUsers)
          .snapshots();

  static Future<void> updateProductField(String id, Map<String, dynamic> map) {
    return _db.collection(collectionProduct).doc(id).update(map);
  }
}