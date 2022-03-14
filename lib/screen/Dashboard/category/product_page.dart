import 'dart:async';

import 'package:agroon/data/provider/cartProvider.dart';
import 'package:agroon/data/provider/productprovider.dart';
import 'package:agroon/screen/Dashboard/category/product_detail_page.dart';
import 'package:agroon/screen/Dashboard/category/subProduct_page.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../bottom_navigation_bar_page.dart';

class ProductPage extends StatefulWidget {

  const ProductPage({Key key}) : super(key: key);


  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {


  bool _isLoad = false;

  _getData()async{
    setState(() {
      _isLoad = true;
    });
   await Provider.of<ProductProvider>(context, listen: false).getcategoryProductsApi();
    setState(() {
      _isLoad = false;
    });
  }


  @override
  void initState() {
    super.initState();
    _getData();
   }


  bool _isLoading = false;
  void _addCart(String productId,String priceId, var quantity)async{
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CartProvider>(context,listen: false).addCartapi(productId, priceId, quantity);
    setState(() {
      _isLoading = false;
    });
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
          title: Text("Products",
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
                      duration: Duration(milliseconds: 600));},
                icon: Icon(Icons.notifications, size: 30,color: ColorResources.darkgreen,)),
          ],
        ),
        body:Consumer<ProductProvider>(
          builder: (context, productProvider, child) =>
          _isLoad==true?Center(child: CircularProgressIndicator())
          :productProvider.categoryProductsDataList==null
              ? Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                child: Column(
                children: [
                  SizedBox(height: 50,),
                  Image.asset("assets/image/notify.png"),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Container(height: 2,color: Colors.grey,),
                  ),
                  SizedBox(height: 15,),
                  Text("Product not found",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Ubuntu-Regular",
                    ),),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Container(height: 2,color: Colors.grey,),
                  ),
                  SizedBox(height: 30,),
                  // _continueshopping(),

                ],
              ),
            ),
          )
              : SingleChildScrollView(
              child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Strings.category_Name,
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
                    itemCount: productProvider.categoryProductsDataList.length,
                    itemBuilder: (BuildContext context, index) {
                     return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () async{
                              await SharedPrefManager.savePrefString(AppConstants.PRODUCTID, productProvider.categoryProductsDataList[index].productId.toString());
                             String id= await SharedPrefManager.getPrefrenceString(AppConstants.PRODUCTID,);
                              print("shkjls"+id.toString());
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
                                         image: DecorationImage(image: NetworkImage(productProvider.categoryProductsDataList[index].priceDetails[0].priceImg[0],),),
                                        ),
                                        // child: Image.asset(imageList[index]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(productProvider.categoryProductsDataList[index].productName==null?"":productProvider.categoryProductsDataList[index].productName.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Ubuntu-Regular",
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(productProvider.categoryProductsDataList[index].shortDescription==null?"":productProvider.categoryProductsDataList[index].shortDescription.toString(),
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
                                                  Text("MRP:${productProvider.categoryProductsDataList[index].priceDetails[0].totlaAmount==null?"":productProvider.categoryProductsDataList[index].priceDetails[0].totlaAmount.toString()}",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        fontFamily:
                                                        "Ubuntu-Regular",
                                                      )),
                                                  // SizedBox(width: 10),
                                                  // Container(
                                                  //   width: 30,
                                                  //   child: Text("${productProvider.categoryProductsDataList[index].priceDetails[0].mrp==null?"":productProvider.categoryProductsDataList[index].priceDetails[0].mrp.toString()}",
                                                  //     style: TextStyle(
                                                  //       color: Colors.blue,
                                                  //       fontSize: 13,
                                                  //       fontWeight: FontWeight.w500,
                                                  //       fontFamily:
                                                  //       "Ubuntu-Regular",
                                                  //       decoration: TextDecoration
                                                  //           .lineThrough,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  _addCart((productProvider.categoryProductsDataList[index].productId),(productProvider.categoryProductsDataList[index].priceDetails[0].priceId),1);
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
          )),
        ));
  }
}
