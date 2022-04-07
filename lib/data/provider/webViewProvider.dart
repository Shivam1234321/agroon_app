import 'package:agroon/data/model/checkCoupon_model.dart';
import 'package:agroon/data/model/getPartialDeductionAmount_model.dart';
import 'package:agroon/data/model/order_model.dart';
import 'package:agroon/data/model/response/base/api_response.dart';
import 'package:agroon/data/model/response/base/error_response.dart';
import 'package:agroon/data/model/response/response_model.dart';
import 'package:agroon/data/model/showorderDetails_model.dart';
import 'package:agroon/data/model/showorder_model.dart';
import 'package:agroon/data/model/support_model.dart';
import 'package:agroon/data/model/webView_model.dart';
import 'package:agroon/data/repository/walkthrow_repo/walkthrow_repo.dart';
import 'package:agroon/data/repository/wevView_repo/webView_repo.dart';
import 'package:agroon/screen/checkout/order_successful_cashond_page.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WebViewProvider with ChangeNotifier{

  final WebViewRepo webViewRepo;

  WebViewProvider({this.webViewRepo});

  /// webViewApi //////////////////////////////////////

  List<WebViewModel> webViewModel;

  List<WebViewModel> get webViewModelList => webViewModel;

  Future<ResponseModel> webViewApi() async {
    List list;
    webViewModel = null;
    ResponseModel responseModel;
    if(webViewModel == null) {
      ApiResponse apiResponse = await webViewRepo.webViewApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = apiResponse.response.data;
        webViewModel = list.map((data) => new WebViewModel.fromJson(data)).toList();

        // list = apiResponse.response.data[0]['data'];
        //  list.forEach((offerProduct) => offerNotificationData.add(OfferNotificationData.fromJson(offerProduct)));

        // if(list[0]['status'] == 1){
        //   list.forEach((offerProduct) => offerNotificationData.add(OfferNotificationData.fromJson(offerProduct)));
        //   // Fluttertoast.showToast(msg: list[0]['msg'].toString(),
        //   //     toastLength: Toast.LENGTH_SHORT,
        //   //     gravity: ToastGravity.CENTER,
        //   //     backgroundColor: Colors.black,
        //   //     textColor: Colors.white);
        // }else{
        //   Get.rawSnackbar(message: apiResponse.response.data['msg'].toString());
        // }
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
        // _registrationErrorMessage = errorMessage;
        responseModel = ResponseModel(false, errorMessage);
      }
      // _isLoading = false;
      notifyListeners();
      return responseModel;
    }
  }


  /// webViewApi //////////////////////////////////////

  List<GetPartialDeductionAmountModel> getPartialDeductionAmountModel;

  List<GetPartialDeductionAmountModel> get getPartialDeductionAmountModelList => getPartialDeductionAmountModel;

  Future<ResponseModel> getPartialDeductionAmountApi() async {
    List list;
    getPartialDeductionAmountModel = null;
    ResponseModel responseModel;
    if(getPartialDeductionAmountModel == null) {
      ApiResponse apiResponse = await webViewRepo.getPartialDeductionAmountApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = apiResponse.response.data;
        if(list[0]['status'] == 1){
          getPartialDeductionAmountModel = list.map((data) => new GetPartialDeductionAmountModel.fromJson(data)).toList();
          // Fluttertoast.showToast(msg: list[0]['msg'].toString(),
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
        }else{
          Get.rawSnackbar(message: getPartialDeductionAmountModel[0].msg.toString());
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
        // _registrationErrorMessage = errorMessage;
        responseModel = ResponseModel(false, errorMessage);
      }
      // _isLoading = false;
      notifyListeners();
      return responseModel;
    }
  }

  /// checkCouponApi //////////////////////////////////////

  List<CheckCouponModel> checkCouponModel;

  List<CheckCouponModel> get checkCouponModelList => checkCouponModel;

  Future<ResponseModel> checkCouponApi(String couponCode) async {
    List list;
    checkCouponModel = null;
    ResponseModel responseModel;
    if(checkCouponModel == null) {
      ApiResponse apiResponse = await webViewRepo.checkCouponapi(couponCode);
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = apiResponse.response.data;
        // list = apiResponse.response.data[0]['data'];
        if(list[0]['status'] == 1){
          checkCouponModel = list.map((data) => new CheckCouponModel.fromJson(data)).toList();
          Fluttertoast.showToast(msg: checkCouponModel[0].msg.toString(),
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
        // _registrationErrorMessage = errorMessage;
        responseModel = ResponseModel(false, errorMessage);
      }
      // _isLoading = false;
      notifyListeners();
      return responseModel;
    }
  }

  /// orderapi //////////////////////////////////////

  List<OrderModel> orderModel;

  List<OrderModel> get orderModellList => orderModel;

  Future<ResponseModel> orderapi(String couponCode,String partialpaymentamount,String paymentType,String totalAmount,String coupondiscountAmount) async {
    List list;
    orderModel = null;
    ResponseModel responseModel;
    if(orderModel == null) {
      ApiResponse apiResponse = await webViewRepo.orderapi(couponCode,partialpaymentamount,paymentType,totalAmount,coupondiscountAmount);
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = apiResponse.response.data;
        // list = apiResponse.response.data[0]['data'];
        if(list[0]['status'] == 1){
          orderModel = list.map((data) => new OrderModel.fromJson(data)).toList();

        await  SharedPrefManager.savePrefString(AppConstants.ORDERID, orderModel[0].data.orderId.toString());
        await  SharedPrefManager.savePrefString(AppConstants.ORDERKEY, orderModel[0].data.orderKey.toString());
          // Get.offAll(OrderSuccessfulCashOnDPage(),
          //     transition: Transition.zoom,
          //     curve: Curves.bounceOut,
          //     duration: Duration(milliseconds: 600),);
          Fluttertoast.showToast(msg: orderModel[0].msg.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.black,
              textColor: Colors.white);
        }else{
          Get.rawSnackbar(message: checkCouponModel[0].msg.toString());
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
        // _registrationErrorMessage = errorMessage;
        responseModel = ResponseModel(false, errorMessage);
      }
      // _isLoading = false;
      notifyListeners();
      return responseModel;
    }
  }


  /// orderPaymentAPi //////////////////////////////////////

  Future<ResponseModel> orderPaymentAPi() async {
    List list;
    orderModel = null;
    ResponseModel responseModel;
    if(orderModel == null) {
      ApiResponse apiResponse = await webViewRepo.orderPaymentAPi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = apiResponse.response.data;
        // list = apiResponse.response.data[0]['data'];
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
        // _registrationErrorMessage = errorMessage;
        responseModel = ResponseModel(false, errorMessage);
      }
      // _isLoading = false;
      notifyListeners();
      return responseModel;
    }
  }



  /// showOrderapi //////////////////////////////////////

  List<ShowOrderModel> showOrderModel;

  List<ShowOrderModel> get showOrderModelList => showOrderModel;

  Future<ResponseModel> showOrderapi() async {
    List list;
    showOrderModel = null;
    ResponseModel responseModel;
    if(showOrderModel == null) {
      ApiResponse apiResponse = await webViewRepo.showOrderapi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = apiResponse.response.data;
        // list = apiResponse.response.data[0]['data'];
        if(list[0]['status'] == 1){
          showOrderModel = list.map((data) => new ShowOrderModel.fromJson(data)).toList();
          // Fluttertoast.showToast(msg: orderModel[0].msg.toString(),
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
        }else{
          Get.rawSnackbar(message: checkCouponModel[0].msg.toString());
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
        // _registrationErrorMessage = errorMessage;
        responseModel = ResponseModel(false, errorMessage);
      }
      // _isLoading = false;
      notifyListeners();
      return responseModel;
    }
  }

  /// orderDetailsapi //////////////////////////////////////

  List<OrderDetailsModel> orderDetailsModel;

  List<OrderDetailsModel> get orderDetailsModelList => orderDetailsModel;

  Future<ResponseModel> orderDetailsapi() async {
    List list;
    orderDetailsModel = null;
    ResponseModel responseModel;
    if(orderDetailsModel == null) {
      ApiResponse apiResponse = await webViewRepo.orderDetailsapi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = apiResponse.response.data;
        if(list[0]['status'] == 1){
          orderDetailsModel = list.map((data) => new OrderDetailsModel.fromJson(data)).toList();
          // Fluttertoast.showToast(msg: orderModel[0].msg.toString(),
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
        }else{
          Get.rawSnackbar(message: checkCouponModel[0].msg.toString());
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
        // _registrationErrorMessage = errorMessage;
        responseModel = ResponseModel(false, errorMessage);
      }
      // _isLoading = false;
      notifyListeners();
      return responseModel;
    }
  }


  /// supportNumbersApi //////////////////////////////////////

  List<SupportModel> supportModel;

  List<SupportModel> get supportModelList => supportModel;

  Future<ResponseModel> supportNumbersApi() async {
    List list;
    supportModel = null;
    ResponseModel responseModel;
    if(supportModel == null) {
      ApiResponse apiResponse = await webViewRepo.supportNumbersApi();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        list = apiResponse.response.data;
        if(list[0]['status'] == 1){
          supportModel = list.map((data) => new SupportModel.fromJson(data)).toList();
          // Fluttertoast.showToast(msg: list[0]['msg'].toString(),
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     backgroundColor: Colors.black,
          //     textColor: Colors.white);
        }else{
          Get.rawSnackbar(message: supportModel[0].msg.toString());
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
        // _registrationErrorMessage = errorMessage;
        responseModel = ResponseModel(false, errorMessage);
      }
      // _isLoading = false;
      notifyListeners();
      return responseModel;
    }
  }

}