class OfferNotificationModel {
  int status;
  String msg;
  List<OfferNotificationData> data;

  OfferNotificationModel({this.status, this.msg, this.data});

  OfferNotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <OfferNotificationData>[];
      json['data'].forEach((v) {
        data.add(new OfferNotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferNotificationData {
  String notificationId;
  String title;
  String description;
  String image;
  String date;

  OfferNotificationData(
      {this.notificationId,
        this.title,
        this.description,
        this.image,
        this.date});

  OfferNotificationData.fromJson(Map<String, dynamic> json) {
    notificationId = json['NotificationId'];
    title = json['Title'];
    description = json['Description'];
    image = json['Image'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationId'] = this.notificationId;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['Date'] = this.date;
    return data;
  }
}
