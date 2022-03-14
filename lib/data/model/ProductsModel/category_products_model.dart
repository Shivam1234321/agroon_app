// To parse this JSON data, do
//
//     final categoryProductsModel = categoryProductsModelFromJson(jsonString);

import 'dart:convert';

List<CategoryProductsModel> categoryProductsModelFromJson(String str) => List<CategoryProductsModel>.from(json.decode(str).map((x) => CategoryProductsModel.fromJson(x)));

String categoryProductsModelToJson(List<CategoryProductsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryProductsModel {
  CategoryProductsModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  List<CategoryProductsData> data;

  factory CategoryProductsModel.fromJson(Map<String, dynamic> json) => CategoryProductsModel(
    status: json["status"],
    msg: json["msg"],
    data: List<CategoryProductsData>.from(json["data"].map((x) => CategoryProductsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryProductsData {
  CategoryProductsData({
    this.productId,
    this.productName,
    this.mainTitle,
    this.categoryName,
    this.subCategoryName,
    this.brandName,
    this.technicalName,
    this.shortDescription,
    this.description,
    this.vendorName,
    this.priceDetails,
  });

  String productId;
  String productName;
  String mainTitle;
  String categoryName;
  String subCategoryName;
  String brandName;
  String technicalName;
  String shortDescription;
  String description;
  String vendorName;
  List<PriceDetail> priceDetails;

  factory CategoryProductsData.fromJson(Map<String, dynamic> json) => CategoryProductsData(
    productId: json["ProductId"],
    productName: json["ProductName"],
    mainTitle: json["MainTitle"],
    categoryName: json["CategoryName"],
    subCategoryName: json["SubCategoryName"],
    brandName: json["BrandName"],
    technicalName: json["TechnicalName"],
    shortDescription: json["ShortDescription"],
    description: json["Description"],
    vendorName: json["VendorName"],
    priceDetails: List<PriceDetail>.from(json["PriceDetails"].map((x) => PriceDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductName": productName,
    "MainTitle": mainTitle,
    "CategoryName": categoryName,
    "SubCategoryName": subCategoryName,
    "BrandName": brandName,
    "TechnicalName": technicalName,
    "ShortDescription": shortDescription,
    "Description": description,
    "VendorName": vendorName,
    "PriceDetails": List<dynamic>.from(priceDetails.map((x) => x.toJson())),
  };
}

class PriceDetail {
  PriceDetail({
    this.priceId,
    this.productCode,
    this.mrp,
    this.gst,
    this.gstAmount,
    this.discount,
    this.offerprice,
    this.alternetQuantity,
    this.weight,
    this.alternetUnit,
    this.hsn,
    this.sku,
    this.priceImg,
    this.title,
    this.cartStatus,
    this.cartQuantity,
    this.wishlistStatus,
    this.totlaAmount,
  });

  String priceId;
  String productCode;
  String mrp;
  String gst;
  String gstAmount;
  String discount;
  String offerprice;
  String alternetQuantity;
  String weight;
  String alternetUnit;
  String hsn;
  String sku;
  List<String> priceImg;
  String title;
  int cartStatus;
  int cartQuantity;
  int wishlistStatus;
  String totlaAmount;

  factory PriceDetail.fromJson(Map<String, dynamic> json) => PriceDetail(
    priceId: json["PriceId"],
    productCode: json["ProductCode"],
    mrp: json["MRP"],
    gst: json["GST"],
    gstAmount: json["GSTAmount"],
    discount: json["Discount"],
    offerprice: json["offerprice"],
    alternetQuantity: json["AlternetQuantity"],
    weight: json["Weight"],
    alternetUnit: json["AlternetUnit"],
    hsn: json["HSN"],
    sku: json["sku"],
    priceImg: List<String>.from(json["price_img"].map((x) => x)),
    title: json["Title"],
    cartStatus: json["CartStatus"],
    cartQuantity: json["CartQuantity"],
    wishlistStatus: json["WishlistStatus"],
    totlaAmount: json["TotlaAmount"],
  );

  Map<String, dynamic> toJson() => {
    "PriceId": priceId,
    "ProductCode": productCode,
    "MRP": mrp,
    "GST": gst,
    "GSTAmount": gstAmount,
    "Discount": discount,
    "offerprice": offerprice,
    "AlternetQuantity": alternetQuantity,
    "Weight": weight,
    "AlternetUnit": alternetUnit,
    "HSN": hsn,
    "sku": sku,
    "price_img": List<dynamic>.from(priceImg.map((x) => x)),
    "Title": title,
    "CartStatus": cartStatus,
    "CartQuantity": cartQuantity,
    "WishlistStatus": wishlistStatus,
    "TotlaAmount": totlaAmount,
  };
}
