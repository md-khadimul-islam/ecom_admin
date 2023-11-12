import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';

class AppUserExpansionItem {
  AppUserExpansionHeader header;
  AppUserExpansionBody body;
  bool isExpanded;

  AppUserExpansionItem({
    required this.header,
    required this.body,
    this.isExpanded = false,
  });
}

class AppUserExpansionHeader {
  String email;
  Timestamp timestamp;

  AppUserExpansionHeader({
    required this.email,
    required this.timestamp,
  });
}

class AppUserExpansionBody {
  AddressModel? userAddress;
  String? displayName;
  String? phoneNumber;

  AppUserExpansionBody({
    this.userAddress,
    this.displayName,
    this.phoneNumber,
  });
}
