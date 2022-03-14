// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// class MyAddress extends StatefulWidget {
//   //const MyAddressPage({Key? key}) : super(key: key);
//
//   @override
//   _MyAddressPageState createState() => _MyAddressPageState();
// }
//
// class _MyAddressPageState extends State<MyAddress> {
//
//
//   bool _isLoad = false;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   var selectedtab = 0;
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
//           backgroundColor: Colors.white,
//           title: Text("My Address",
//               style: TextStyle(
//                 fontSize: 15,
//                 letterSpacing: 1,
//                 color: HexColor("2E43FF"),
//                 fontWeight: FontWeight.bold,
//                 fontFamily: "Ubuntu-Regular",
//               )),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   _addnewaddressbutton(),
//                   SizedBox(height: 20),
//                   if(showAddressData==null )
//                     Text("")
//                   else
//                     if(showAddressData.isEmpty)
//                       Center(child: CircularProgressIndicator())
//                     else _address(),
//                   SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
//   _addnewaddressbutton() {
//     return InkWell(
//         onTap: () {
//           Get.to(AddNewAddressPage(),
//               transition: Transition.rightToLeftWithFade,
//               duration: Duration(milliseconds: 600));
//         },
//         child: Center(
//           child: Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.3),
//                     spreadRadius: 1,
//                     blurRadius: 3,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//                 color: Colors.blueGrey[50],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               height: 50,
//               width: Get.width,
//               child: Center(
//                 child: Text("Add new address",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15,
//                         letterSpacing: 0.5,
//                         fontWeight: FontWeight.w500)),
//               )),
//         ));
//   }
//
//   _address() {
//     return Container(
//       // height: MediaQuery.of(context).size.height / 3,
//       child: ListView.builder(
//           scrollDirection: Axis.vertical,
//           primary: true,
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: showAddressData.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
//                   child: InkWell(
//                     onTap: () {
//                       setState(() {
//                         selectedtab = index;
//                       });
//                     },
//                     child: Container(
//                       height: 100,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   selectedtab = index;
//                                 });
//                               },
//                               icon: selectedtab == index
//                                   ? Icon(Icons.radio_button_checked,
//                                   color: Colors.black)
//                                   : Icon(Icons.radio_button_unchecked_outlined,
//                                   color: Colors.black)),
//                           SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(showAddressData[index].address,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               SizedBox(height: 2),
//                               Text(showAddressData[index].city,
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               SizedBox(height: 2),
//                               Container(
//                                 width: Get.width / 1 - 115,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "ZIP: ${showAddressData[index].pincode}",
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         SizedBox(height: 2),
//                                         Text(
//                                           "Phone: ${showAddressData[index].phoneNumber}",
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 15.0),
//                                       child: Row(
//                                         children: [
//                                           IconButton(
//                                               onPressed: (){
//                                                 Get.to(EditAddressPage(),arguments: showAddressData[index]);
//                                               },
//                                               icon: Icon(
//                                                 Icons.edit,
//                                                 color: HexColor("2E43FF"),
//                                               )),
//                                           IconButton(
//                                               onPressed: () {
//                                                 Get.defaultDialog(
//                                                   radius: 5,
//                                                   backgroundColor: Colors.white,
//                                                   title:
//                                                   'Want to delete this address?',
//                                                   titleStyle: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.bold),
//                                                   content: Row(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                     children: [
//                                                       InkWell(
//                                                           onTap: () {
//                                                             //_trySubmit(showAddressData[0].addressId);
//                                                             setState(() {
//                                                               Provider.of<ApiManager>(context,listen: false).deleteaddressApi(showAddressData[index].addressId);
//                                                             });
//                                                           },
//
//                                                           child: Center(
//                                                             child: Container(
//                                                                 height: 45,
//                                                                 width: 100,
//                                                                 decoration: BoxDecoration(
//                                                                     color: HexColor(
//                                                                         "F8C07B"),
//                                                                     borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                         20)),
//                                                                 child: Center(
//                                                                     child: Text(
//                                                                       "Yes",
//                                                                       style: TextStyle(
//                                                                         fontSize: 14,
//                                                                         color: Colors
//                                                                             .white,
//                                                                         fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                       ),
//                                                                     ))),
//                                                           )),
//                                                       InkWell(
//                                                           onTap: () {
//                                                             Get.back();
//                                                           },
//                                                           child: Center(
//                                                             child: Container(
//                                                                 height: 45,
//                                                                 width: 100,
//                                                                 decoration: BoxDecoration(
//                                                                     color: HexColor(
//                                                                         "F8C07B"),
//                                                                     borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                         20)),
//                                                                 child: Center(
//                                                                     child: Text(
//                                                                       "No",
//                                                                       style: TextStyle(
//                                                                         fontSize: 14,
//                                                                         color: Colors
//                                                                             .white,
//                                                                         fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                       ),
//                                                                     ))),
//                                                           )),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                               icon: Icon(
//                                                 Icons.delete,
//                                                 color: HexColor("000000"),
//                                               ))
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 2,
//                   color: or.Colsgrey,
//                 ),
//               ],
//             );
//           }),
//     );
//   }
//
// }
