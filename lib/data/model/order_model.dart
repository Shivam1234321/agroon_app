// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  OrderData data;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    status: json["status"],
    msg: json["msg"],
    data: OrderData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class OrderData {
  OrderData({
    this.orderId,
    this.orderKey,
  });

  int orderId;
  String orderKey;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    orderId: json["order_id"],
    orderKey: json["order_key"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "order_key": orderKey,
  };
}
