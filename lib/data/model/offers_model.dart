// To parse this JSON data, do
//
//     final offersModel = offersModelFromJson(jsonString);

import 'dart:convert';

List<OffersModel> offersModelFromJson(String str) => List<OffersModel>.from(json.decode(str).map((x) => OffersModel.fromJson(x)));

String offersModelToJson(List<OffersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OffersModel {
  OffersModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  List<OffersData> data;

  factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
    status: json["status"],
    msg: json["msg"],
    data: List<OffersData>.from(json["data"].map((x) => OffersData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OffersData {
  OffersData({
    this.couponId,
    this.title,
    this.couponCode,
    this.discount,
    this.expire,
    this.type,
    this.image,
  });

  String couponId;
  String title;
  String couponCode;
  String discount;
  String expire;
  String type;
  String image;

  factory OffersData.fromJson(Map<String, dynamic> json) => OffersData(
    couponId: json["CouponId"],
    title: json["Title"],
    couponCode: json["CouponCode"],
    discount: json["Discount"],
    expire: json["Expire"],
    type: json["Type"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "CouponId": couponId,
    "Title": title,
    "CouponCode": couponCode,
    "Discount": discount,
    "Expire": expire,
    // "Expire": "${expire.year.toString().padLeft(4, '0')}-${expire.month.toString().padLeft(2, '0')}-${expire.day.toString().padLeft(2, '0')}",
    "Type": type,
    "Image": image,
  };
}
