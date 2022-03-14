class CategoryModel {
  int status;
  String msg;
  List<CategoryData> data;

  CategoryModel({this.status, this.msg, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data.add(new CategoryData.fromJson(v));
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

class CategoryData {
  String categoryId;
  String category;
  String image;

  CategoryData({this.categoryId, this.category, this.image});

  CategoryData.fromJson(Map<String, dynamic> json) {
    categoryId = json['CategoryId'];
    category = json['Category'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CategoryId'] = this.categoryId;
    data['Category'] = this.category;
    data['Image'] = this.image;
    return data;
  }
}
