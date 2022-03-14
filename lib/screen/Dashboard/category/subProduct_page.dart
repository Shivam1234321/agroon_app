import 'dart:async';

import 'package:agroon/screen/Dashboard/category/product_detail_page.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottom_navigation_bar_page.dart';

class SubProductPage extends StatefulWidget {

  // final String categoryId,name;
  // SubProductPage({required this.categoryId,required this.name});


  @override
  _SubProductPageState createState() => _SubProductPageState();
}

class _SubProductPageState extends State<SubProductPage> {


  @override
  void initState() {
    super.initState();
  }


  final List<String> imageList = [
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.keyboard_arrow_left_outlined,
                  color: ColorResources.darkgreen, size: 28)),
          title: Text("Sub Products",
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 0.8,
                color: ColorResources.darkgreen,
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu-Regular",
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:1)));
                  // Get.to(CheckOutPage(),
                  //     transition: Transition.rightToLeftWithFade,
                  //     duration: Duration(milliseconds: 600));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: ColorResources.darkgreen,
                )),
            IconButton(
                onPressed: () {
                  Get.to(NotificationPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600)); },
                icon: Icon(Icons.notifications, size: 30,color: ColorResources.darkgreen,)),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Strings.product_Name,
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorResources.darkgreen,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Ubuntu-Regular",
                      ),),
                    SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,

                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: imageList.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {
                                Get.to(ProductDetailPage(),
                                    transition: Transition.rightToLeftWithFade,
                                    duration: Duration(milliseconds: 600));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            //image: DecorationImage(image: NetworkImage(categoryProductdata.photo),),
                                          ),
                                          child: Image.asset(imageList[index]),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("SubProductName",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Ubuntu-Regular",
                                                )),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text("Short description",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Ubuntu-Regular",
                                                )),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("MRP:${"100"}",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          fontFamily:
                                                          "Ubuntu-Regular",
                                                        )),
                                                    // SizedBox(width: 10),
                                                    // Text("${"150"}",
                                                    //   style: TextStyle(
                                                    //     color: Colors.blue,
                                                    //     fontWeight: FontWeight.w500,
                                                    //     fontFamily:
                                                    //     "Ubuntu-Regular",
                                                    //     decoration: TextDecoration
                                                    //         .lineThrough,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: (){
                                                    //  _addcart(categoryProductdata.productId,categoryProductdata.topProductId,categoryProductdata.storeId);
                                                  },
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 3,
                                                            color:
                                                            Colors.grey.shade400,
                                                            offset: Offset(0, 3),
                                                            spreadRadius: 1,
                                                          )
                                                        ],
                                                        shape: BoxShape.circle,
                                                        color: ColorResources.darkgreen,
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                            Icons.shopping_cart,
                                                            color: Colors.white,
                                                            size: 20),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ));
                      },
                    )
                  ],
                ),
              ),
            )));
  }
}
