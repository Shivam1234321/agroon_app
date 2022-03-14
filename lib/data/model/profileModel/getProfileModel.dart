class GetProfileModel {
  int status;
  String msg;
  GetProfileData data;

  GetProfileModel({this.status, this.msg, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] =   new GetProfileData.fromJson(json['data']);
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

class GetProfileData {
  String userId;
  String name;
  String shopName;
  String email;
  String mobile;
  String gSTNo;
  String state;
  String city;
  String address;
  String image;

  GetProfileData(
      {this.userId,
        this.name,
        this.shopName,
        this.email,
        this.mobile,
        this.gSTNo,
        this.state,
        this.city,
        this.address,
        this.image});

  GetProfileData.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    name = json['Name'];
    shopName = json['ShopName'];
    email = json['Email'];
    mobile = json['Mobile'];
    gSTNo = json['GSTNo'];
    state = json['State'];
    city = json['city'];
    address = json['address'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['Name'] = this.name;
    data['ShopName'] = this.shopName;
    data['Email'] = this.email;
    data['Mobile'] = this.mobile;
    data['GSTNo'] = this.gSTNo;
    data['State'] = this.state;
    data['city'] = this.city;
    data['address'] = this.address;
    data['Image'] = this.image;
    return data;
  }
}
