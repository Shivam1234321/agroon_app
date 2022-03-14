// To parse this JSON data, do
//
//     final getPartialDeductionAmountModel = getPartialDeductionAmountModelFromJson(jsonString);

import 'dart:convert';

List<GetPartialDeductionAmountModel> getPartialDeductionAmountModelFromJson(String str) => List<GetPartialDeductionAmountModel>.from(json.decode(str).map((x) => GetPartialDeductionAmountModel.fromJson(x)));

String getPartialDeductionAmountModelToJson(List<GetPartialDeductionAmountModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPartialDeductionAmountModel {
  GetPartialDeductionAmountModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  GetPartialDeductionAmountData data;

  factory GetPartialDeductionAmountModel.fromJson(Map<String, dynamic> json) => GetPartialDeductionAmountModel(
    status: json["status"],
    msg: json["msg"],
    data: GetPartialDeductionAmountData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class GetPartialDeductionAmountData {
  GetPartialDeductionAmountData({
    this.amount,
  });

  String amount;

  factory GetPartialDeductionAmountData.fromJson(Map<String, dynamic> json) => GetPartialDeductionAmountData(
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
  };
}
