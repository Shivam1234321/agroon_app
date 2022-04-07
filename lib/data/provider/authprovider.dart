import 'dart:convert';
import 'dart:io';

import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/data/model/response/base/error_response.dart';
import 'package:agroon/data/model/response/response_model.dart';
import 'package:agroon/data/repository/auth_repo/auth_repo.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/authentication/forgotPasswordwithmobile.dart';
import 'package:agroon/screen/authentication/forgot_password_page.dart';
import 'package:agroon/screen/authentication/otp_page.dart';
import 'package:agroon/screen/authentication/signin_page.dart';
import 'package:agroon/screen/profile/change_password_page.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthProvider with ChangeNotifier{

  final AuthRepo authRepo;

  AuthProvider({this.authRepo});

// for registration section
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _registrationErrorMessage = '';

  String get registrationErrorMessage => _registrationErrorMessage;



  /// signinApi/////////////////////////

  Future<ResponseModel> signinApi(String mobile, String password) async {
    List list;
    ApiResponse apiResponse = await authRepo.signinApi(mobile,password);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      // String userId = list[0]['data']['UserId'].toString();
      // print("UserId"+userId.toString());
      // Fluttertoast.showToast(msg: list[0]['msg'].toString(),
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white
      // );
      if(list[0]['status'] == 2){
        Get.off(() => BottomNavigationBarPage(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 600));

        await SharedPrefManager.savePrefString(AppConstants.USERID, list[0]['data']['UserId'].toString());
        await SharedPrefManager.savePreferenceBoolean(true);

      }else if(list[0]['status']==1){
        Get.off(() => OtpPage(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 600));
      }
        else {
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
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  /// RegisterApi/////////////////////////

  Future<ResponseModel> registerApi(String name,String shopname,String email,String mobile,String gstno,String state,String city,String address,String password,String confirmPassword) async {

    List list;
    ApiResponse apiResponse = await authRepo.registerUserApi( name, shopname, email, mobile, gstno, state, city, address, password, confirmPassword);

    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);

      // Fluttertoast.showToast(msg: list[0]['msg'].toString(),
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white
      // );
      if(list[0]['status'] == 1){
        print("msg"+list[0]['msg'].toString());
        Get.to(() => OtpPage(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 600));
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
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  /// otpverifyApi/////////////////////////

  Future<ResponseModel> otpVerifyApi(String otp) async {
    String move='';
    move = await SharedPrefManager.getPrefrenceString(AppConstants.MOVE);
    List list;
    ApiResponse apiResponse = await authRepo.otpVerifyApi(otp);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      String userId = list[0]['data']['UserId'].toString();
      print("UserId"+userId.toString());
      Fluttertoast.showToast(msg: list[0]['msg'].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white
      );
      if(list[0]['status'] == 1){
        if(move=='MOVE'){
          Get.off(() => ForgotPasswordWithMobile(),
              transition: Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 600));
        }else{
          Get.off(() => BottomNavigationBarPage(),
              transition: Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 600));
          await SharedPrefManager.savePreferenceBoolean(true);
        }

        await SharedPrefManager.savePrefString(AppConstants.USERID, list[0]['data']['UserId'].toString());

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
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  /// forgotPasswordApi/////////////////////////

  Future<ResponseModel> forgotPasswordApi(String mobile, String newPassword, String confirmPassword) async {
    List list;
    ApiResponse apiResponse = await authRepo.forgotPasswordApi(mobile, newPassword, confirmPassword);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);

      if(list[0]['status'] == 1){

        Fluttertoast.showToast(msg: list[0]['msg'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
        Get.offAll(() => SignInPage(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 600));

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
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  /// resendotpApi/////////////////////////

  Future<ResponseModel> resendOtpApi() async {
    List list;
    ApiResponse apiResponse = await authRepo.resendOtpApi();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);

      if(list[0]['status'] == 1){

        Fluttertoast.showToast(msg: list[0]['msg'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
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
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }


  /// getotpApi/////////////////////////

  Future<ResponseModel> getOtpApi(String mobile) async {
   await SharedPrefManager.savePrefString(AppConstants.MOBILE, mobile);
   await SharedPrefManager.savePrefString(AppConstants.MOVE, "MOVE");
    List list;
    ApiResponse apiResponse = await authRepo.getOtpApi(mobile);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);

      if(list[0]['status'] == 1){

        Fluttertoast.showToast(msg: list[0]['msg'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
        Get.to(() => OtpPage(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 600));

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
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }




  /// ChangePasswordApi Api /////////////////////////

  Future<ResponseModel> changePasswordApi(String oldPassword, String newPassword, String confirmPassword) async {
    List list;
    ApiResponse apiResponse = await authRepo.changePasswordApi(oldPassword, newPassword, confirmPassword);
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);

      if(list[0]['status'] == 1){
        Fluttertoast.showToast(msg: list[0]['msg'].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white);
        // Get.offAll(() => SignInPage(),
        //     transition: Transition.rightToLeftWithFade,
        //     duration: const Duration(milliseconds: 600));

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
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  /// checkUserApi /////////////////////////

  Future<ResponseModel> checkUserApi() async {
    List list;
    ApiResponse apiResponse = await authRepo.checkUserApi();
    ResponseModel responseModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      list = jsonDecode(apiResponse.response.data);
      if(list[0]['status'] == 1){
        // Fluttertoast.showToast(msg: list[0]['msg'].toString(),
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white);
      }else{
        Get.offAll(() => SignInPage(),
            transition: Transition.rightToLeftWithFade,
            duration: const Duration(milliseconds: 600));
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
      _registrationErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }



}