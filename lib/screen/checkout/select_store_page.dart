import 'dart:async';

import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectStoresPage extends StatefulWidget {
  const SelectStoresPage({Key key}) : super(key: key);

  @override
  _SelectStoresPageState createState() => _SelectStoresPageState();
}

class _SelectStoresPageState extends State<SelectStoresPage> {

  var orderdata = Get.arguments;

  PageController _pageController;

  var selectedIndex = 0;
  Set addId = new Set();

  bool isPresent(String name) {
    return addId.contains(name);}



  @override
  void initState() {
    super.initState();
  }

  bool isselected = false;
  bool isselectedone = false;
  bool isselectedtwo = false;
  bool isselectedthree = false;
  bool isselectedfour = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Select Store",
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 1,
              color: ColorResources.darkgreen,
              fontWeight: FontWeight.bold,
              fontFamily: "Ubuntu-Regular",
            )),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.keyboard_arrow_left_outlined,
                color: ColorResources.darkgreen, size: 28)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:1)));
               },
              icon: Icon(
                Icons.shopping_bag,
                color: ColorResources.darkgreen,
              )),
          IconButton(
              onPressed: () {
                // Get.to(CheckOutPage(),
                //     transition: Transition.rightToLeftWithFade,
                //     duration: Duration(milliseconds: 600));
              },
              icon: Icon(Icons.notifications, size: 30,color: ColorResources.darkgreen,)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _heading(),
              _productcards(),
              SizedBox(height: 20,),
             ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorResources.darkgreen,
        child: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.white),
        onPressed: () async{
          // Get.to(ChooseAddressPage(),arguments: orderdata,
          //     transition: Transition.rightToLeftWithFade,
          //     duration: Duration(milliseconds: 600));
        },
      ),
    );
  }

  _heading() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text("Nearest Available Stores",
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 1,
              color: ColorResources.black,
              fontWeight: FontWeight.bold,
              fontFamily: "Ubuntu-Regular",
            )));
  }

    _productcards() {
              return
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 1,
                  //   crossAxisSpacing: 0.0,
                  //   mainAxisSpacing: 0.0,
                  //   childAspectRatio: 3.8,
                  // ),
                  itemCount: 15,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                            child: Icon(Icons.store,
                                                color: Colors.black, size: 40)),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("StoreName",
                                            style: TextStyle(
                                              letterSpacing: 0.3,
                                              color: ColorResources.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Ubuntu-Regular",
                                            )),
                                        SizedBox(height: 5),
                                        Container(
                                          width: 200,
                                          child: Text("StoreAddress",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontSize: 12,
                                                letterSpacing: 0.2,
                                                color: ColorResources.black,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Ubuntu-Regular",
                                              )),
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: Colors.deepOrange,
                                                        size: 13),
                                                    Icon(Icons.star,
                                                        color: Colors.deepOrange,
                                                        size: 13),
                                                    Icon(Icons.star,
                                                        color: Colors.deepOrange,
                                                        size: 13),
                                                    Icon(Icons.star,
                                                        color: Colors.deepOrange,
                                                        size: 13),
                                                    Icon(Icons.star,
                                                        color: Colors.deepOrange,
                                                        size: 13),
                                                  ],
                                                ),
                                                SizedBox(width: 15),
                                                Text("5.0/5.0 (123)",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      letterSpacing: 0.1,
                                                      color: ColorResources.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Ubuntu-Regular",
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // SizedBox(height: 3),
                                      ],
                                    ),
                                  ],
                                )),
                            Positioned(
                              right: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 13,
                                    backgroundColor: ColorResources.darkgreen,
                                    child: Icon(Icons.check,)
                                )
                            )
                          ],
                        ),
                    );
                  },
                );
          }
        }


