import 'dart:convert';
import 'dart:io';
import 'package:agroon/data/model/CategoryModel/categoryModel.dart';
import 'package:agroon/data/model/ProductsModel/category_products_model.dart';
import 'package:agroon/data/model/ProductsModel/products_model.dart';
import 'package:agroon/data/model/ProductsModel/singleProductModel.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/data/model/response/base/error_response.dart';
import 'package:agroon/data/model/response/response_model.dart';
import 'package:agroon/data/model/walkthrowModel.dart';
import 'package:agroon/data/repository/category_repo/category_repo.dart';
import 'package:agroon/data/repository/product_repo/product_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductProvider with ChangeNotifier{

  final ProductRepo productRepo;

  ProductProvider({this.productRepo});


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// product //////////////////////////////////////

  List<ProductsData> productData;

  List<ProductsData> get productDataList => productData;

  Future<ResponseModel> getproductData() async {
    List list;
    productData = null;
    ResponseModel responseModel;
    if(productData == null) {
      ApiResponse apiResponse = await productRepo.productsApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = jsonDecode(apiResponse.response.data);
        if(list[0]['status'] == 1){
          list= list[0]['data'];
          productData = list.map((data) => new ProductsData.fromJson(data)).toList();
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
      _isLoading = false;
      notifyListeners();
      return responseModel;
  }

}

  /// product //////////////////////////////////////

  List<CategoryProductsData> categoryProductsData;

  List<CategoryProductsData> get categoryProductsDataList => categoryProductsData;

  Future<ResponseModel> getcategoryProductsApi() async {
    List list;
    categoryProductsData = null;
    ResponseModel responseModel;
    if(categoryProductsData == null) {
      ApiResponse apiResponse = await productRepo.categoryProductsApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = jsonDecode(apiResponse.response.data);
        if(list[0]['status'] == 1){
          list= list[0]['data'];
          categoryProductsData = list.map((data) => new CategoryProductsData.fromJson(data)).toList();
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
      _isLoading = false;
      notifyListeners();
      return responseModel;
    }

  }

/// product //////////////////////////////////////

  List<SingleProductData> singleProductData;

  List<SingleProductData> get singleProductDataList => singleProductData;

  Future<ResponseModel> getsingleProductData() async {
  List list;
  singleProductData = null;
  ResponseModel responseModel;
  if(singleProductData == null) {
    print('klklklklklk');
    ApiResponse apiResponse = await productRepo.singleProductApi();
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      if(list[0]['status'] == 1){
        list= list[0]['data'];
        singleProductData = list.map((data) => new SingleProductData.fromJson(data)).toList();
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
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

 }




}



