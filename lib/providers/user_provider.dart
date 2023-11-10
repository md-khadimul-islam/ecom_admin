import 'package:ecom_admin/models/app_user.dart';
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';

class UserProvider extends ChangeNotifier {
  List<AppUser> userList = [];


  getAllUsers() {
    DbHelper.getAllUser().listen((snapshot) {
      userList = List.generate(snapshot.docs.length,
              (index) => AppUser.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}