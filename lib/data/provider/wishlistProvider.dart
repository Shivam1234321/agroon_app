import 'dart:convert';

import 'package:agroon/data/model/CartModel/cart_model.dart';
import 'package:agroon/data/model/WishlistModel/showWishlist_model.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/data/model/response/base/error_response.dart';
import 'package:agroon/data/model/response/response_model.dart';
import 'package:agroon/data/repository/cart_repo/cart_repo.dart';
import 'package:agroon/data/repository/wishlist_repo/wishlist_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WishlistProvider extends ChangeNotifier{

  final WishlistRepo wishlistRepo;

  WishlistProvider({this.wishlistRepo});


  /// addWishlistAPI/////////////////////////

  Future<ResponseModel> addWishlistapi(String productId, String priceId) async {
    List list;
    ApiResponse apiResponse = await wishlistRepo.addWishlistapi(productId, priceId);
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


  /// APIshowWishlist //////////////////////////////////////

  List<ShowWishlistData> showWishlistData;

  List<ShowWishlistData> get showWishlistDataList => showWishlistData;

  Future<ResponseModel> getWishlistData() async {
    List list;
    showWishlistData = null;
    ResponseModel responseModel;
    if(showWishlistData == null) {
      ApiResponse apiResponse = await wishlistRepo.showWishlistApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = jsonDecode(apiResponse.response.data);
        if(list[0]['status'] == 1){
          list= list[0]['data'];
          showWishlistData = list.map((data) => new ShowWishlistData.fromJson(data)).toList();
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


  /// deleteWishlistapi /////////////////////////

  Future<ResponseModel> deleteWishlistapi(String wishlistId) async {
    List list;
    ApiResponse apiResponse = await wishlistRepo.deleteWishlistapi(wishlistId);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      if(list[0]['status'] == 1){
        Get.snackbar("Item Deleted",
            "product is deleted from this list");
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