import 'dart:convert';
import 'dart:io';
import 'package:agroon/data/model/CategoryModel/categoryModel.dart';
import 'package:agroon/data/model/profileModel/getProfileModel.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/data/model/response/base/error_response.dart';
import 'package:agroon/data/model/response/response_model.dart';
import 'package:agroon/data/model/walkthrowModel.dart';
import 'package:agroon/data/repository/category_repo/category_repo.dart';
import 'package:agroon/data/repository/profile_repo/profile_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProfileProvider with ChangeNotifier{

  final ProfileRepo profileRepo;

  ProfileProvider({this.profileRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// getProfile //////////////////////////////////////
  List<GetProfileModel> getProfileModel;

  List<GetProfileModel> get getProfileModelList => getProfileModel;

  Future<ResponseModel> getProfileList() async {
    List list;
    ApiResponse apiResponse = await profileRepo.getprofileApi();

    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      // list= list[0]['data'];
      // Fluttertoast.showToast(msg: "Successful",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white);
      getProfileModel = list.map((data) => new GetProfileModel.fromJson(data)).toList();
      if(getProfileModel[0].status == 1){
        print("msg"+getProfileModel[0].msg.toString());

      }else{
        Get.rawSnackbar(message: getProfileModel[0].msg.toString());
      }
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
        Fluttertoast.showToast(msg: "Something Wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors[0].message;
        Fluttertoast.showToast(msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
      print(errorMessage);
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;

  }

  /// updateprofileApi/////////////////////////

  Future<ResponseModel> updateprofileApi(String name,String shopname, String email,String mobile,String gstno,String state,String city,String address) async {
    List list;
    ApiResponse apiResponse = await profileRepo.updateprofileApi(name, shopname, email, mobile, gstno, state, city,address);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      if(list[0]['status'] == 1){
        Get.snackbar("Profile Updated",
            "Your profile has been updated successfully");
        Get.back(closeOverlays: true);

        // Fluttertoast.showToast(msg: list[0]['msg'].toString(),
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
      }else{
        Get.rawSnackbar(message: list[0]['msg'].toString());
      }
      responseModel = ResponseModel(true, 'successful');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
        Fluttertoast.showToast(msg: "Credentials Wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors[0].message;
        Fluttertoast.showToast(msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
      }
      print(errorMessage);
      // _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    // _isLoading = false;
    notifyListeners();
    return responseModel;
  }

}