class UserDetailsModel {
  String status;
  String msg;
  UserDetailsData data;

  UserDetailsModel({this.status, this.msg, this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    msg = json['Msg'];
    data = json['data'] != null ? new UserDetailsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserDetailsData {
  int id;
  String userName;
  String firstName;
  String lastName;
  String contact;
  String email;
  String roles;
  Null profilePic;
  String reports;
  bool forcePasswordReset;
  Null allReports;

  UserDetailsData(
      {this.id,
        this.userName,
        this.firstName,
        this.lastName,
        this.contact,
        this.email,
        this.roles,
        this.profilePic,
        this.reports,
        this.forcePasswordReset,
        this.allReports});

  UserDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userName = json['UserName'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    contact = json['Contact'];
    email = json['Email'];
    roles = json['Roles'];
    profilePic = json['ProfilePic'];
    reports = json['Reports'];
    forcePasswordReset = json['ForcePasswordReset'];
    allReports = json['AllReports'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserName'] = this.userName;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Contact'] = this.contact;
    data['Email'] = this.email;
    data['Roles'] = this.roles;
    data['ProfilePic'] = this.profilePic;
    data['Reports'] = this.reports;
    data['ForcePasswordReset'] = this.forcePasswordReset;
    data['AllReports'] = this.allReports;
    return data;
  }
}
