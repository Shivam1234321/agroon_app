// To parse this JSON data, do
//
//     final showOrderModel = showOrderModelFromJson(jsonString);

import 'dart:convert';

List<ShowOrderModel> showOrderModelFromJson(String str) => List<ShowOrderModel>.from(json.decode(str).map((x) => ShowOrderModel.fromJson(x)));

String showOrderModelToJson(List<ShowOrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowOrderModel {
  ShowOrderModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  List<ShowOrderData> data;

  factory ShowOrderModel.fromJson(Map<String, dynamic> json) => ShowOrderModel(
    status: json["status"],
    msg: json["msg"],
    data: List<ShowOrderData>.from(json["data"].map((x) => ShowOrderData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ShowOrderData {
  ShowOrderData({
    this.orderId,
    this.orderKey,
    this.userName,
    this.email,
    this.orderStatus,
    this.paymentType,
    this.totalPayment,
    this.placedOn,
  });

  String orderId;
  String orderKey;
  String userName;
  String email;
  String orderStatus;
  String paymentType;
  String totalPayment;
  String placedOn;

  factory ShowOrderData.fromJson(Map<String, dynamic> json) => ShowOrderData(
    orderId: json["OrderId"],
    orderKey: json["OrderKey"],
    userName: json["UserName"],
    email: json["Email"],
    orderStatus: json["OrderStatus"],
    paymentType: json["PaymentType"],
    totalPayment: json["TotalPayment"],
    placedOn: json["PlacedOn"],
  );

  Map<String, dynamic> toJson() => {
    "OrderId": orderId,
    "OrderKey": orderKey,
    "UserName": userName,
    "Email": email,
    "OrderStatus": orderStatus,
    "PaymentType": paymentType,
    "TotalPayment": totalPayment,
    "PlacedOn": placedOn,
  };
}
