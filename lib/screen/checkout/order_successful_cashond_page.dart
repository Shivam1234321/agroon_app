// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:zzz_mart/api/apiManager.dart';
// import 'package:zzz_mart/commons/common_button.dart';
// import 'package:zzz_mart/model/checkout_model.dart';
// import 'package:zzz_mart/model/order_payment_model.dart';
// import 'package:zzz_mart/pages/dashboard/dashboard_controller.dart';
//
// class OrderSuccessfulCashOnDPage extends StatefulWidget {
//   // var paymentid;
//
//   OrderSuccessfulCashOnDPage({Key? key}) : super(key: key);
//
//
//   @override
//   _OrderSuccessfulCashOnDPageState createState() => _OrderSuccessfulCashOnDPageState();
// }
//
// class _OrderSuccessfulCashOnDPageState extends State<OrderSuccessfulCashOnDPage> {
//
//
//   CheckoutData checkoutData = Get.arguments;
//   late List<OrderPaymentModel> orderPaymentModel = [];
//
//   // String get paymentid => paymentid;
//
//   // var d = Get.arguments;
//   // late CheckoutData checkoutData = d[0];
//
//   @override
//   void initState() {
//     super.initState();
//     ApiManager apiManager = new ApiManager();
//     apiManager.checkUser();
//    Future future = apiManager.orderpaymentApi(checkoutData.orderId, checkoutData.orderKey, 1234);
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
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(height: 50),
//                       _headings(),
//                       SizedBox(height: 50),
//                       _checkoutpic(),
//                       SizedBox(height: 30),
//                       _gretings(),
//                       SizedBox(height: 30),
//                       _orderid(),
//                       SizedBox(height: 50),
//                       _continueshoppingbutton(),
//                     ],
//                   ),
//                 ),
//               ),
//             )));
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
//         DecorationImage(image: AssetImage("assets/images/checkorange.png")),
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
//           if(checkoutData==null)
//             Text("")
//           else Text("Order Id : ${checkoutData.orderId}",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: HexColor("000000"),
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "Ubuntu-Regular",
//               )),
//           SizedBox(height: 5),
//           if(checkoutData==null)
//             Text("")
//           else Text("Txn Id : ${checkoutData.orderKey}",
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
//       CommonButton(text: "Continue shopping", width: Get.width, height: 50),
//     );
//   }
// }
