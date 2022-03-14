import 'dart:async';

import 'package:agroon/data/provider/cartProvider.dart';
import 'package:agroon/data/provider/wishlistProvider.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../bottom_navigation_bar_page.dart';
class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}
class _FavoritePageState extends State<FavoritePage> {
  bool ttt = false;


  bool isLoad = false;

  void _loadData()async{
    setState(() {
      isLoad = true;
    });
    await Provider.of<WishlistProvider>(context, listen: false).getWishlistData();
    setState(() {
      isLoad = false;
    });
  }

  void _deleteWishlist(wishlistId)async{
    setState(() {
      isLoad = true;
    });
    await Provider.of<WishlistProvider>(context,listen: false).deleteWishlistapi(wishlistId);
    setState(() {
      isLoad = false;
    });
    _loadData();
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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          // appBar: argue == "categoryappbar" ? AppBar(
          //   leading: IconButton(
          //       onPressed: () {
          //         Get.back();
          //       },
          //       icon: Icon(Icons.keyboard_arrow_left_outlined,
          //           color: Colors.black, size: 28)),
          //   centerTitle: true,
          //   title: Text("Wishlist",
          //       style: TextStyle(
          //         fontSize: 15,
          //         letterSpacing: 1,
          //         color: HexColor("2E43FF"),
          //         fontWeight: FontWeight.bold,
          //         fontFamily: "Ubuntu-Regular",
          //       )),
          //   backgroundColor: Colors.white,
          //   actions: [
          //     IconButton(
          //         onPressed: () {
          //           Get.to(CheckOutPage(),
          //               transition: Transition.rightToLeftWithFade,
          //               duration: Duration(milliseconds: 600));
          //         },
          //         icon: Icon(
          //           Icons.shopping_bag,
          //           color: HexColor("2E43FF"),
          //         )),
          //   ],
          // ):null,
          body: Consumer<WishlistProvider>(
            builder: (context,wishlistProvider,child)=>
            isLoad==true?
            Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: wishlistProvider.showWishlistDataList.isNull?
              Container(
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
                      Text("Empty",
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
                  :Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _wishlisttext(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                        childAspectRatio: 3.7,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: wishlistProvider.showWishlistDataList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
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
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex:8,
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                                                child: Container(
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10)),
                                                    image: DecorationImage(image: NetworkImage(wishlistProvider.showWishlistDataList[index].image),),
                                                  ),
                                                  // child: Image.asset(Images.fruitsimage),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(wishlistProvider.showWishlistDataList[index].productName==null?"ProductName":wishlistProvider.showWishlistDataList[index].productName.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        letterSpacing: 0.3,
                                                        color: ColorResources.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: "Ubuntu-Regular",
                                                      )),
                                                  SizedBox(height: 2),
                                                  const Text("Product detail",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        letterSpacing: 0.3,
                                                        color: ColorResources.black,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "Ubuntu-Regular",
                                                      )),
                                                  Row(
                                                    children: [
                                                      Text("Rs.${wishlistProvider.showWishlistDataList[index].perProductTotalAmount==null?"0.00":wishlistProvider.showWishlistDataList[index].perProductTotalAmount.toString()}",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            letterSpacing: 0.3,
                                                            color: ColorResources.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "Ubuntu-Regular",
                                                          )),
                                                      // SizedBox(width: 15),
                                                      // Text("Rs.${wishlistProvider.showWishlistDataList[index].perProductTotalAmount==null?"0.00":wishlistProvider.showWishlistDataList[index].perProductTotalAmount.toString()}",
                                                      //     style: TextStyle(
                                                      //       fontSize: 14,
                                                      //       letterSpacing: 0.3,
                                                      //       color: Colors.blue,
                                                      //       fontWeight: FontWeight.w500,
                                                      //       fontFamily: "Ubuntu-Regular",
                                                      //       decoration:
                                                      //       TextDecoration.lineThrough,
                                                      //     )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        flex:2,
                                        child: Column(
                                          children: [
                                            IconButton(
                                                onPressed: () async{
                                                  Get.defaultDialog(
                                                    radius: 5,
                                                    backgroundColor: Colors.white,
                                                    title: 'Want to delete this product?',
                                                    titleStyle: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold),
                                                    content: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceAround,
                                                      children: [
                                                        InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                _deleteWishlist(wishlistProvider.showWishlistDataList[index].wishlistId);
                                                              });
                                                              Get.back();
                                                            },
                                                            child: Center(
                                                              child: Container(
                                                                  height: 45,
                                                                  width: 100,
                                                                  decoration: BoxDecoration(
                                                                      color: ColorResources.darkgreen,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          20)),
                                                                  child: Center(
                                                                      child: Text(
                                                                        "Yes",
                                                                        style: TextStyle(
                                                                          fontSize: 14,
                                                                          color: Colors.white,
                                                                          fontWeight:
                                                                          FontWeight.bold,
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
                                                                      color: ColorResources.darkgreen,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          20)),
                                                                  child: Center(
                                                                      child: Text(
                                                                        "No",
                                                                        style: TextStyle(
                                                                          fontSize: 14,
                                                                          color: Colors.white,
                                                                          fontWeight:
                                                                          FontWeight.bold,
                                                                        ),
                                                                      ))),
                                                            )),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                icon: Icon(Icons.delete, color: Colors.black)),
                                            SizedBox(height: 2,),
                                            InkWell(
                                              onTap: (){
                                                _addCart(wishlistProvider.showWishlistDataList[index].productId,wishlistProvider.showWishlistDataList[index].priceId,1);
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 3,
                                                      color: Colors.grey.shade400,
                                                      offset: Offset(0, 3),
                                                      spreadRadius: 1,
                                                    )
                                                  ],
                                                  shape: BoxShape.circle,
                                                  color: ColorResources.darkgreen,
                                                ),
                                                child: Center(
                                                  child: Icon(Icons.shopping_cart,
                                                      color: Colors.white, size: 20),
                                                ),),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )));
                      },
                    ),
                  ),
                    // SizedBox(height: 30,),
                    // _checkoutbutton(),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          )),
    );
  }
  _wishlisttext() {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
        child: Text("Wishlist!",
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 1,
              color: ColorResources.black,
              fontWeight: FontWeight.bold,
              fontFamily: "Ubuntu-Regular",
            )));
  }
  _checkoutbutton() {
    return InkWell(
        onTap: () {
          // Get.to(CheckOutPage(),
          //     transition: Transition.rightToLeftWithFade,
          //     duration: Duration(milliseconds: 600));
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
                gradient: LinearGradient(colors: [
                  ColorResources.green,
                  ColorResources.darkgreen,
                ]),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: 200,
              child: Center(
                child: Text("Go to checkout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold)),
              )),
        ));
  }
  _addbutton(){
    return InkWell(
        onTap: () {
        // Get.to(AllCategoryPage());
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
                gradient: LinearGradient(colors: [
                  ColorResources.green,
                  ColorResources.darkgreen,
                ]),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 30,
              width: 60,
              child: Center(
                child: Text("Add",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold)),
              )),
        ));
  }
}
// class _FavoritePageState extends State<FavoritePage> {
//
//    Timer timer;
//    Future future;
//    List<WishListData> wishListDatas = [];
//   //  Future<List<WishListData>> wishListData;
//   void _removeItem(String id) async{
//     ApiManager apiManager = new ApiManager();
//     await apiManager.removewishlistApi(id);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
//         this.setState(() {
//           future = Provider.of<ApiManager>(context, listen: false).wishlistApi();
//           future.then((value) {
//             // setState(() {
//             wishListDatas = value;
//             // });
//             // });
//           });
//         });
//       });
//     });
//     }
//
//
//       /*  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) async {
//           // this.setState(() {
//         ApiManager apiManager = new ApiManager();
//         wishListData = apiManager.wishlistApi();
//         apiManager.checkUser();
//         print("nnnnnnnnnnn");
//         });
//       // });
//
//     });
// */
//
//
//   bool favbutton = false;
//   var current_index = 2;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//
//         ///wishlist without login..
//         // body: Container(
//         //   child: Column(
//         //     children: [
//         //       Container(
//         //           height: Get.height / 2,
//         //           width: Get.width / 1,
//         //           decoration: BoxDecoration(
//         //               image: DecorationImage(
//         //                   image: AssetImage("assets/images/loginimage.png")))),
//         //       Padding(
//         //         padding: const EdgeInsets.only(top: 20),
//         //         child: InkWell(
//         //           onTap: () {
//         //             Get.to(LoginPage(),
//         //                 transition: Transition.rightToLeftWithFade,
//         //                 duration: Duration(milliseconds: 600));
//         //           },
//         //           child: CommonButton(
//         //             text: "Login First",
//         //             width: 250,
//         //             height: 50,
//         //           ),
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         ////wishlist with login
//         body: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _wishlisttext(),
//                 if(wishListDatas==null)
//                   Expanded(
//                     child: Container(
//                       height: MediaQuery.of(context).size.height,
//                       child: Center(
//                         child: Column(
//                           children: [
//                             SizedBox(height: 50,),
//                             Image.asset("assets/images/notify.png"),
//                             SizedBox(height: 30,),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 30),
//                               child: Container(height: 2,color: Colors.grey,),
//                             ),
//                             SizedBox(height: 15,),
//                             Text("Sorry! there is no any data available ",
//                               style: TextStyle(
//                                 color: Colors.blue,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: "Ubuntu-Regular",
//                               ),),
//                             SizedBox(height: 15,),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 30),
//                               child: Container(height: 2,color: Colors.grey,),
//                             ),
//                             SizedBox(height: 30,),
//                             _addbutton(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 else
//                   Column(
//                     children: [
//                       GridView.builder(
//                         physics: NeverScrollableScrollPhysics(),
//                         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 1,
//                           crossAxisSpacing: 0.0,
//                           mainAxisSpacing: 0.0,
//                           childAspectRatio: 3.7,
//                         ),
//                         shrinkWrap: true,
//                         // physics: NeverScrollableScrollPhysics(),
//                         itemCount: wishListDatas.length,
//                         itemBuilder: (context, index) {
//                           WishListData wishListdata = wishListDatas[index];
//                           return Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: InkWell(
//                                 onTap: () {
//                                   // Get.to(WishlistDetailPage(),arguments: wishListitems[index],
//                                   //     transition: Transition.rightToLeftWithFade,
//                                   //     duration: Duration(milliseconds: 600));
//                                 },
//                                 child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.3),
//                                           spreadRadius: 1,
//                                           blurRadius: 3,
//                                           offset: Offset(0, 3),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           width: 90,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.only(
//                                                 topLeft: Radius.circular(10),
//                                                 topRight: Radius.circular(10)),
//                                             image: DecorationImage(
//                                               image: NetworkImage(wishListdata.photo),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(width: 10),
//                                         Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(wishListdata.productName,
//                                                 style: TextStyle(
//                                                   fontSize: 15,
//                                                   letterSpacing: 0.3,
//                                                   color: ColorResources.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontFamily: "Ubuntu-Regular",
//                                                 )),
//                                             SizedBox(height: 2),
//                                             Text("show detail",
//                                                 style: TextStyle(
//                                                   fontSize: 13,
//                                                   letterSpacing: 0.3,
//                                                   color: ColorResources.black,
//                                                   fontWeight: FontWeight.w500,
//                                                   fontFamily: "Ubuntu-Regular",
//                                                 )),
//                                             Container(
//                                               width: Get.width - 110,
//                                               child: Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Text("Rs.${wishListdata.productOldPrice}",
//                                                           style: TextStyle(
//                                                             fontSize: 15,
//                                                             letterSpacing: 0.3,
//                                                             color: ColorResources.black,
//                                                             fontWeight: FontWeight.w500,
//                                                             fontFamily: "Ubuntu-Regular",
//                                                           )),
//                                                       SizedBox(width: 15),
//                                                       Text("Rs.${wishListdata.currentPrice}",
//                                                           style: TextStyle(
//                                                             fontSize: 14,
//                                                             letterSpacing: 0.3,
//                                                             color: Colors.blue,
//                                                             fontWeight: FontWeight.w500,
//                                                             fontFamily: "Ubuntu-Regular",
//                                                           )),
//                                                     ],
//                                                   ),
//                                                   IconButton(
//                                                       onPressed: () async{
//                                                         print("sddsds"+wishListdata.wishlistId);
//                                                         setState(() {
//                                                           Provider.of<ApiManager>(context,listen: false).removewishlistApi(wishListdata.wishlistId);
//                                                         });
//                                                         /*showDialog(
//                                                               context: context,
//                                                               builder: (BuildContext context) {
//                                                                 return AlertDialog(
//                                                                   title: Text('Welcome'),
//                                                                   content: StatefulBuilder(
//                                                                     builder: (context,setState){
//                                                                       return Column(
//                                                                         children: [
//                                                                           TextButton(
//                                                                             // style : Colors.black,
//
//                                                                             onPressed: () {
//                                                                               Navigator.pop(context);
//                                                                               // setState(() {
//                                                                               // });
//                                                                             },
//                                                                             child: Text('Yes'),
//                                                                           )
//                                                                         ],
//                                                                       );
//                                                                     },
//                                                                     // child: Text('GeeksforGeeks')),
//                                                                     // actions: [
//                                                                     //   TextButton(
//                                                                     //     // style : Colors.black,
//                                                                     //     onPressed: () {
//                                                                     //       setState(() {
//                                                                     //         ApiManager apiManager = new ApiManager();
//                                                                     //         apiManager.removewishlistApi(wishListdata.wishlistId);
//                                                                     //       });
//                                                                     //     },
//                                                                     //     child: Text('Yes'),
//                                                                     //   ),
//                                                                     //   TextButton(
//                                                                     //     // textColor: Colors.black,
//                                                                     //     onPressed: () {},
//                                                                     //     child: Text('No'),
//                                                                     //   ),
//                                                                     // ],
//                                                                   ),
//
//                                                                 );
//                                                               },
//                                                               // );
//                                                               // },
//                                                             );*/
//                                                         // Get.defaultDialog(
//                                                         //   radius: 5,
//                                                         //   backgroundColor: Colors.white,
//                                                         //   title: 'Want to delete this product?',
//                                                         //   titleStyle: TextStyle(
//                                                         //       fontSize: 15,
//                                                         //       fontWeight: FontWeight.bold),
//                                                         //   content: Row(
//                                                         //     mainAxisAlignment:
//                                                         //     MainAxisAlignment.spaceAround,
//                                                         //     children: [
//                                                         //       InkWell(
//                                                         //           onTap: () {
//                                                         //             _removeItem(wishListdata.wishlistId);
//                                                         //             Get.back();
//                                                         //             Get.snackbar("Item Deleted",
//                                                         //                 "product is deleted from this list");
//                                                         //           },
//                                                         //           child: Center(
//                                                         //             child: Container(
//                                                         //                 height: 45,
//                                                         //                 width: 100,
//                                                         //                 decoration: BoxDecoration(
//                                                         //                     color: HexColor(
//                                                         //                         "F8C07B"),
//                                                         //                     borderRadius:
//                                                         //                     BorderRadius
//                                                         //                         .circular(
//                                                         //                         20)),
//                                                         //                 child: Center(
//                                                         //                     child: Text(
//                                                         //                       "Yes",
//                                                         //                       style: TextStyle(
//                                                         //                         fontSize: 14,
//                                                         //                         color: Colors.white,
//                                                         //                         fontWeight:
//                                                         //                         FontWeight.bold,
//                                                         //                       ),
//                                                         //                     ))),
//                                                         //           )),
//                                                         //       InkWell(
//                                                         //           onTap: () {
//                                                         //             Get.back();
//                                                         //           },
//                                                         //           child: Center(
//                                                         //             child: Container(
//                                                         //                 height: 45,
//                                                         //                 width: 100,
//                                                         //                 decoration: BoxDecoration(
//                                                         //                     color: HexColor(
//                                                         //                         "F8C07B"),
//                                                         //                     borderRadius:
//                                                         //                     BorderRadius
//                                                         //                         .circular(
//                                                         //                         20)),
//                                                         //                 child: Center(
//                                                         //                     child: Text(
//                                                         //                       "No",
//                                                         //                       style: TextStyle(
//                                                         //                         fontSize: 14,
//                                                         //                         color: Colors.white,
//                                                         //                         fontWeight:
//                                                         //                         FontWeight.bold,
//                                                         //                       ),
//                                                         //                     ))),
//                                                         //           )),
//                                                         //     ],
//                                                         //   ),
//                                                         // );
//                                                       },
//                                                       icon:
//                                                       Icon(Icons.delete, color: Colors.black))
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )),
//                               ));
//                         },
//                       ),
//                       SizedBox(height: 30,),
//                       _checkoutbutton(),
//                     ],
//                   ),
//
//                 SizedBox(height: 50,),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _wishlisttext() {
//     return Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Text("Wishlist!",
//             style: TextStyle(
//               fontSize: 15,
//               letterSpacing: 1,
//               color: ColorResources.black,
//               fontWeight: FontWeight.bold,
//               fontFamily: "Ubuntu-Regular",
//             )));
//   }
//
//   /*_productcards() {
//     return   FutureBuilder(
//         future: wishListData,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//             case ConnectionState.active:
//             case ConnectionState.waiting:
//               return Center(child: CircularProgressIndicator(),);
//             case ConnectionState.none:
//               var wishListitems = snapshot.data;
//               return wishListitems == null ? Container(
//                 height: MediaQuery.of(context).size.height,
//                 child:  Center(
//                   child: Column(
//                     children: [
//                       SizedBox(height: 50,),
//                       Image.asset("assets/images/notify.png"),
//                       SizedBox(height: 30,),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: Container(height: 2,color: Colors.grey,),
//                       ),
//                       SizedBox(height: 15,),
//                       Text("Sorry! there is no any data available ",
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: "Ubuntu-Regular",
//                         ),),
//                       SizedBox(height: 15,),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: Container(height: 2,color: Colors.grey,),
//                       ),
//                       SizedBox(height: 30,),
//                       _addbutton(),
//
//                     ],
//                   ),
//                 ),
//               )
//                   :GridView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   crossAxisSpacing: 0.0,
//                   mainAxisSpacing: 0.0,
//                   childAspectRatio: 3.7,
//                 ),
//                 itemCount: wishListitems.length,
//                 itemBuilder: (BuildContext context, index) {
//                   WishListData wishListdata = wishListitems[index];
//
//                   return Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: InkWell(
//                         onTap: () {
//                           Get.to(WishlistDetailPage(),arguments: wishListitems[index],
//                               transition: Transition.rightToLeftWithFade,
//                               duration: Duration(milliseconds: 600));
//                         },
//                         child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   spreadRadius: 1,
//                                   blurRadius: 3,
//                                   offset: Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: 90,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(10),
//                                         topRight: Radius.circular(10)),
//                                     image: DecorationImage(
//                                       image: NetworkImage(wishListdata.photo),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(wishListdata.productName,
//                                         style: TextStyle(
//                                           fontSize: 15,
//                                           letterSpacing: 0.3,
//                                           color: ColorResources.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "Ubuntu-Regular",
//                                         )),
//                                     SizedBox(height: 2),
//                                     Text("show detail",
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           letterSpacing: 0.3,
//                                           color: ColorResources.black,
//                                           fontWeight: FontWeight.w500,
//                                           fontFamily: "Ubuntu-Regular",
//                                         )),
//                                     Container(
//                                       width: Get.width - 110,
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text("Rs.${wishListdata.productOldPrice}",
//                                                   style: TextStyle(
//                                                     fontSize: 15,
//                                                     letterSpacing: 0.3,
//                                                     color: ColorResources.black,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontFamily: "Ubuntu-Regular",
//                                                   )),
//                                               SizedBox(width: 15),
//                                               Text("Rs.${wishListdata.currentPrice}",
//                                                   style: TextStyle(
//                                                     fontSize: 14,
//                                                     letterSpacing: 0.3,
//                                                     color: Colors.blue,
//                                                     fontWeight: FontWeight.w500,
//                                                     fontFamily: "Ubuntu-Regular",
//                                                   )),
//                                             ],
//                                           ),
//                                           IconButton(
//                                               onPressed: () {
//                                                 Get.defaultDialog(
//                                                   radius: 5,
//                                                   backgroundColor: Colors.white,
//                                                   title: 'Want to delete this product?',
//                                                   titleStyle: TextStyle(
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.bold),
//                                                   content: Row(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment.spaceAround,
//                                                     children: [
//                                                       InkWell(
//                                                           onTap: () {
//                                                             setState(() {
//                                                               _removeItem(wishListdata.wishlistId);
//                                                             });
//
//                                                             Get.back();
//                                                             Get.snackbar("Item Deleted",
//                                                                 "product is deleted from this list");
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
//                                                                       "Yes",
//                                                                       style: TextStyle(
//                                                                         fontSize: 14,
//                                                                         color: Colors.white,
//                                                                         fontWeight:
//                                                                         FontWeight.bold,
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
//                                                                         color: Colors.white,
//                                                                         fontWeight:
//                                                                         FontWeight.bold,
//                                                                       ),
//                                                                     ))),
//                                                           )),
//                                                     ],
//                                                   ),
//                                                 );
//                                               },
//                                               icon:
//                                               Icon(Icons.delete, color: Colors.black))
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             )),
//                       ));
//                 },
//               );
//           }
//         }
//     );
//   }*/
//
//   _checkoutbutton() {
//     return InkWell(
//       onTap: () {
//         Get.to(CheckOutPage(),
//             transition: Transition.rightToLeftWithFade,
//             duration: Duration(milliseconds: 600));
//       },
//       child: Center(
//         child: Container(
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 1,
//                   blurRadius: 3,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             height: 50,
//             width: 200,
//             child: Center(
//               child: Text("Go to checkout",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15,
//                       letterSpacing: 0.5,
//                       fontWeight: FontWeight.bold)),
//             )),
//       ),
//     );
//   }
//
//   _addbutton(){
//     return InkWell(
//         onTap: () {
//           Get.to(AllCategoryPage());
//
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
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               height: 50,
//               width: 200,
//               child: Center(
//                 child: Text("Add",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         letterSpacing: 0.5,
//                         fontWeight: FontWeight.bold)),
//               )),
//         ));
//   }
// }
