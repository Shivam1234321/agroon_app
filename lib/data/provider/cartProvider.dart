import 'dart:convert';

import 'package:agroon/data/model/CartModel/cart_model.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/data/model/response/base/error_response.dart';
import 'package:agroon/data/model/response/response_model.dart';
import 'package:agroon/data/repository/cart_repo/cart_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CartProvider extends ChangeNotifier{

  final CartRepo cartRepo;

  CartProvider({this.cartRepo});


  /// addCartapi/////////////////////////

  Future<ResponseModel> addCartapi(String productId, String priceId, var quantity) async {
    List list;
    ApiResponse apiResponse = await cartRepo.addCartapi(productId, priceId, quantity);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      if(list[0]['status'] == 1){
        Fluttertoast.showToast(msg: list[0]['msg'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
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


  /// minusCartapi/////////////////////////

  Future<ResponseModel> minusCartapi(String productId, String priceId, var quantity) async {
    List list;
    ApiResponse apiResponse = await cartRepo.minusCartapi(productId, priceId, quantity);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      if(list[0]['status'] == 1){
        Fluttertoast.showToast(msg: list[0]['msg'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
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


  /// showCartApi //////////////////////////////////////

  List<ShowCartModel> showCartData;

  List<ShowCartModel> get showCartDataList => showCartData;

  Future<ResponseModel> getproductData() async {
    List list;
    showCartData = null;
    ResponseModel responseModel;
    if(showCartData == null) {
      ApiResponse apiResponse = await cartRepo.showCartApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = jsonDecode(apiResponse.response.data);
        if(list[0]['status'] == 1){
          // list= list[0]['data'];
          showCartData = list.map((data) => new ShowCartModel.fromJson(data)).toList();
          // Fluttertoast.showToast(msg: list[0]['msg'].toString(),
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
        }else{
          Fluttertoast.showToast(msg: list[0]['msg'].toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
          // Get.rawSnackbar(message: list[0]['msg'].toString());
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


  /// deleteCartapi/////////////////////////

  Future<ResponseModel> deleteCartapi(String cartId) async {
    List list;
    ApiResponse apiResponse = await cartRepo.deleteCartapi(cartId);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      if(list[0]['status'] == 1){
        Get.snackbar("Item Deleted",
            "Product is deleted from this list");
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


}