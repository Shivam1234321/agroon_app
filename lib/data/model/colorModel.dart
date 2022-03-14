class ColorModel {
  int status;
  String msg;
  Data data;

  ColorModel({this.status, this.msg, this.data});

  ColorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String colorId;
  String primaryColor;
  String secondaryColor;
  String drawerColor;
  String version;
  String versionCode;

  Data(
      {this.colorId,
        this.primaryColor,
        this.secondaryColor,
        this.drawerColor,
        this.version,
        this.versionCode});

  Data.fromJson(Map<String, dynamic> json) {
    colorId = json['ColorId'];
    primaryColor = json['PrimaryColor'];
    secondaryColor = json['SecondaryColor'];
    drawerColor = json['DrawerColor'];
    version = json['Version'];
    versionCode = json['VersionCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ColorId'] = this.colorId;
    data['PrimaryColor'] = this.primaryColor;
    data['SecondaryColor'] = this.secondaryColor;
    data['DrawerColor'] = this.drawerColor;
    data['Version'] = this.version;
    data['VersionCode'] = this.versionCode;
    return data;
  }
}
