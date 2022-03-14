// To parse this JSON data, do
//
//     final getAddressModel = getAddressModelFromJson(jsonString);

import 'dart:convert';

List<GetAddressModel> getAddressModelFromJson(String str) => List<GetAddressModel>.from(json.decode(str).map((x) => GetAddressModel.fromJson(x)));

String getAddressModelToJson(List<GetAddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAddressModel {
  GetAddressModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  List<GetAddressData> data;

  factory GetAddressModel.fromJson(Map<String, dynamic> json) => GetAddressModel(
    status: json["status"],
    msg: json["msg"],
    data: List<GetAddressData>.from(json["data"].map((x) => GetAddressData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetAddressData {
  GetAddressData({
    this.addressId,
    this.name,
    this.mobile,
    this.address,
    this.landMark,
    this.city,
    this.pincode,
  });

  String addressId;
  String name;
  String mobile;
  String address;
  String landMark;
  String city;
  String pincode;

  factory GetAddressData.fromJson(Map<String, dynamic> json) => GetAddressData(
    addressId: json["AddressId"],
    name: json["Name"],
    mobile: json["Mobile"],
    address: json["Address"],
    landMark: json["LandMark"],
    city: json["City"],
    pincode: json["Pincode"],
  );

  Map<String, dynamic> toJson() => {
    "AddressId": addressId,
    "Name": name,
    "Mobile": mobile,
    "Address": address,
    "LandMark": landMark,
    "City": city,
    "Pincode": pincode,
  };
}
