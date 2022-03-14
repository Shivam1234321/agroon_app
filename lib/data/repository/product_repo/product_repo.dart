import 'dart:io';
import 'package:agroon/data/datasource/remote/dio/dio_client.dart';
import 'package:agroon/data/datasource/remote/exception/api_error_handler.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:dio/dio.dart';


class ProductRepo{

  final DioClient dioClient;
  ProductRepo({this.dioClient});


  /// products api ///////////////////////
  Future<ApiResponse> productsApi() async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);

    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
      });
      Response response = await dioClient.post(
        AppConstants.Products,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// categoryProducts api ///////////////////////
  Future<ApiResponse> categoryProductsApi() async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    String categoryId = await SharedPrefManager.getPrefrenceString(AppConstants.CATEGORYID);

    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'categoryid': categoryId,
      });
      Response response = await dioClient.post(
        AppConstants.categoryProducts,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  /// singleProduct api ///////////////////////
  Future<ApiResponse> singleProductApi() async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    String productId = await SharedPrefManager.getPrefrenceString(AppConstants.PRODUCTID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'productid': productId,
      });
      Response response = await dioClient.post(
        AppConstants.singleProduct,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}