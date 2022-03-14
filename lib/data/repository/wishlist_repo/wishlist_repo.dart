
import 'dart:io';
import 'package:agroon/data/datasource/remote/dio/dio_client.dart';
import 'package:agroon/data/datasource/remote/exception/api_error_handler.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:dio/dio.dart';


class WishlistRepo{

  final DioClient dioClient;
  WishlistRepo({this.dioClient});


  ///  APIaddWishlist Api ///////////////////////

  Future<ApiResponse> addWishlistapi(String productId,String priceId) async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'productid': productId,
        'priceid': priceId,
      });
      Response response = await dioClient.post(
        AppConstants.APIaddWishlist,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  /// APIshowWishlist  ///////////////////////
  Future<ApiResponse> showWishlistApi() async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);

    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
      });
      Response response = await dioClient.post(
        AppConstants.APIshowWishlist,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///  APIdeleteWishlist  ///////////////////////

  Future<ApiResponse> deleteWishlistapi(String wishlistId) async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'wishlistid': wishlistId,
      });
      Response response = await dioClient.post(
        AppConstants.APIdeleteWishlist,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}