import 'dart:io';
import 'package:agroon/data/datasource/remote/dio/dio_client.dart';
import 'package:agroon/data/datasource/remote/exception/api_error_handler.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:dio/dio.dart';


class AuthRepo{

  final DioClient dioClient;
  AuthRepo({this.dioClient});

  /// SignIn api ///////////////////////

  Future<ApiResponse> signinApi(String mobile,String password) async {
    await SharedPrefManager.savePrefString(AppConstants.MOBILE, mobile);
    try {
      FormData formData = FormData.fromMap({
        'mobile': mobile,
        'password': password,
      });
      // final data = {
      //   'name': userName,
      //   "client_secret":password,
      //   "grant_type":userType
      // };
      Response response = await dioClient.post(
        AppConstants.APILogin,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  /// APIRegister ///////////////////////

  Future<ApiResponse> registerUserApi(String name,String shopname,String email,String mobile,String gstno,String state,String city,String address,String password,String confirmPassword) async {
   await SharedPrefManager.savePrefString(AppConstants.MOBILE, mobile);
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'shop_name': shopname,
        'email': email,
        'mobile': mobile,
        'gstno': gstno,
        'state': state,
        'city': city,
        'address': address,
        'password': password,
        'confirm_password': confirmPassword,
      });
      // final data = {
      //   'name': userName,
      //   "client_secret":password,
      //   "grant_type":userType
      // };
      Response response = await dioClient.post(
          AppConstants.APIRegister,
          data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// APIOTPVerify ///////////////////////

  Future<ApiResponse> otpVerifyApi(String otp) async {
    String mobile = await SharedPrefManager.getPrefrenceString(AppConstants.MOBILE);

    try {
      FormData formData = FormData.fromMap({
        'mobile': mobile,
        'otp': otp,
      });
      Response response = await dioClient.post(
        AppConstants.APIOTPVerify,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




///  resendOTPApi Api ///////////////////////

  Future<ApiResponse> resendOtpApi() async {
    String mobile = await SharedPrefManager.getPrefrenceString(AppConstants.MOBILE);

    try {
      FormData formData = FormData.fromMap({
        'mobile': mobile,
      });
      Response response = await dioClient.post(
        AppConstants.APIResendOTP,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  ///  getOTPApi Api ///////////////////////

  Future<ApiResponse> getOtpApi(String mobile) async {
    // String mobile = await SharedPrefManager.getPrefrenceString(AppConstants.MOBILE);

    try {
      FormData formData = FormData.fromMap({
        'mobile': mobile,
      });
      Response response = await dioClient.post(
        AppConstants.APIResendOTP,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  ///  forgotPasswordApi Api ///////////////////////

  Future<ApiResponse> forgotPasswordApi(String mobile,String newPassword, String confirmPassword) async {
    // String mobile = await SharedPrefManager.getPrefrenceString(AppConstants.MOBILE);

    try {
      FormData formData = FormData.fromMap({
        'mobile': mobile,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      });
      Response response = await dioClient.post(
        AppConstants.APIforgetPassword,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  ///  ChangePassword Api ///////////////////////


  Future<ApiResponse> changePasswordApi(String oldPassword,String newPassword, String confirmPassword) async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);

    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'old_password': oldPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      });
      Response response = await dioClient.post(
        AppConstants.APIchangePassword,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///  checkUserApi ///////////////////////


  Future<ApiResponse> checkUserApi() async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);

    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
      });
      Response response = await dioClient.post(
        AppConstants.APIcheckUser,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}