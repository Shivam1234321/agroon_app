// To parse this JSON data, do
//
//     final showCartModel = showCartModelFromJson(jsonString);

import 'dart:convert';

List<ShowCartModel> showCartModelFromJson(String str) => List<ShowCartModel>.from(json.decode(str).map((x) => ShowCartModel.fromJson(x)));

String showCartModelToJson(List<ShowCartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowCartModel {
  ShowCartModel({
    this.status,
    this.msg,
    this.data,
    this.totaldiscount,
    this.actualPrice,
    this.totalamount,
  });

  int status;
  String msg;
  List<ShowCartData> data;
  double totaldiscount;
  int actualPrice;
  double totalamount;

  factory ShowCartModel.fromJson(Map<String, dynamic> json) => ShowCartModel(
    status: json["status"],
    msg: json["msg"],
    data: List<ShowCartData>.from(json["data"].map((x) => ShowCartData.fromJson(x))),
    totaldiscount: json["totaldiscount"].toDouble(),
    actualPrice: json["actual_price"],
    totalamount: json["totalamount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "totaldiscount": totaldiscount,
    "actual_price": actualPrice,
    "totalamount": totalamount,
  };
}

class ShowCartData {
  ShowCartData({
    this.cartId,
    this.productId,
    this.priceId,
    this.image,
    this.productName,
    this.title,
    this.category,
    this.mrp,
    this.gst,
    this.gstPrice,
    this.discount,
    this.offerPrice,
    this.perProductTotalAmount,
    this.cartQuantity,
    this.totalAmount,
  });

  String cartId;
  String productId;
  String priceId;
  String image;
  String productName;
  String title;
  String category;
  String mrp;
  String gst;
  String gstPrice;
  String discount;
  String offerPrice;
  String perProductTotalAmount;
  String cartQuantity;
  double totalAmount;

  factory ShowCartData.fromJson(Map<String, dynamic> json) => ShowCartData(
    cartId: json["CartId"],
    productId: json["ProductId"],
    priceId: json["PriceId"],
    image: json["Image"],
    productName: json["ProductName"],
    title: json["Title"],
    category: json["Category"],
    mrp: json["MRP"],
    gst: json["GST"],
    gstPrice: json["gstPrice"],
    discount: json["Discount"],
    offerPrice: json["OfferPrice"],
    perProductTotalAmount: json["PerProductTotalAmount"],
    cartQuantity: json["CartQuantity"],
    totalAmount: json["TotalAmount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "CartId": cartId,
    "ProductId": productId,
    "PriceId": priceId,
    "Image": image,
    "ProductName": productName,
    "Title": title,
    "Category": category,
    "MRP": mrp,
    "GST": gst,
    "gstPrice": gstPrice,
    "Discount": discount,
    "OfferPrice": offerPrice,
    "PerProductTotalAmount": perProductTotalAmount,
    "CartQuantity": cartQuantity,
    "TotalAmount": totalAmount,
  };
}
