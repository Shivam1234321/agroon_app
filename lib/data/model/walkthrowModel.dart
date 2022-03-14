class WalkthrowModel {
  int status;
  String msg;
  List<WalkthrowData> data;

  WalkthrowModel({this.status, this.msg, this.data});

  WalkthrowModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <WalkthrowData>[];
      json['data'].forEach((v) {
        data.add(new WalkthrowData.fromJson(v));
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

class WalkthrowData {
  String walkthrowId;
  String name;
  String description;
  String image;

  WalkthrowData({this.walkthrowId, this.name, this.description, this.image});

  WalkthrowData.fromJson(Map<String, dynamic> json) {
    walkthrowId = json['WalkthrowId'];
    name = json['Name'];
    description = json['Description'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WalkthrowId'] = this.walkthrowId;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Image'] = this.image;
    return data;
  }
}
