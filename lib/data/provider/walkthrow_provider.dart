import 'dart:convert';
import 'dart:io';

import 'package:agroon/data/model/NotificationModel/offerNotificationModel.dart';
import 'package:agroon/data/model/NotificationModel/orderNotificationModel.dart';
import 'package:agroon/data/model/colorModel.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/data/model/response/base/error_response.dart';
import 'package:agroon/data/model/response/response_model.dart';
import 'package:agroon/data/model/splashModel.dart';
import 'package:agroon/data/model/walkthrowModel.dart';
import 'package:agroon/data/repository/auth_repo/auth_repo.dart';
import 'package:agroon/data/repository/walkthrow_repo/walkthrow_repo.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WalkthrowProvider with ChangeNotifier{

  final WalkthrowRepo walkthrowRepo;

  WalkthrowProvider({this.walkthrowRepo});

// for registration section

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  /// colorsApi Api/////////////////////////



  List<ColorModel> colorModel;

  List<ColorModel> get colorModelList => colorModel;

  Future<ResponseModel> getColorsData() async {
    List list;
    if(colorModel == null) {
      ApiResponse apiResponse = await walkthrowRepo.colorsApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = jsonDecode(apiResponse.response.data);
        // list= list[0]['data'];
        colorModel = list.map((data) => new ColorModel.fromJson(data)).toList();
        await SharedPrefManager.savePrefString(AppConstants.DRAWERCOLOR,colorModel[0].data.drawerColor.toString());
        await SharedPrefManager.savePrefString(AppConstants.PRIMARYCOLOR,colorModel[0].data.primaryColor.toString());
        await SharedPrefManager.savePrefString(AppConstants.SECONDARYCOLOR,colorModel[0].data.secondaryColor.toString());

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

  /// splashApi Api/////////////////////////



  List<SplashData> splashModel;
  List list;
  List<SplashData> get splashModelList => splashModel;

  Future<ResponseModel> getsplashData() async {
    if(splashModel == null) {
      ApiResponse apiResponse = await walkthrowRepo.splashApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = jsonDecode(apiResponse.response.data);
        list= list[0]['data'];
        splashModel = list.map((data) => new SplashData.fromJson(data)).toList();
        await SharedPrefManager.savePrefString(AppConstants.splashlogo,splashModel[0].image.toString());
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

  List<WalkthrowData> walkthrowData;

  List<WalkthrowData> get walkthrowDataList => walkthrowData;

  Future<ResponseModel> getwalkthrowData() async {
    List list;
    if(walkthrowData == null) {
      ApiResponse apiResponse = await walkthrowRepo.walkthrowApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = jsonDecode(apiResponse.response.data);
        list= list[0]['data'];
        walkthrowData = list.map((data) => new WalkthrowData.fromJson(data)).toList();
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


  /// offerNotificationApi //////////////////////////////////////

  List<OfferNotificationData> offerNotificationData;

  List<OfferNotificationData> get offerNotificationDataList => offerNotificationData;

  Future<ResponseModel> offerNotificationApi() async {
    List list;
    offerNotificationData = null;
    ResponseModel responseModel;
    if(offerNotificationData == null) {
      ApiResponse apiResponse = await walkthrowRepo.offerNotificationApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = apiResponse.response.data[0]['data'];
        offerNotificationData = list.map((data) => new OfferNotificationData.fromJson(data)).toList();

        // list = apiResponse.response.data[0]['data'];
        //  list.forEach((offerProduct) => offerNotificationData.add(OfferNotificationData.fromJson(offerProduct)));

       // if(list[0]['status'] == 1){
        //   list.forEach((offerProduct) => offerNotificationData.add(OfferNotificationData.fromJson(offerProduct)));
        //   // Fluttertoast.showToast(msg: list[0]['msg'].toString(),
        //   //     toastLength: Toast.LENGTH_SHORT,
        //   //     gravity: ToastGravity.CENTER,
        //   //     backgroundColor: Colors.black,
        //   //     textColor: Colors.white);
        // }else{
        //   Get.rawSnackbar(message: apiResponse.response.data['msg'].toString());
        // }
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


  /// orderNotificationApi //////////////////////////////////////

  List<OrderNotificationData> orderNotificationData;

  List<OrderNotificationData> get orderNotificationDataList => orderNotificationData;

  Future<ResponseModel> orderNotificationApi() async {
    List list;
    orderNotificationData = null;
    ResponseModel responseModel;
    if(orderNotificationData == null) {
      ApiResponse apiResponse = await walkthrowRepo.orderNotificationApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = apiResponse.response.data[0]['data'];
        orderNotificationData = list.map((data) => new OrderNotificationData.fromJson(data)).toList();

        // list = apiResponse.response.data[0]['data'];
        //  list.forEach((offerProduct) => offerNotificationData.add(OfferNotificationData.fromJson(offerProduct)));

        // if(list[0]['status'] == 1){
        //   list.forEach((offerProduct) => offerNotificationData.add(OfferNotificationData.fromJson(offerProduct)));
        //   // Fluttertoast.showToast(msg: list[0]['msg'].toString(),
        //   //     toastLength: Toast.LENGTH_SHORT,
        //   //     gravity: ToastGravity.CENTER,
        //   //     backgroundColor: Colors.black,
        //   //     textColor: Colors.white);
        // }else{
        //   Get.rawSnackbar(message: apiResponse.response.data['msg'].toString());
        // }
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

}