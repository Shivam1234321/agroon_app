// To parse this JSON data, do
//
//     final checkCouponModel = checkCouponModelFromJson(jsonString);

import 'dart:convert';

List<CheckCouponModel> checkCouponModelFromJson(String str) => List<CheckCouponModel>.from(json.decode(str).map((x) => CheckCouponModel.fromJson(x)));

String checkCouponModelToJson(List<CheckCouponModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckCouponModel {
  CheckCouponModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  Data data;

  factory CheckCouponModel.fromJson(Map<String, dynamic> json) => CheckCouponModel(
    status: json["status"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.couponId,
    this.couponCode,
    this.discount,
    this.totalDiscountAmount,
  });

  String couponId;
  String couponCode;
  String discount;
  int totalDiscountAmount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    couponId: json["CouponId"],
    couponCode: json["CouponCode"],
    discount: json["Discount"],
    totalDiscountAmount: json["TotalDiscountAmount"],
  );

  Map<String, dynamic> toJson() => {
    "CouponId": couponId,
    "CouponCode": couponCode,
    "Discount": discount,
    "TotalDiscountAmount": totalDiscountAmount,
  };
}
