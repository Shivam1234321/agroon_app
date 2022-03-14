class SplashModel {
  int status;
  String msg;
  List<SplashData> data;

  SplashModel({this.status, this.msg, this.data});

  SplashModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <SplashData>[];
      json['data'].forEach((v) {
        data.add(new SplashData.fromJson(v));
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

class SplashData {
  String sliderId;
  String category;
  String type;
  String image;

  SplashData({this.sliderId, this.category, this.type, this.image});

  SplashData.fromJson(Map<String, dynamic> json) {
    sliderId = json['SliderId'];
    category = json['Category'];
    type = json['Type'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SliderId'] = this.sliderId;
    data['Category'] = this.category;
    data['Type'] = this.type;
    data['Image'] = this.image;
    return data;
  }
}
