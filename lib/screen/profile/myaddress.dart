import 'dart:async';

import 'package:agroon/data/provider/addressProvider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/screen/checkout/add_new_address_page.dart';
import 'package:agroon/screen/checkout/confirm_order_page.dart';
import 'package:agroon/screen/checkout/edit_address_page.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class MyAddressPage extends StatefulWidget {
  const MyAddressPage({Key key}) : super(key: key);

  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {


  bool isLoad = false;

  void _loadData()async{
    setState(() {
      isLoad = true;
    });
    await Provider.of<AddressProvider>(context, listen: false).getshowAddressData();
    setState(() {
      isLoad = false;
    });
  }

  bool _isLoad = false;
  void _deleteAddress(addressId)async{
    setState(() {
      _isLoad = true;
    });
    await Provider.of<AddressProvider>(context,listen: false).deleteAddressapi(addressId);
    setState(() {
      _isLoad = false;
    });
    _loadData();

  }

  var selectedtab = 0;


  @override
  void initState() {
    super.initState();
    _loadData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined,
                  color: ColorResources.darkgreen, size: 28)),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text("My address",
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                color: ColorResources.darkgreen,
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu-Regular",
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:1)));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: ColorResources.darkgreen,
                )),
            IconButton(
                onPressed: () {
                  Get.to(NotificationPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600));
                },
                icon: Icon(Icons.notifications, size: 30,color: ColorResources.darkgreen,)),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _addnewaddressbutton(),
                  SizedBox(height: 20),
                  _address(),

                ],
              ),
            ),
          ),
        ));
  }
  _addnewaddressbutton() {
    return InkWell(
        onTap: () {
          Get.to(AddNewAddressPage(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(milliseconds: 600));
        },
        child: Center(
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: Get.width,
              child: Center(
                child: Text("Add new address",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500)),
              )),
        ));
  }

  _address() {
    return Consumer<AddressProvider>(
      builder: (context,addressProvider,child)=>
      isLoad==true?
      Center(child: CircularProgressIndicator())
          : addressProvider.getAddressDataList==null?
      Container(
          height: MediaQuery.of(context).size.height*0.5,
          child: Center(child: Text("Address not fount")))
          :Column(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height / 3,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                primary: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: addressProvider.getAddressDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedtab = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Stack(
                          children: [
                            Container(
                                width: Get.width,
                                // width: Get.width / 1 - 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0,top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(addressProvider.getAddressDataList[index].address==null?"Address":addressProvider.getAddressDataList[index].address.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(addressProvider.getAddressDataList[index].city==null?"city":addressProvider.getAddressDataList[index].city.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Container(
                                        width: Get.width / 1 - 115,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "PIN: ${addressProvider.getAddressDataList[index].pincode==null?"202093":addressProvider.getAddressDataList[index].pincode.toString()}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  "Mobile: ${addressProvider.getAddressDataList[index].mobile==null?"8674085439":addressProvider.getAddressDataList[index].mobile.toString()}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: (){
                                                        Get.to(EditAddressPage(),arguments: addressProvider.getAddressDataList[index]);
                                                      },
                                                      icon: Icon(
                                                        Icons.edit,
                                                        color: ColorResources.darkgreen,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {
                                                        Get.defaultDialog(
                                                          radius: 5,
                                                          backgroundColor: Colors.white,
                                                          title:
                                                          'You want to delete this address?',
                                                          titleStyle: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold),
                                                          content: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      _deleteAddress(addressProvider.getAddressDataList[index].addressId.toString());
                                                                    });
                                                                    Get.back();
                                                                  },
                                                                  child: Center(
                                                                    child: Container(
                                                                        height: 45,
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                            gradient: LinearGradient(colors: [
                                                                              ColorResources.green,
                                                                              ColorResources.darkgreen,
                                                                            ]),
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                20)),
                                                                        child: Center(
                                                                            child: Text(
                                                                              "Yes",
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors
                                                                                    .white,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                              ),
                                                                            ))),
                                                                  )),
                                                              InkWell(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  child: Center(
                                                                    child: Container(
                                                                        height: 45,
                                                                        width: 100,
                                                                        decoration: BoxDecoration(
                                                                            gradient: LinearGradient(colors: [
                                                                              ColorResources.green,
                                                                              ColorResources.darkgreen,
                                                                            ]),
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                20)),
                                                                        child: Center(
                                                                            child: Text(
                                                                              "No",
                                                                              style: TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors
                                                                                    .white,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                              ),
                                                                            ))),
                                                                  )),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: ColorResources.darkgreen,
                                                      ))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Positioned(
                                right: 0,
                                top: 0,
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedtab = index;
                                        print("hsdoal"+selectedtab.toString());
                                      });
                                    },
                                    child: selectedtab == index?
                                    CircleAvatar(
                                        radius: 13,
                                        backgroundColor: ColorResources.darkgreen,
                                        child: Icon(Icons.check,)
                                    )
                                        :Text("")
                                )
                            )
                          ],
                        ),
                      ),
                    );
                }),
          ),
          SizedBox(height: 30),
          // InkWell(
          //     onTap: () async{
          //       await SharedPrefManager.savePrefString(AppConstants.ADDRESSID, addressProvider.getAddressDataList[selectedtab].addressId.toString());
          //       Get.to(ConfirmOrderPage(),
          //           transition: Transition.rightToLeftWithFade,
          //           duration: Duration(milliseconds: 600));
          //     },
          //     child: Center(
          //       child: Container(
          //           decoration: BoxDecoration(
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Colors.grey.withOpacity(0.3),
          //                 spreadRadius: 1,
          //                 blurRadius: 3,
          //                 offset: Offset(0, 3),
          //               ),
          //             ],
          //             gradient: LinearGradient(colors: [
          //               ColorResources.green,
          //               ColorResources.darkgreen,
          //             ]),
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           height: 50,
          //           width: 200,
          //           child: Center(
          //             child: Text("Proceed",
          //                 style: TextStyle(
          //                     color: Colors.white,
          //                     fontSize: 15,
          //                     letterSpacing: 0.5,
          //                     fontWeight: FontWeight.bold)),
          //           )),
          //     )),
        ],
      ),
    );
  }


}
