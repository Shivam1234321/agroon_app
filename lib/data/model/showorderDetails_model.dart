// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

List<OrderDetailsModel> orderDetailsModelFromJson(String str) => List<OrderDetailsModel>.from(json.decode(str).map((x) => OrderDetailsModel.fromJson(x)));

String orderDetailsModelToJson(List<OrderDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetailsModel {
  OrderDetailsModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  OrderDetailsData data;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    status: json["status"],
    msg: json["msg"],
    data: OrderDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class OrderDetailsData {
  OrderDetailsData({
    this.address,
    this.order,
    this.product,
  });

  Address address;
  Order order;
  List<Product> product;

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) => OrderDetailsData(
    address: Address.fromJson(json["address"]),
    order: Order.fromJson(json["order"]),
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "address": address.toJson(),
    "order": order.toJson(),
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.userName,
    this.mobile,
    this.address,
    this.addressLandMark,
    this.addressCity,
    this.addressPincode,
    this.addressState,
  });

  String userName;
  String mobile;
  String address;
  String addressLandMark;
  String addressCity;
  String addressPincode;
  String addressState;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    userName: json["UserName"],
    mobile: json["Mobile"],
    address: json["Address"],
    addressLandMark: json["AddressLandMark"],
    addressCity: json["AddressCity"],
    addressPincode: json["AddressPincode"],
    addressState: json["AddressState"],
  );

  Map<String, dynamic> toJson() => {
    "UserName": userName,
    "Mobile": mobile,
    "Address": address,
    "AddressLandMark": addressLandMark,
    "AddressCity": addressCity,
    "AddressPincode": addressPincode,
    "AddressState": addressState,
  };
}

class Order {
  Order({
    this.orderId,
    this.orderKey,
    this.orderStatus,
    this.paymentType,
    this.placedOn,
    this.subTotal,
    this.shippingCost,
    this.totalPayment,
    this.paidAmount,
    this.remainAmount,
    this.paymentStatus,
    this.orderPaymentStatus,
  });

  String orderId;
  String orderKey;
  String orderStatus;
  String paymentType;
  String placedOn;
  String subTotal;
  int shippingCost;
  String totalPayment;
  int paidAmount;
  double remainAmount;
  int paymentStatus;
  String orderPaymentStatus;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderId: json["OrderId"],
    orderKey: json["OrderKey"],
    orderStatus: json["OrderStatus"],
    paymentType: json["PaymentType"],
    placedOn: json["PlacedOn"],
    subTotal: json["SubTotal"],
    shippingCost: json["ShippingCost"],
    totalPayment: json["TotalPayment"],
    paidAmount: json["PaidAmount"],
    remainAmount: json["RemainAmount"].toDouble(),
    paymentStatus: json["PaymentStatus"],
    orderPaymentStatus: json["OrderPaymentStatus"],
  );

  Map<String, dynamic> toJson() => {
    "OrderId": orderId,
    "OrderKey": orderKey,
    "OrderStatus": orderStatus,
    "PaymentType": paymentType,
    "PlacedOn": placedOn,
    "SubTotal": subTotal,
    "ShippingCost": shippingCost,
    "TotalPayment": totalPayment,
    "PaidAmount": paidAmount,
    "RemainAmount": remainAmount,
    "PaymentStatus": paymentStatus,
    "OrderPaymentStatus": orderPaymentStatus,
  };
}

class Product {
  Product({
    this.productId,
    this.priceId,
    this.productName,
    this.image,
    this.totalAmount,
    this.quantity,
  });

  String productId;
  String priceId;
  String productName;
  String image;
  double totalAmount;
  String quantity;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["ProductId"],
    priceId: json["PriceId"],
    productName: json["ProductName"],
    image: json["Image"],
    totalAmount: json["TotalAmount"].toDouble(),
    quantity: json["Quantity"],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "PriceId": priceId,
    "ProductName": productName,
    "Image": image,
    "TotalAmount": totalAmount,
    "Quantity": quantity,
  };
}
