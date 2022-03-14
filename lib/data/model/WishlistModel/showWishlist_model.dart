// To parse this JSON data, do
//
//     final showWishlistModel = showWishlistModelFromJson(jsonString);

import 'dart:convert';

List<ShowWishlistModel> showWishlistModelFromJson(String str) => List<ShowWishlistModel>.from(json.decode(str).map((x) => ShowWishlistModel.fromJson(x)));

String showWishlistModelToJson(List<ShowWishlistModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowWishlistModel {
  ShowWishlistModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  List<ShowWishlistData> data;

  factory ShowWishlistModel.fromJson(Map<String, dynamic> json) => ShowWishlistModel(
    status: json["status"],
    msg: json["msg"],
    data: List<ShowWishlistData>.from(json["data"].map((x) => ShowWishlistData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ShowWishlistData {
  ShowWishlistData({
    this.wishlistId,
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
    this.cartStatus,
    this.cartQuantity,
  });

  String wishlistId;
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
  int cartStatus;
  String cartQuantity;

  factory ShowWishlistData.fromJson(Map<String, dynamic> json) => ShowWishlistData(
    wishlistId: json["WishlistId"],
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
    cartStatus: json["CartStatus"],
    cartQuantity: json["CartQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "WishlistId": wishlistId,
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
    "CartStatus": cartStatus,
    "CartQuantity": cartQuantity,
  };
}
