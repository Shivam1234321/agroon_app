import 'dart:io';
import 'package:agroon/data/datasource/remote/dio/dio_client.dart';
import 'package:agroon/data/datasource/remote/exception/api_error_handler.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:dio/dio.dart';


class WalkthrowRepo{

  final DioClient dioClient;
  WalkthrowRepo({this.dioClient});

  /// colorsApi ///////////////////////

  Future<ApiResponse> colorsApi() async {
    try {
      Response response = await dioClient.get(
          AppConstants.ColorApi
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// splashApi ///////////////////////

  Future<ApiResponse> splashApi() async {
    try {
      Response response = await dioClient.get(
        AppConstants.splashApi
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  /// walkthrowApi ///////////////////////

  Future<ApiResponse> walkthrowApi() async {
    try {
      Response response = await dioClient.get(
          AppConstants.WalkthrowApi
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  /// CategoryApi ///////////////////////

  Future<ApiResponse> categoryApi() async {
    try {
      Response response = await dioClient.get(
          AppConstants.CategoryApi
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// APIofferNotification ///////////////////////

  Future<ApiResponse> offerNotificationApi() async {
    try {
      Response response = await dioClient.get(
          AppConstants.APIofferNotification
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  /// APIorderNotification ///////////////////////

  Future<ApiResponse> orderNotificationApi() async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
      });
      Response response = await dioClient.post(
        AppConstants.APIorderNotification,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}