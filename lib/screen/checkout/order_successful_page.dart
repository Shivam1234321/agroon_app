// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:zzz_mart/api/apiManager.dart';
// import 'package:zzz_mart/commons/common_button.dart';
// import 'package:zzz_mart/model/checkout_model.dart';
// import 'package:zzz_mart/model/order_payment_model.dart';
// import 'package:zzz_mart/pages/dashboard/dashboard_controller.dart';
//
// class OrderSuccessfulPage extends StatefulWidget {
//   // var paymentid;
//
//     OrderSuccessfulPage({Key? key}) : super(key: key);
//
//
//   @override
//   _OrderSuccessfulPageState createState() => _OrderSuccessfulPageState();
// }
//
// class _OrderSuccessfulPageState extends State<OrderSuccessfulPage> {
//
//
//   //CheckoutData checkoutData = Get.arguments;
//   late List<OrderPaymentModel> orderPaymentModel = [];
//
//   // String get paymentid => paymentid;
//
//   var d = Get.arguments;
//   late CheckoutData checkoutData = d[0];
//   late var paymentid = d[1];
//
//   @override
//   void initState() {
//     super.initState();
//     ApiManager apiManager = new ApiManager();
//     apiManager.checkUser();
//     Future future = apiManager.orderpaymentApi(checkoutData.orderId, checkoutData.orderKey, d[1]);
//     print("hfhfhfhf"+d[1]);
//     future.then((value){
//       setState(() {
//         orderPaymentModel = value;
//       });
//
//       print("ffffffffffffggggggfffff"+orderPaymentModel[0].data.orderId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//             child: Container(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 50),
//                   _headings(),
//                   SizedBox(height: 50),
//                   _checkoutpic(),
//                   SizedBox(height: 30),
//                   _gretings(),
//                   SizedBox(height: 30),
//                   _orderid(),
//                   SizedBox(height: 50),
//                   _continueshoppingbutton(),
//                 ],
//               ),
//             ),
//           ),
//         )));
//   }
//
//   _headings() {
//     return Center(
//       child: Text(" Congratulations!",
//           style: TextStyle(
//             fontSize: 22,
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontFamily: "Ubuntu-Regular",
//           )),
//     );
//   }
//
//   _checkoutpic() {
//     return Container(
//       height: 150,
//       width: 150,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         image:
//             DecorationImage(image: AssetImage("assets/images/checkorange.png")),
//         color: Colors.orange[50],
//       ),
//     );
//   }
//
//   _gretings() {
//     return Center(
//       child: Column(
//         children: [
//           Text("Order placed successfully",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: HexColor("F8C07B"),
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "Ubuntu-Regular",
//               )),
//           SizedBox(height: 5),
//           Text("Thank you!",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: HexColor("F8C07B"),
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "Ubuntu-Regular",
//               )),
//         ],
//       ),
//     );
//   }
//
//   _orderid() {
//     return Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if(orderPaymentModel.isEmpty)
//             Text("")
//           else Text("Order Id : ${orderPaymentModel[0].data.orderId}",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: HexColor("000000"),
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "Ubuntu-Regular",
//               )),
//           SizedBox(height: 5),
//           if(orderPaymentModel.isEmpty)
//             Text("")
//           else Text("Txn Id : ${orderPaymentModel[0].data.orderKey}",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: HexColor("000000"),
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "Ubuntu-Regular",
//               )),
//         ],
//       ),
//     );
//   }
//
//   _continueshoppingbutton() {
//     return InkWell(
//       onTap: () {
//         Get.off(DashboardController(),
//             transition: Transition.rightToLeftWithFade,
//             duration: Duration(milliseconds: 600));
//       },
//       child:
//           CommonButton(text: "Continue shopping", width: Get.width, height: 50),
//     );
//   }
// }

/// jklknapj ////////////////////////


/// khsoa ///////////////////////////////

//
// import 'package:cashfree_pg/cashfree_pg.dart';
// import 'package:flutter/material.dart';
//
//
// class OrderSucc extends StatefulWidget {
//   @override
//   _OrderSuccState createState() => _OrderSuccState();
// }
//
// class _OrderSuccState extends State<OrderSucc> {
//
//   var _selectedApp;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Cashfree SDK Sample'),
//         ),
//         body: Column(
//           children: [
//             Center(
//               child: RaisedButton(
//                 child: Text('WEB CHECKOUT'),
//                 onPressed: () => makePayment(),
//               ),
//             ),
//             Center(
//               child: RaisedButton(
//                 child: Text('SEAMLESS CARD'),
//                 onPressed: () => seamlessCardPayment(),
//               ),
//             ),
//             Center(
//               child: RaisedButton(
//                 child: Text('SEAMLESS NETBANKING'),
//                 onPressed: () => seamlessNetbankingPayment(),
//               ),
//             ),
//             Center(
//               child: RaisedButton(
//                 child: Text('SEAMLESS WALLET'),
//                 onPressed: () => seamlessWalletPayment(),
//               ),
//             ),
//             Center(
//               child: RaisedButton(
//                 child: Text('SEAMLESS UPI COLLECT'),
//                 onPressed: () => seamlessUPIPayment(),
//               ),
//             ),
//             Center(
//               child: RaisedButton(
//                 child: Text('SEAMLESS PAYPAL'),
//                 onPressed: () => seamlessPayPalPayment(),
//               ),
//             ),
//             Center(
//               child: RaisedButton(
//                 child: Text('UPI INTENT'),
//                 onPressed: () => makeUpiPayment(),
//               ),
//             ),
//             Center(
//               child: RaisedButton(
//                 child: Text('GET INSTALLED UPI APPS'),
//                 onPressed: () => getUPIApps(),
//               ),
//             ),
//             Center(
//               child: RaisedButton(
//                 child: Text('SEAMLESS UPI INTENT'),
//                 onPressed: () => seamlessUPIIntent(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void getUPIApps() {
//     CashfreePGSDK.getUPIApps().then((value) => {
//       if(value != null && value.length > 0) {
//         _selectedApp = value[0]
//       }
//     });
//   }
//
//   // WEB Intent
//   makePayment() {
//     //Replace with actual values
//     String orderId = "ORDER_ID";
//     String stage = "PROD";
//     String orderAmount = "ORDER_AMOUNT";
//     String tokenData = "TOKEN_DATA";
//     String customerName = "Customer Name";
//     String orderNote = "Order_Note";
//     String orderCurrency = "INR";
//     String appId = "APP_ID";
//     String customerPhone = "Customer Phone";
//     String customerEmail = "sample@gmail.com";
//     String notifyUrl = "https://test.gocashfree.com/notify";
//
//     Map<String, dynamic> inputParams = {
//       "orderId": orderId,
//       "orderAmount": orderAmount,
//       "customerName": customerName,
//       "orderNote": orderNote,
//       "orderCurrency": orderCurrency,
//       "appId": appId,
//       "customerPhone": customerPhone,
//       "customerEmail": customerEmail,
//       "stage": stage,
//       "tokenData": tokenData,
//       "notifyUrl": notifyUrl
//     };
//
//     CashfreePGSDK.doPayment(inputParams)
//         .then((value) => value?.forEach((key, value) {
//       print("$key : $value");
//       //Do something with the result
//     }));
//   }
//
//   // SEAMLESS - CARD
//   Future<void> seamlessCardPayment() async {
//     String orderId = "ORDER_ID";
//     String stage = "PROD";
//     String orderAmount = "ORDER_AMOUNT";
//     String tokenData = "TOKEN_DATA";
//     String customerName = "Customer Name";
//     String orderNote = "Order_Note";
//     String orderCurrency = "INR";
//     String appId = "APP_ID";
//     String customerPhone = "Customer Phone";
//     String customerEmail = "sample@gmail.com";
//     String notifyUrl = "https://test.gocashfree.com/notify";
//
//     Map<String, dynamic> inputParams = {
//       "orderId": orderId,
//       "orderAmount": orderAmount,
//       "customerName": customerName,
//       "orderNote": orderNote,
//       "orderCurrency": orderCurrency,
//       "appId": appId,
//       "customerPhone": customerPhone,
//       "customerEmail": customerEmail,
//       "stage": stage,
//       "tokenData": tokenData,
//       "notifyUrl": notifyUrl,
//
//       // EXTRA THINGS THAT NEEDS TO BE ADDED
//       "paymentOption": "card",
//       "card_number": "ENTER CARD NUMBER",
//       "card_expiryMonth": "MONTH IN MM format",
//       "card_expiryYear": "EXPIRY IN YYYY format",
//       "card_holder": "Card Holder Name",
//       "card_cvv": "Card CVV"
//     };
//
//     CashfreePGSDK.doPayment(inputParams)
//         .then((value) => value?.forEach((key, value) {
//       print("$key : $value");
//       //Do something with the result
//     }));
//   }
//
//   // SEAMLESS - NETBANKING
//   Future<void> seamlessNetbankingPayment() async {
//     String orderId = "ORDER_ID";
//     String stage = "PROD";
//     String orderAmount = "ORDER_AMOUNT";
//     String tokenData = "TOKEN_DATA";
//     String customerName = "Customer Name";
//     String orderNote = "Order_Note";
//     String orderCurrency = "INR";
//     String appId = "APP_ID";
//     String customerPhone = "Customer Phone";
//     String customerEmail = "sample@gmail.com";
//     String notifyUrl = "https://test.gocashfree.com/notify";
//
//     Map<String, dynamic> inputParams = {
//       "orderId": orderId,
//       "orderAmount": orderAmount,
//       "customerName": customerName,
//       "orderNote": orderNote,
//       "orderCurrency": orderCurrency,
//       "appId": appId,
//       "customerPhone": customerPhone,
//       "customerEmail": customerEmail,
//       "stage": stage,
//       "tokenData": tokenData,
//       "notifyUrl": notifyUrl,
//
//       // EXTRA THINGS THAT NEEDS TO BE ADDED
//       "paymentOption": "nb",
//       "paymentCode": "ENTER Code", // Find Code here https://docs.cashfree.com/docs/net-banking
//     };
//
//     CashfreePGSDK.doPayment(inputParams)
//         .then((value) => value?.forEach((key, value) {
//       print("$key : $value");
//       //Do something with the result
//     }));
//   }
//
//   // SEAMLESS - WALLET
//   Future<void> seamlessWalletPayment() async {
//     String orderId = "ORDER_ID";
//     String stage = "PROD";
//     String orderAmount = "ORDER_AMOUNT";
//     String tokenData = "TOKEN_DATA";
//     String customerName = "Customer Name";
//     String orderNote = "Order_Note";
//     String orderCurrency = "INR";
//     String appId = "APP_ID";
//     String customerPhone = "Customer Phone";
//     String customerEmail = "sample@gmail.com";
//     String notifyUrl = "https://test.gocashfree.com/notify";
//
//     Map<String, dynamic> inputParams = {
//       "orderId": orderId,
//       "orderAmount": orderAmount,
//       "customerName": customerName,
//       "orderNote": orderNote,
//       "orderCurrency": orderCurrency,
//       "appId": appId,
//       "customerPhone": customerPhone,
//       "customerEmail": customerEmail,
//       "stage": stage,
//       "tokenData": tokenData,
//       "notifyUrl": notifyUrl,
//
//       // EXTRA THINGS THAT NEEDS TO BE ADDED
//       "paymentOption": "wallet",
//       "paymentCode": "ENTER Code", // Find Code here https://docs.cashfree.com/docs/wallets
//     };
//
//     CashfreePGSDK.doPayment(inputParams)
//         .then((value) => value?.forEach((key, value) {
//       print("$key : $value");
//       //Do something with the result
//     }));
//   }
//
//
//   // SEAMLESS - UPI
//   Future<void> seamlessUPIPayment() async {
//     String orderId = "ORDER_ID";
//     String stage = "PROD";
//     String orderAmount = "ORDER_AMOUNT";
//     String tokenData = "TOKEN_DATA";
//     String customerName = "Customer Name";
//     String orderNote = "Order_Note";
//     String orderCurrency = "INR";
//     String appId = "APP_ID";
//     String customerPhone = "Customer Phone";
//     String customerEmail = "sample@gmail.com";
//     String notifyUrl = "https://test.gocashfree.com/notify";
//
//     Map<String, dynamic> inputParams = {
//       "orderId": orderId,
//       "orderAmount": orderAmount,
//       "customerName": customerName,
//       "orderNote": orderNote,
//       "orderCurrency": orderCurrency,
//       "appId": appId,
//       "customerPhone": customerPhone,
//       "customerEmail": customerEmail,
//       "stage": stage,
//       "tokenData": tokenData,
//       "notifyUrl": notifyUrl,
//
//       // EXTRA THINGS THAT NEEDS TO BE ADDED
//       "paymentOption": "upi",
//       "upi_vpa": "ENTER Correct UPI ID here"
//     };
//
//     CashfreePGSDK.doPayment(inputParams)
//         .then((value) => value?.forEach((key, value) {
//       print("$key : $value");
//       //Do something with the result
//     }));
//   }
//
//
//   // SEAMLESS - Paypal
//   Future<void> seamlessPayPalPayment() async {
//     String orderId = "ORDER_ID";
//     String stage = "PROD";
//     String orderAmount = "ORDER_AMOUNT";
//     String tokenData = "TOKEN_DATA";
//     String customerName = "Customer Name";
//     String orderNote = "Order_Note";
//     String orderCurrency = "INR";
//     String appId = "APP_ID";
//     String customerPhone = "Customer Phone";
//     String customerEmail = "sample@gmail.com";
//     String notifyUrl = "https://test.gocashfree.com/notify";
//
//     Map<String, dynamic> inputParams = {
//       "orderId": orderId,
//       "orderAmount": orderAmount,
//       "customerName": customerName,
//       "orderNote": orderNote,
//       "orderCurrency": orderCurrency,
//       "appId": appId,
//       "customerPhone": customerPhone,
//       "customerEmail": customerEmail,
//       "stage": stage,
//       "tokenData": tokenData,
//       "notifyUrl": notifyUrl,
//
//       // EXTRA THINGS THAT NEEDS TO BE ADDED
//       "paymentOption": "paypal"
//     };
//
//     CashfreePGSDK.doPayment(inputParams)
//         .then((value) => value?.forEach((key, value) {
//       print("$key : $value");
//       //Do something with the result
//     }));
//   }
//
//   // UPI Intent
//   Future<void> makeUpiPayment() async {
//     //Replace with actual values
//     String orderId = "ORDER_ID";
//     String stage = "PROD";
//     String orderAmount = "ORDER_AMOUNT";
//     String tokenData = "TOKEN_DATA";
//     String customerName = "Customer Name";
//     String orderNote = "Order_Note";
//     String orderCurrency = "INR";
//     String appId = "APP_ID";
//     String customerPhone = "Customer Phone";
//     String customerEmail = "sample@gmail.com";
//     String notifyUrl = "https://test.gocashfree.com/notify";
//
//
//     Map<String, dynamic> inputParams = {
//       "orderId": orderId,
//       "orderAmount": orderAmount,
//       "customerName": customerName,
//       "orderNote": orderNote,
//       "orderCurrency": orderCurrency,
//       "appId": appId,
//       "customerPhone": customerPhone,
//       "customerEmail": customerEmail,
//       "stage": stage,
//       "tokenData": tokenData,
//       "notifyUrl": notifyUrl
//     };
//
//     CashfreePGSDK.doUPIPayment(inputParams)
//         .then((value) => value?.forEach((key, value) {
//       print("$key : $value");
//       //Do something with the result
//     }));
//   }
//
//
//   // SEAMLESS UPI Intent
//   Future<void> seamlessUPIIntent() async {
//     //Replace with actual values
//     String orderId = "ORDER_ID";
//     String stage = "PROD";
//     String orderAmount = "ORDER_AMOUNT";
//     String tokenData = "TOKEN_DATA";
//     String customerName = "Customer Name";
//     String orderNote = "Order_Note";
//     String orderCurrency = "INR";
//     String appId = "APP_ID";
//     String customerPhone = "Customer Phone";
//     String customerEmail = "sample@gmail.com";
//     String notifyUrl = "https://test.gocashfree.com/notify";
//
//
//     Map<String, dynamic> inputParams = {
//       "orderId": orderId,
//       "orderAmount": orderAmount,
//       "customerName": customerName,
//       "orderNote": orderNote,
//       "orderCurrency": orderCurrency,
//       "appId": appId,
//       "customerPhone": customerPhone,
//       "customerEmail": customerEmail,
//       "stage": stage,
//       "tokenData": tokenData,
//       "notifyUrl": notifyUrl,
//
//
//       // For seamless UPI Intent
//       "appName": _selectedApp["id"]
//     };
//
//     CashfreePGSDK.doUPIPayment(inputParams)
//         .then((value) => value?.forEach((key, value) {
//       print("$key : $value");
//       //Do something with the result
//     }));
//   }
// }