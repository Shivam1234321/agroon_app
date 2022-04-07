
import 'dart:io';
import 'package:agroon/data/datasource/remote/dio/dio_client.dart';
import 'package:agroon/data/datasource/remote/exception/api_error_handler.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:dio/dio.dart';


class CartRepo{

  final DioClient dioClient;
  CartRepo({this.dioClient});


  ///  APIaddCart Api ///////////////////////

  Future<ApiResponse> addCartapi(String productId,String priceId, var quantity ) async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    // String productId = await SharedPrefManager.getPrefrenceString(AppConstants.PRODUCTID);
    // String productId = await SharedPrefManager.getPrefrenceString(AppConstants.PRODUCTID);

    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'productid': productId,
        'priceid': priceId,
        'quantity': quantity,
      });
      Response response = await dioClient.post(
        AppConstants.APIaddCart,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  ///  APIminusCart Api ///////////////////////

  Future<ApiResponse> minusCartapi(String productId,String priceId, var quantity ) async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'productid': productId,
        'priceid': priceId,
        'quantity': quantity,
      });
      Response response = await dioClient.post(
        AppConstants.APIminusCart,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  /// showcart api ///////////////////////
  Future<ApiResponse> showCartApi() async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);

    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
      });
      print("request: "+formData.fields.toString());
      Response response = await dioClient.post(
        AppConstants.APIshowCart,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///  APIdeleteCart  ///////////////////////

  Future<ApiResponse> deleteCartapi(String cartId) async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'cartid': cartId,
      });
      Response response = await dioClient.post(
        AppConstants.APIdeleteCart,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}