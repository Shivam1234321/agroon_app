import 'package:agroon/data/datasource/remote/dio/dio_client.dart';
import 'package:agroon/data/datasource/remote/exception/api_error_handler.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:dio/dio.dart';

class AddressRepo{

  final DioClient dioClient;

  AddressRepo({this.dioClient});

  ///  APIaddAddress  ///////////////////////

  Future<ApiResponse> addAddressapi(String name,String mobile, String address,String city,String state, String land_mark,String pincode,) async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'name': name,
        'mobile': mobile,
        'address': address,
        'city': city,
        'state': state,
        'land_mark': land_mark,
        'pincode': pincode,
      });
      Response response = await dioClient.post(
        AppConstants.APIaddAddress,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  /// APIshowAddress  ///////////////////////

  Future<ApiResponse> showAddressApi() async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
      });
      Response response = await dioClient.post(
        AppConstants.APIshowAddress,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  ///  APIdeleteAddress  ///////////////////////

  Future<ApiResponse> deleteAddressapi(String addressId) async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'address_id': addressId,
        'userid': userID,
      });
      Response response = await dioClient.post(
        AppConstants.APIdeleteAddress,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  ///  APIupdateAddress  ///////////////////////

  Future<ApiResponse> updateAddressapi(String name,String mobile, String address,String city,String state,String land_mark,String pincode,String addressId) async {
    String userID = await SharedPrefManager.getPrefrenceString(AppConstants.USERID);
    try {
      FormData formData = FormData.fromMap({
        'userid': userID,
        'name': name,
        'mobile': mobile,
        'address': address,
        'city': city,
        'state': state,
        'land_mark': land_mark,
        'pincode': pincode,
        'address_id': addressId,
      });
      Response response = await dioClient.post(
        AppConstants.APIupdateAddress,
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),);
      print("request: "+formData.fields.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}