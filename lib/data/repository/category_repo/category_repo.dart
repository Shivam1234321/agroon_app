import 'dart:io';
import 'package:agroon/data/datasource/remote/dio/dio_client.dart';
import 'package:agroon/data/datasource/remote/exception/api_error_handler.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:dio/dio.dart';


class CategoryRepo{

  final DioClient dioClient;
  CategoryRepo({this.dioClient});


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

  /// CouponApi ///////////////////////

  Future<ApiResponse> couponApi() async {
    try {
      Response response = await dioClient.get(
          AppConstants.Coupon
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}