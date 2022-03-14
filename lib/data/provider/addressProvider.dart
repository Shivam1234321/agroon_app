import 'dart:convert';

import 'package:agroon/data/model/AddressModel/getAddress_model.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/data/model/response/base/error_response.dart';
import 'package:agroon/data/model/response/response_model.dart';
import 'package:agroon/data/repository/address_repo/address_repo.dart';
import 'package:agroon/data/repository/cart_repo/cart_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AddressProvider extends ChangeNotifier{

  final AddressRepo addressRepo;

  AddressProvider({this.addressRepo});


  /// addaddressapi/////////////////////////

  Future<ResponseModel> addAddressapi(String name,String mobile, String address,String city,String land_mark,String pincode,) async {
    List list;
    ApiResponse apiResponse = await addressRepo.addAddressapi(name, mobile, address,city,land_mark,pincode);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      if(list[0]['status'] == 1){

        Get.snackbar("Address Saved",
            "Your new address is saved here!");
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



  /// APIshowAddress //////////////////////////////////////

  List<GetAddressData> getAddressData;

  List<GetAddressData> get getAddressDataList => getAddressData;

  Future<ResponseModel> getshowAddressData() async {
    List list;
    getAddressData = null;
    ResponseModel responseModel;
    if(getAddressData == null) {
      ApiResponse apiResponse = await addressRepo.showAddressApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = jsonDecode(apiResponse.response.data);
        if(list[0]['status'] == 1){
          list= list[0]['data'];
          getAddressData = list.map((data) => new GetAddressData.fromJson(data)).toList();
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


  /// APIdeleteAddress/////////////////////////

  Future<ResponseModel> deleteAddressapi(String addressId) async {
    List list;
    ApiResponse apiResponse = await addressRepo.deleteAddressapi(addressId);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      if(list[0]['status'] == 1){
        Get.snackbar(
            "Address Deleted",
            "address is delete from this list");
        // Get.back(closeOverlays: true);

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


  /// updateaddaddressapi/////////////////////////

  Future<ResponseModel> updateaddAddressapi(String name,String mobile, String address,String city,String land_mark,String pincode,String addressId) async {
    List list;
    ApiResponse apiResponse = await addressRepo.updateAddressapi(name, mobile, address,city,land_mark,pincode,addressId);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      if(list[0]['status'] == 1){
        Get.snackbar("Address Saved",
            "Your new address is saved here!");
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