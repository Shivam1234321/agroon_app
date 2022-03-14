class TimeLineModel {
  String status;
  String msg;
  TimeLineData data;

  TimeLineModel({this.status, this.msg, this.data});

  TimeLineModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    msg = json['Msg'];
    data = json['data'] != null ? new TimeLineData.fromJson(json['data']) : null;
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

class TimeLineData {
  List<Header> header;
  List<Row> row;

  TimeLineData({this.header, this.row});

  TimeLineData.fromJson(Map<String, dynamic> json) {
    if (json['Header'] != null) {
      header = new List<Header>();
      json['Header'].forEach((v) {
        header.add(new Header.fromJson(v));
      });
    }
    if (json['Row'] != null) {
      row = new List<Row>();
      json['Row'].forEach((v) {
        row.add(new Row.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['Header'] = this.header.map((v) => v.toJson()).toList();
    }
    if (this.row != null) {
      data['Row'] = this.row.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Header {
  int index;
  int id;
  String columnName;
  String code;
  String status;

  Header({this.index, this.id, this.columnName, this.code, this.status});

  Header.fromJson(Map<String, dynamic> json) {
    index = json['Index'];
    id = json['Id'];
    columnName = json['ColumnName'];
    code = json['Code'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Index'] = this.index;
    data['Id'] = this.id;
    data['ColumnName'] = this.columnName;
    data['Code'] = this.code;
    data['Status'] = this.status;
    return data;
  }
}

class Row {
  String timeline;
  List<Data> data;

  Row({this.timeline, this.data});

  Row.fromJson(Map<String, dynamic> json) {
    timeline = json['Timeline'];
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Timeline'] = this.timeline;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String projectName;
  List<ProjectData> projectData;

  Data({this.projectName, this.projectData});

  Data.fromJson(Map<String, dynamic> json) {
    projectName = json['ProjectName'];
    if (json['ProjectData'] != null) {
      projectData = new List<ProjectData>();
      json['ProjectData'].forEach((v) {
        projectData.add(new ProjectData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjectName'] = this.projectName;
    if (this.projectData != null) {
      data['ProjectData'] = this.projectData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectData {
  String eventOne;
  String contractID1;
  String contractorName;

  ProjectData({this.eventOne, this.contractID1, this.contractorName});

  ProjectData.fromJson(Map<String, dynamic> json) {
    eventOne = json['EventOne'];
    contractID1 = json['ContractID1'];
    contractorName = json['ContractorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventOne'] = this.eventOne;
    data['ContractID1'] = this.contractID1;
    data['ContractorName'] = this.contractorName;
    return data;
  }
}
