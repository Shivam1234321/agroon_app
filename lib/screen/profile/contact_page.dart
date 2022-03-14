// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:zzz_mart/api/apiManager.dart';
// import 'package:zzz_mart/model/contactus_model.dart';
//
// class ContactUsPage extends StatefulWidget {
//   const ContactUsPage({Key? key}) : super(key: key);
//
//   @override
//   _ContactUsPageState createState() => _ContactUsPageState();
// }
//
// class _ContactUsPageState extends State<ContactUsPage> {
//
//
//   late List<ContactUsModel> contactUsModel = [];
//
//   @override
//   void initState() {
//     super.initState();
//     ApiManager apiManager = new ApiManager();
//     apiManager.checkUser();
//     Future future = apiManager.contactusApi();
//     future.then((value){
//       setState(() {
//         contactUsModel = value;
//         print("dddddddddhdh"+contactUsModel[0].data.mobile.toString());
//       });
//     });
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Get.back();
//               },
//               icon: Icon(Icons.keyboard_arrow_left_outlined,
//                   color: Colors.black, size: 28)),
//           centerTitle: true,
//           title: Text("Contact Us",
//               style: TextStyle(
//                 fontSize: 15,
//                 letterSpacing: 1,
//                 color: HexColor("2E43FF"),
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "Ubuntu-Regular",
//               )),
//           backgroundColor: Colors.white,
//           // actions: [
//           //   IconButton(
//           //       onPressed: () {
//           //         // Get.to(WishListPage(),
//           //         //     transition: Transition.rightToLeftWithFade,
//           //         //     duration: Duration(milliseconds: 600));
//           //       },
//           //       icon: Icon(
//           //         Icons.favorite_border,
//           //         color: HexColor("2E43FF"),
//           //       )),
//           //   IconButton(
//           //       onPressed: () {
//           //         // Get.to(CheckOutPage(),
//           //         //     transition: Transition.rightToLeftWithFade,
//           //         //     duration: Duration(milliseconds: 600));
//           //       },
//           //       icon: Icon(
//           //         Icons.shopping_bag,
//           //         color: HexColor("2E43FF"),
//           //       ))
//           // ],
//         ),
//         body: SingleChildScrollView(
//             child: Container(
//           height: Get.height / 1.15,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 20, bottom: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       SizedBox(height: 20),
//                       _address(),
//                       SizedBox(height: 20),
//                       _mailus(),
//                       SizedBox(height: 20),
//                       _callus(),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Text("Follow us on",
//                         style: TextStyle(
//                           fontSize: 15,
//                           letterSpacing: 0.8,
//                           color: HexColor("000000"),
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "Ubuntu-Regular",
//                         )),
//                     SizedBox(height: 5),
//                     Divider(
//                       thickness: 1.5,
//                       color: Colors.black,
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 50,
//                           width: 50,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image:
//                                     AssetImage("assets/images/facebook.png")),
//                             color: Colors.orange[50],
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Container(
//                           height: 50,
//                           width: 50,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image:
//                                     AssetImage("assets/images/linkedin.png")),
//                             color: Colors.orange[50],
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Container(
//                           height: 50,
//                           width: 50,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: AssetImage("assets/images/twitter.png")),
//                             color: Colors.orange[50],
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Container(
//                           height: 50,
//                           width: 50,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: AssetImage("assets/images/insta.png")),
//                             color: Colors.orange[50],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         )));
//   }
//
//   _address() {
//     return InkWell(
//       onTap: () {
//         // Get.to(ContactUsPage(),
//         //     transition: Transition.rightToLeftWithFade,
//         //     duration: Duration(milliseconds: 600));
//       },
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.grey.shade300,
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.call,
//                   color: HexColor("000000"),
//                 ),
//               )),
//           SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Address:",
//                   style: TextStyle(
//                     fontSize: 15,
//                     letterSpacing: 0.5,
//                     color: HexColor("000000"),
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "Ubuntu-Regular",
//                   )),
//               SizedBox(height: 5),
//               if(contactUsModel.isEmpty)
//                 CircularProgressIndicator()
//               else Text(contactUsModel[0].data.address.toString(),
//                   style: TextStyle(
//                     letterSpacing: 0.3,
//                     color: HexColor("000000"),
//                     fontWeight: FontWeight.w400,
//                     fontFamily: "Ubuntu-Regular",
//                   )),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   _mailus() {
//     return InkWell(
//       onTap: () {
//         // Get.to(ContactUsPage(),
//         //     transition: Transition.rightToLeftWithFade,
//         //     duration: Duration(milliseconds: 600));
//       },
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.grey.shade300,
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.mail,
//                   color: HexColor("000000"),
//                 ),
//               )),
//           SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Mail Us:",
//                   style: TextStyle(
//                     fontSize: 15,
//                     letterSpacing: 0.5,
//                     color: HexColor("000000"),
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "Ubuntu-Regular",
//                   )),
//               SizedBox(height: 5),
//              if(contactUsModel.isEmpty)
//                CircularProgressIndicator()
//               else Text(contactUsModel[0].data.email.toString(),
//                   style: TextStyle(
//                     letterSpacing: 0.3,
//                     color: HexColor("000000"),
//                     fontWeight: FontWeight.w400,
//                     fontFamily: "Ubuntu-Regular",
//                   )),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   _callus() {
//     return InkWell(
//       onTap: () {
//         // Get.to(ContactUsPage(),
//         //     transition: Transition.rightToLeftWithFade,
//         //     duration: Duration(milliseconds: 600));
//       },
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.grey.shade300,
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.call,
//                   color: HexColor("000000"),
//                 ),
//               )),
//           SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Call Us:",
//                   style: TextStyle(
//                     fontSize: 15,
//                     letterSpacing: 0.5,
//                     color: HexColor("000000"),
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "Ubuntu-Regular",
//                   )),
//               SizedBox(height: 5),
//               if(contactUsModel.isEmpty)
//                 CircularProgressIndicator()
//               else Text(contactUsModel[0].data.mobile,
//                   style: TextStyle(
//                     letterSpacing: 0.3,
//                     color: HexColor("000000"),
//                     fontWeight: FontWeight.w400,
//                     fontFamily: "Ubuntu-Regular",
//                   )),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
