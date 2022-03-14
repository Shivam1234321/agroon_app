// To parse this JSON data, do
//
//     final orderNotificationModel = orderNotificationModelFromJson(jsonString);

import 'dart:convert';

List<OrderNotificationModel> orderNotificationModelFromJson(String str) => List<OrderNotificationModel>.from(json.decode(str).map((x) => OrderNotificationModel.fromJson(x)));

String orderNotificationModelToJson(List<OrderNotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderNotificationModel {
  OrderNotificationModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  List<OrderNotificationData> data;

  factory OrderNotificationModel.fromJson(Map<String, dynamic> json) => OrderNotificationModel(
    status: json["status"],
    msg: json["msg"],
    data: List<OrderNotificationData>.from(json["data"].map((x) => OrderNotificationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderNotificationData {
  OrderNotificationData({
    this.notificationId,
    this.title,
    this.description,
    this.image,
    this.date,
  });

  String notificationId;
  String title;
  String description;
  String image;
  String date;

  factory OrderNotificationData.fromJson(Map<String, dynamic> json) => OrderNotificationData(
    notificationId: json["NotificationId"],
    title: json["Title"],
    description: json["Description"],
    image: json["Image"],
    date: json["Date"],
  );

  Map<String, dynamic> toJson() => {
    "NotificationId": notificationId,
    "Title": title,
    "Description": description,
    "Image": image,
    "Date": date,
  };
}
