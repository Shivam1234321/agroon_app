class StatesModel {
  int status;
  String msg;
  List<String> date;

  StatesModel({this.status, this.msg, this.date});

  StatesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    date = json['date'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['date'] = this.date;
    return data;
  }
}
