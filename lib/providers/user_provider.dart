import 'package:ecom_admin/models/app_user.dart';
import 'package:flutter/foundation.dart';

import '../db/db_helper.dart';
import '../models/user_expansion_item.dart';

class UserProvider extends ChangeNotifier {
  List<AppUser> userList = [];


  getAllUsers() {
    DbHelper.getAllUser().listen((snapshot) {
      userList = List.generate(snapshot.docs.length,
              (index) => AppUser.fromJson(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  List<AppUserExpansionItem> getAppUserExpansionItemList () {
    List<AppUserExpansionItem> items = [];
    for(final user in userList) {
      final header = AppUserExpansionHeader(email: user.email, timestamp: user.userCreationTime);
      final body = AppUserExpansionBody(
        userAddress: user.userAddress,
        phoneNumber: user.phoneNumber,
        displayName: user.phoneNumber,
      );
      final expansionItem = AppUserExpansionItem(header: header, body: body);
      items.add(expansionItem);
    }
    return items;
  }
}