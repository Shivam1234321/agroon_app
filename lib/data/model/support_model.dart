// To parse this JSON data, do
//
//     final supportModel = supportModelFromJson(jsonString);

import 'dart:convert';

List<SupportModel> supportModelFromJson(String str) => List<SupportModel>.from(json.decode(str).map((x) => SupportModel.fromJson(x)));

String supportModelToJson(List<SupportModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupportModel {
  SupportModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  SupportData data;

  factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
    status: json["status"],
    msg: json["msg"],
    data: SupportData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class SupportData {
  SupportData({
    this.whatsappNo,
    this.contactNo,
  });

  List<String> whatsappNo;
  String contactNo;

  factory SupportData.fromJson(Map<String, dynamic> json) => SupportData(
    whatsappNo: List<String>.from(json["WhatsappNo"].map((x) => x)),
    contactNo: json["ContactNo"],
  );

  Map<String, dynamic> toJson() => {
    "WhatsappNo": List<dynamic>.from(whatsappNo.map((x) => x)),
    "ContactNo": contactNo,
  };
}
