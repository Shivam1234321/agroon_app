import 'package:agroon/data/provider/cartProvider.dart';
import 'package:agroon/data/provider/productprovider.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../bottom_navigation_bar_page.dart';

class ProductDetailPage extends StatefulWidget {

  const ProductDetailPage({Key key}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  bool isLoad = false;

  void _loadData()async{
    setState(() {
      isLoad = true;
    });
    print('jjjjjjjjjjjjjjjjjj');
    await Provider.of<ProductProvider>(context, listen: false).getsingleProductData();
    print('jjjjjjjjzzzzzzzzzzzjjjjjjjjjj');
    setState(() {
      isLoad = false;
    });
  }

  bool _isLoading = false;
  void _addCart(String productId,String priceId)async{
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CartProvider>(context,listen: false).addCartapi(productId, priceId, cart_item);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();

  }

  bool isExpand = false;
  int cart_item = 1;
  void increment() {
    setState(() {
      cart_item++;
    });
  }

  void decrement() {
    setState(() {
      cart_item--;
    });
  }



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
        title: Text("Product Detail",
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
      body: Consumer<ProductProvider>(
        builder: (context,productProvider,child)=>
        isLoad==true?
        Center(child: CircularProgressIndicator())
        :productProvider.singleProductDataList==null?
            Text("")
        : SingleChildScrollView(
          child: Container(
            child:Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(image: NetworkImage(productProvider.singleProductDataList[0].priceDetails[0].priceImg[0]),),
                  ),
                  // child: Image.asset(Images.fruitsimage,),
                  height: Get.height / 2,
                  width: Get.width,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(productProvider.singleProductDataList[0].productName==null?"":productProvider.singleProductDataList[0].productName.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Ubuntu-Regular",
                              )),
                          InkWell(
                            onTap: () {
                             // _trySubmit();
                              // Get.snackbar("Please Login",
                              //     "Then you can add item in to Cart.");
                              setState(() {
                                isExpand = isExpand ? false : true;
                              });
                            },
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: isExpand
                                          ? Colors.red.shade300
                                          : Colors.grey.shade400,
                                      offset: Offset(0, 3),
                                      spreadRadius: 1,
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  color: isExpand
                                      ? Colors.white
                                      // : ColorResources.darkgreen,
                                      : isExpand == false ? Colors.red:Colors.white,

                                ),
                                child: Center(
                                  child: isExpand
                                      ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                      : Icon(
                                    Icons.favorite,
                                    color: isExpand == false ? Colors.white:Colors.red,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(productProvider.singleProductDataList[0].categoryName==null?"":productProvider.singleProductDataList[0].categoryName.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Ubuntu-Regular",
                              )),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: ColorResources.darkgreen,
                              ),
                              Text("(${productProvider.singleProductDataList[0].viewCount==null?"":productProvider.singleProductDataList[0].viewCount.toString()} Views)",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: ColorResources.darkgreen,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Ubuntu-Regular",
                                  )),
                            ],
                          )
                        ],
                      ),
                      Text(productProvider.singleProductDataList[0].subCategoryName==null?"":productProvider.singleProductDataList[0].subCategoryName.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Ubuntu-Regular",
                          )),
                      Text(productProvider.singleProductDataList[0].brandName==null?"":productProvider.singleProductDataList[0].brandName.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Ubuntu-Regular",
                          )),
                      Text(productProvider.singleProductDataList[0].shortDescription==null?"":productProvider.singleProductDataList[0].shortDescription.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            // fontWeight: FontWeight.w600,
                            fontFamily: "Ubuntu-Regular",
                          )),

                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text("MRP: ${productProvider.singleProductDataList[0].priceDetails[0].totlaAmount==null?"":productProvider.singleProductDataList[0].priceDetails[0].totlaAmount}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Ubuntu-Regular",
                              )),
                          // SizedBox(width: 20),
                          // Text(
                          //   "Rs.${productProvider.singleProductDataList[0].priceDetails[0].offerprice==null?"":productProvider.singleProductDataList[0].priceDetails[0].offerprice}",
                          //   style: TextStyle(
                          //     color: Colors.blue,
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.bold,
                          //     fontFamily: "Ubuntu-Regular",
                          //     decoration: TextDecoration.lineThrough,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if(cart_item >=2)
                                decrement();
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                color: ColorResources.decriment,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: Icon(Icons.remove_circle_outlined,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(cart_item.toString(),
                              //productDetail.cartProduct.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Ubuntu-Regular",
                              )),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if(cart_item >=1)
                                  increment();
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                color: ColorResources.darkgreen,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: Icon(Icons.add_circle_outlined,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),

          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Consumer<ProductProvider>(
          builder: (context,productProvider,child)=>
          isLoad==true?
          Text("")
              : Container(
              height: 60,
              width: Get.width,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      _addCart(productProvider.singleProductDataList[0].productId,productProvider.singleProductDataList[0].priceDetails[0].priceId);
                      Get.snackbar("Product Added",
                          "This item is successsfully added in to cart");
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: ColorResources.black,
                        ),
                        height: 60,
                        width: Get.width / 2,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.shopping_bag,
                                      color: Colors.white)),
                              Text("Add to Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:1)));
                      // Get.to(CheckOutPage(),
                      //     transition: Transition.rightToLeftWithFade,
                      //     duration: Duration(milliseconds: 600));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: ColorResources.darkgreen,
                        ),
                        height: 60,
                        width: Get.width / 2,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.shopping_cart_outlined,
                                      color: Colors.white)),
                              Text("Go to Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
