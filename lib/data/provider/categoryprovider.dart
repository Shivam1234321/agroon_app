import 'dart:convert';
import 'dart:io';
import 'package:agroon/data/model/CategoryModel/categoryModel.dart';
import 'package:agroon/data/model/offers_model.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/data/model/response/response_model.dart';
import 'package:agroon/data/model/walkthrowModel.dart';
import 'package:agroon/data/repository/category_repo/category_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryProvider with ChangeNotifier{

  final CategoryRepo categoryRepo;

  CategoryProvider({this.categoryRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// walkthrow //////////////////////////////////////

  List<CategoryData> categoryData;

  List<CategoryData> get categoryDataList => categoryData;

  Future<ResponseModel> getcategoryData() async {
    List list;
    categoryData = null;
    if(categoryData == null) {
      ApiResponse apiResponse = await categoryRepo.categoryApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = jsonDecode(apiResponse.response.data);
        list= list[0]['data'];
        categoryData = list.map((data) => new CategoryData.fromJson(data)).toList();
        // Fluttertoast.showToast(msg: "Successful",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
      } else {
        // ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }


  /// walkthrow //////////////////////////////////////

  List<OffersData> offersData;

  List<OffersData> get offersDataList => offersData;

  Future<ResponseModel> getoffersData() async {
    List list;
    offersData = null;
    if(offersData == null) {
      ApiResponse apiResponse = await categoryRepo.couponApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = jsonDecode(apiResponse.response.data);
        list= list[0]['data'];
        offersData = list.map((data) => new OffersData.fromJson(data)).toList();
        // Fluttertoast.showToast(msg: "Successful",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
      } else {
        // ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

}