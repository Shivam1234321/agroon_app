import 'dart:async';

import 'package:agroon/data/provider/cartProvider.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'choose_address_page.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}


class _CheckOutPageState extends State<CheckOutPage> {

  final _formkey = GlobalKey<FormState>();

  TextEditingController _couponController = TextEditingController();

  bool _isLoad = false;



  bool isLoad = false;

  void _loadData()async{
    setState(() {
      isLoad = true;
    });
    print('jjjjjjjjjjjjjjjjjj');
    await Provider.of<CartProvider>(context, listen: false).getproductData();
    print('jjjjjjjjzzzzzzzzzzzjjjjjjjjjj');
    setState(() {
      isLoad = false;
    });
  }

  void _incrementcart(productId, priceId) async{
    setState(() {
      _isLoad = true;
    });
   await Provider.of<CartProvider>(context,listen: false).addCartapi(productId, priceId, 1);
    setState(() {
      _isLoad = false;
    });
   _loadData();
  }
  void _decrementcart(productId, priceId) async{
    setState(() {
      _isLoad = true;
    });
    await Provider.of<CartProvider>(context,listen: false).minusCartapi(productId, priceId, 1);
    setState(() {
      _isLoad = false;
    });
    _loadData();
  }


  void _deleteCart(cartId)async{
    setState(() {
      _isLoad = true;
    });
    await Provider.of<CartProvider>(context,listen: false).deleteCartapi(cartId);
    setState(() {
      _isLoad = false;
    });
    _loadData();
  }


  @override
  void initState() {
    super.initState();
    _loadData();
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
        // appBar: AppBar(
        //   leading: IconButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       icon: Icon(Icons.keyboard_arrow_left_outlined,
        //           color: ColorResources.darkgreen, size: 28)),
        //   centerTitle: true,
        //   backgroundColor: Colors.white,
        //   title: Text("Checkout",
        //       style: TextStyle(
        //         fontSize: 15,
        //         letterSpacing: 1,
        //         color: ColorResources.darkgreen,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: "Ubuntu-Regular",
        //       )),
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           // Get.to(CheckOutPage(),
        //           //     transition: Transition.rightToLeftWithFade,
        //           //     duration: Duration(milliseconds: 600));
        //         },
        //         icon: Icon(Icons.notifications, size: 30,color: ColorResources.darkgreen,)),
        //   ],
        // ),
        body: Consumer<CartProvider>(
          builder: (context,cartProvider,child)=>
          isLoad==true?
          Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  cartProvider.showCartDataList.isNull?
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
                          Text("Your Cart is Empty",
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
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                          childAspectRatio: 4,
                        ),
                        itemCount: cartProvider.showCartDataList[0].data.length,
                        itemBuilder: (BuildContext context, index) {
                         return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  // Get.to(ProductDetailPage(),
                                  //     transition: Transition.rightToLeftWithFade,
                                  //     duration: Duration(milliseconds: 600));
                                },
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
                                    child: Container(
                                      // width: Get.width - 120,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0,right: 5),
                                                child: Container(
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10)),
                                                      image: DecorationImage(image: NetworkImage(cartProvider.showCartDataList[0].data[index].image),),
                                                  ),
                                                  // child: Image.asset(Images.fruitsimage),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    child: Text(cartProvider.showCartDataList[0].data[index].productName==null?"ProductName":cartProvider.showCartDataList[0].data[index].productName.toString(),
                                                        overflow: TextOverflow.ellipsis,
                                                        softWrap: false,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          letterSpacing: 0.3,
                                                          color: ColorResources.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: "Ubuntu-Regular",
                                                        )),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(cartProvider.showCartDataList[0].data[index].category==null?"show detail":cartProvider.showCartDataList[0].data[index].category.toString(),
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        letterSpacing: 0.3,
                                                        color: ColorResources.black,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "Ubuntu-Regular",
                                                      )),
                                                  SizedBox(height: 5),
                                                  Row(
                                                    children: [
                                                      Text(cartProvider.showCartDataList[0].data[index].cartQuantity==null?"1":cartProvider.showCartDataList[0].data[index].cartQuantity.toString()+" x "+"Rs.${cartProvider.showCartDataList[0].data[index].totalAmount==null?"0.0":cartProvider.showCartDataList[0].data[index].totalAmount.toString()}",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            letterSpacing: 0.3,
                                                            color: ColorResources.black,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "Ubuntu-Regular",
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _decrementcart(cartProvider.showCartDataList[0].data[index].productId,cartProvider.showCartDataList[0].data[index].priceId);
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
                                                  SizedBox(width: 5),
                                                  Text(cartProvider.showCartDataList[0].data[index].cartQuantity==null?"0":cartProvider.showCartDataList[0].data[index].cartQuantity.toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: "Ubuntu-Regular",
                                                      )),
                                                  SizedBox(width: 5),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _incrementcart(cartProvider.showCartDataList[0].data[index].productId,cartProvider.showCartDataList[0].data[index].priceId);
                                                        // increment();
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
                                              ),
                                              IconButton(
                                                  onPressed: () {
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
                                                                  _deleteCart((cartProvider.showCartDataList[0].data[index].cartId.toString()));
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
                                                                        BorderRadius.circular(
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
                                                                        BorderRadius.circular(
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
                                                  icon: Icon(Icons.delete, color: Colors.black))
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ));
                        },
                      ),
                      // SizedBox(height: 15),
                      // _applycouponcode(),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                            width: Get.width / 1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Price details",
                                      style: TextStyle(
                                          color: ColorResources.darkgreen,
                                          fontSize: 15,
                                          letterSpacing: 0.5,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 1.2,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Price",
                                          // Text("Price (${"2"} items)",
                                          style: TextStyle(
                                              color: ColorResources.black,
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500)),
                                      Text("Rs. ${cartProvider.showCartDataList[0].actualPrice==null?"0.00":cartProvider.showCartDataList[0].actualPrice.toString()}",
                                          style: TextStyle(
                                              color: ColorResources.black,
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Delivery charges",
                                          style: TextStyle(
                                              color: ColorResources.black,
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500)),
                                      Text("Rs. 0.00",
                                          style: TextStyle(
                                              color: ColorResources.black,
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Discounts",
                                          style: TextStyle(
                                              color: ColorResources.black,
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500)),

                                      Text("Rs.${cartProvider.showCartDataList[0].totaldiscount==null?"0.0":cartProvider.showCartDataList[0].totaldiscount.toString()}",
                                          style: TextStyle(
                                              color: ColorResources.black,
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 1.2,
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total Amount",
                                          style: TextStyle(
                                              color: ColorResources.black,
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.bold)),
                                          Text("Rs. ${cartProvider.showCartDataList[0].totalamount==null?"0.00":cartProvider.showCartDataList[0].totalamount.toString()}",
                                          style: TextStyle(
                                              color: ColorResources.black,
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.bold))

                                    ],
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            )),
                      ),
                      SizedBox(height: 15),
                      _proceedbutton(),
                      SizedBox(height: 50,),
                    ],
                  ),

                  // _selectedproducts(),
                ],
              ),
            ),
          ),
        ));
  }




  _proceedbutton() {
    return InkWell(
        onTap: () {
            Get.to(ChooseAddressPage(),
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
                gradient: LinearGradient(colors: [
                  ColorResources.green,
                  ColorResources.darkgreen,
                  ]),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: 200,
              child: Center(
                child: Text("Proceed",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold)),
              )),
        ));
  }


  _continueshopping(){
    return InkWell(
        onTap: () {
          Get.back();
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
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: 200,
              child: Center(
                child: Text("Continue Shopping",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold)),
              )),
        ));
  }

}
