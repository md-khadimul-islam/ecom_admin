import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_admin/models/app_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/timestamp_converter.dart';
import 'cart_model.dart';
part 'order_model.freezed.dart';
part 'order_model.g.dart';

@unfreezed
class OrderModel with _$OrderModel {
  @JsonSerializable(explicitToJson: true)

  factory OrderModel({
    required String orderId,
    required AppUser appUser,
    required num totalAmount,
    required String orderStatus,
    required List<CartModel> orderDetails,
    @Timestampconverter() required Timestamp orderDateTime,
}) = _OrderModel;


  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}