import 'dart:io';
import 'package:agroon/data/datasource/remote/dio/dio_client.dart';
import 'package:agroon/data/datasource/remote/exception/api_error_handler.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:dio/dio.dart';


class ProfileRepo{

  final DioClient dioClient;
  ProfileRepo({this.dioClient});

  /// get profile api ///////////////////////

  Future<ApiResponse> getprofileApi() async {
    String userid = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userid,
      });
      Response response = await dioClient.post(
        AppConstants.APIGetUser,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  /// update profile api ///////////////////////

  Future<ApiResponse> updateprofileApi(String name, String shopname,String email,String mobile,String gstno,String state,String city,String address) async {
    String userid = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userid,
        'name': name,
        'shop_name': shopname,
        'email': email,
        'mobile': mobile,
        'gstno': gstno,
        'state': state,
        'city': city,
        'address': address,
      });
      Response response = await dioClient.post(
        AppConstants.APIupdateProfile,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}