// To parse this JSON data, do
//
//     final webViewModel = webViewModelFromJson(jsonString);

import 'dart:convert';

List<WebViewModel> webViewModelFromJson(String str) => List<WebViewModel>.from(json.decode(str).map((x) => WebViewModel.fromJson(x)));

String webViewModelToJson(List<WebViewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WebViewModel {
  WebViewModel({
    this.status,
    this.msg,
    this.data,
  });

  int status;
  String msg;
  WebViewData data;

  factory WebViewModel.fromJson(Map<String, dynamic> json) => WebViewModel(
    status: json["status"],
    msg: json["msg"],
    data: WebViewData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "data": data.toJson(),
  };
}

class WebViewData {
  WebViewData({
    this.contactus,
    this.privacyPolicy,
    this.termCondition,
  });

  String contactus;
  String privacyPolicy;
  String termCondition;

  factory WebViewData.fromJson(Map<String, dynamic> json) => WebViewData(
    contactus: json["contactus"],
    privacyPolicy: json["privacy_policy"],
    termCondition: json["term_condition"],
  );

  Map<String, dynamic> toJson() => {
    "contactus": contactus,
    "privacy_policy": privacyPolicy,
    "term_condition": termCondition,
  };
}
