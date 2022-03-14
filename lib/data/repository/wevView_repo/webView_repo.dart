import 'dart:io';
import 'package:agroon/data/datasource/remote/dio/dio_client.dart';
import 'package:agroon/data/datasource/remote/exception/api_error_handler.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:dio/dio.dart';


class WebViewRepo {

  final DioClient dioClient;

  WebViewRepo({this.dioClient});

  /// APIofferNotification ///////////////////////

  Future<ApiResponse> webViewApi() async {
    try {
      Response response = await dioClient.get(
          AppConstants.webView
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// getPartialDeductionAmount ///////////////////////

  Future<ApiResponse> getPartialDeductionAmountApi() async {
    try {
      Response response = await dioClient.get(
          AppConstants.getPartialDeductionAmount
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  ///  APIcheckCoupon Api ///////////////////////

  Future<ApiResponse> checkCouponapi(String couponCode) async {
    String userID = await SharedPrefManager.getPrefrenceString(
        AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'coupon_code': couponCode,
      });
      Response response = await dioClient.post(
        AppConstants.APIcheckCoupon,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: " + formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///  orderapi ///////////////////////

  Future<ApiResponse> orderapi(String couponCode,String partialpaymentamount,String paymentType,String totalAmount,String coupondiscountAmount) async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    String addressId = await SharedPrefManager.getPrefrenceString(AppConstants.ADDRESSID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'coupon_code': couponCode,
        'partial_payment_amount': partialpaymentamount,
        'payment_type': paymentType,
        'total_amount': totalAmount,
        'coupon_discount_amount': coupondiscountAmount,
        'addressid': addressId,
      });
      Response response = await dioClient.post(
        AppConstants.APIorder,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: " + formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  ///  showOrderAPI ///////////////////////

  Future<ApiResponse> showOrderapi() async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
     try {
      FormData formData = FormData.fromMap({
        'userid': userID,
      });
      Response response = await dioClient.post(
        AppConstants.APIshowOrder,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: " + formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///  APIorderDetails ///////////////////////

  Future<ApiResponse> orderDetailsapi() async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    String orderID = await SharedPrefManager.getPrefrenceString(AppConstants.ORDERID);
    String orderkey = await SharedPrefManager.getPrefrenceString(AppConstants.ORDERKEY);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'orderid': orderID,
        'orderkey': orderkey,
      });
      Response response = await dioClient.post(
        AppConstants.APIorderDetails,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: " + formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  /// supportNumbersApi ///////////////////////

  Future<ApiResponse> supportNumbersApi() async {
    try {
      Response response = await dioClient.get(
          AppConstants.APIsupportNumbers
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}