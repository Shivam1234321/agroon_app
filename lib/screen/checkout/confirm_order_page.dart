import 'dart:async';

import 'package:agroon/data/provider/cartProvider.dart';
import 'package:agroon/data/provider/webViewProvider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/screen/checkout/coupon_page.dart';
import 'package:agroon/screen/checkout/order_successful_cashond_page.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'upi_payment_page.dart';
class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({Key key}) : super(key: key);

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {



  final _formKey = GlobalKey<FormState>();
  final _price = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  TextEditingController _couponController = TextEditingController();

  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  bool isExpand = false;
  bool _isLoad = false;

  bool isLoad = false;

  bool no = false;
  bool yes = false;

  void _loadData()async{
    setState(() {
      isLoad = true;
    });
    print('jjjjjjjjjjjjjjjjjj');
    await Provider.of<CartProvider>(context, listen: false).getproductData();
    print('jjjjjjjjzzzzzzzzzzzjjjjjjjjjj');
   await Provider.of<WebViewProvider>(context, listen: false).getPartialDeductionAmountApi();
    setState(() {
      isLoad = false;
    });
  }

  void _trySubmit()async{
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoad = true;
    });
    await Provider.of<WebViewProvider>(context, listen: false).checkCouponApi(_couponController.text);

    setState(() {
      _isLoad= false;
    });

  }

  bool _isLoading = false;


   _proceed(String partialpaymentamount,String paymentType,String totalAmount,String coupondiscountAmount)async{
     if(yes == true){
       setState(() {
         _isLoading = true;
       });
       await Provider.of<WebViewProvider>(context, listen: false).orderapi(_couponController.text.isNull ? "" : _couponController.text, partialpaymentamount, paymentType, totalAmount, coupondiscountAmount);
       setState(() {
         _isLoading = false;
       });
       openCheckout(totalAmount.toString());
     }else
       {
         if(_formKey.currentState.validate()) {
           setState(() {
             _isLoading = true;
           });
           await Provider.of<WebViewProvider>(context, listen: false).orderapi(_couponController.text.isNull ? "" : _couponController.text, partialpaymentamount, paymentType, totalAmount, coupondiscountAmount);
           setState(() {
             _isLoading = false;
           });
           openCheckout(totalAmount.toString());
         }
       }

     }

  _proceed1(String partialpaymentamount,String paymentType,String totalAmount,String coupondiscountAmount)async{
    if(yes == true){
      setState(() {
        _isLoading = true;
      });
      await Provider.of<WebViewProvider>(context, listen: false).orderapi(_couponController.text.isNull ? "" : _couponController.text, partialpaymentamount, paymentType, totalAmount, coupondiscountAmount);
      setState(() {
        _isLoading = false;
      });
      double tm = double.parse(totalAmount);
      double  pri = double.parse(_price.text.isEmpty?"0":_price.text);
      Get.to(UPIPAYMENTPage(),arguments:pri==0.0?(tm):pri,
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 400),
      );
    }else
    {
      if(_formKey.currentState.validate()) {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<WebViewProvider>(context, listen: false).orderapi(_couponController.text.isNull ? "" : _couponController.text, partialpaymentamount, paymentType, totalAmount, coupondiscountAmount);
        setState(() {
          _isLoading = false;
        });
        double tm = double.parse(totalAmount);
        double  pri = double.parse(_price.text.isEmpty?"0":_price.text);
        Get.to(UPIPAYMENTPage(),arguments:pri==0.0?(tm):pri,
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 400),
        );
      }
    }

  }

  @override
  void initState() {
    super.initState();
    _loadData();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(var totalAmount) async {
    print("slubso"+totalAmount);
    double tm = double.parse(totalAmount);
    double  pri = double.parse(_price.text.isEmpty?"0":_price.text);
    print("price: "+pri.toString());
    var options = {
      'key': 'rzp_test_uIpMJN4O0g3Zdq',
      'amount': pri==0.0?(tm*100):pri*100,
      'name': 'Agroon',
      'description': "",
      'prefill': {'contact': '8650965058', 'email': 'agroon@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    var paymentid = response.paymentId;

    print("pspspspsp"+paymentid.toString());
    Get.defaultDialog(
      radius: 5,
      backgroundColor: Colors.white,
      title: 'Your payment Successfull.,'
          'completed',
      titleStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold),
      content: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () async{
              await  SharedPrefManager.savePrefString(AppConstants.PAYMENTID, paymentid.toString());
                setState(() {
                  Get.offAll(OrderSuccessfulCashOnDPage(),
                    transition: Transition.zoom,
                    curve: Curves.bounceOut,
                    duration: Duration(milliseconds: 600),);
                });
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
                          "OK",
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
    // Get.offAll(OrderSuccessfulPage(),arguments: [checkoutModel[0].data,paymentid],
    //   transition: Transition.zoom,
    //   curve: Curves.bounceOut,
    //   duration: Duration(milliseconds: 600),
    // );
    Fluttertoast.showToast(
        msg: "Your payment successfully completed ", toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
    print("eeee:"+response.code.toString()+response.message);
    _price.text="0";
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, toastLength: Toast.LENGTH_SHORT);
  }

  var selectedtab = 0;
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
          title: Text("Confirm Order",
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                color: ColorResources.darkgreen,
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu-Regular",
              )),
          actions: [
            // IconButton(
            //     onPressed: () {
            //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:1)));
            //     },
            //     icon: Icon(
            //       Icons.shopping_cart,
            //       color: ColorResources.darkgreen,
            //     )),
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
            child: Consumer<CartProvider>(
              builder: (context,cartProvider,child)=>
              isLoad==true?
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(child: CircularProgressIndicator()),
              )
               : cartProvider.showCartDataList==null?
                Text("")
                  : Container(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headings(),
                  SizedBox(height: 30),
                  _applycouponcode(),
                  SizedBox(height: 30),
                  _pricedetail(),
                  SizedBox(height: 30),
                  _paymentmethod(),
                  SizedBox(height: 70),
                  Consumer<WebViewProvider>(
                    builder: (context,webViewProvider,child)=>
                    webViewProvider.getPartialDeductionAmountModelList==null?
                    Text("")
                        : InkWell(
                        onTap: () async{
                         // await SharedPrefManager.savePrefString(AppConstants.ADDRESSID, addressProvider.getAddressDataList[selectedtab].addressId.toString());
                         // _price.text=="";
                       await  Get.defaultDialog(
                           radius: 10,
                           contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 30.0),
                           titlePadding: EdgeInsets.only(top: 20.0),
                           backgroundColor: Colors.white,
                           title: "Payment Mode",
                           titleStyle: TextStyle(
                               fontSize: 15,
                               fontWeight: FontWeight.bold),
                           content: Row(
                             mainAxisAlignment:
                             MainAxisAlignment.spaceAround,
                             children: [
                               Expanded(
                                      flex: 1,
                                     child: InkWell(
                                     onTap: () async{
                                       await _proceed(_price.text.isEmpty ? "0" :_price.text,_price.text.isEmpty ? "Full" : "Partial",cartProvider.showCartDataList[0].totalamount.toString(),webViewProvider.checkCouponModelList.isNull?"":webViewProvider.checkCouponModelList[0].data.totalDiscountAmount.toString());
                                       // SharedPrefManager.clearPrefs();
                                       // Get.back();
                                       // Get.snackbar("Logout",
                                       //     "Successfully");
                                     },
                                     child: Center(
                                       child: Container(
                                           decoration: BoxDecoration(
                                               gradient: LinearGradient(colors: [
                                                 ColorResources.green,
                                                 ColorResources.darkgreen,
                                               ]),
                                               borderRadius:
                                               BorderRadius
                                                   .circular(
                                                   10)),
                                           child: Padding(
                                             padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 10.0),
                                             child: Center(
                                                 child: Text(
                                                   "Online Payment",
                                                   style: TextStyle(
                                                     fontSize: 12,
                                                     color: Colors.white,
                                                     fontWeight:
                                                     FontWeight.bold,
                                                   ),
                                                 )),
                                           )),
                                     )),
                                   ),
                               SizedBox(width: 10,),
                               Expanded(
                                 flex: 1,
                                 child: InkWell(
                                     onTap: () async{
                                       await _proceed1(_price.text.isEmpty ? "0" :_price.text,_price.text.isEmpty ? "Full" : "Partial",cartProvider.showCartDataList[0].totalamount.toString(),webViewProvider.checkCouponModelList.isNull?"":webViewProvider.checkCouponModelList[0].data.totalDiscountAmount.toString());

                                     },
                                     child: Center(
                                       child: Container(
                                           decoration: BoxDecoration(
                                               gradient: LinearGradient(colors: [
                                                 ColorResources.green,
                                                 ColorResources.darkgreen,

                                               ]),
                                               borderRadius:
                                               BorderRadius
                                                   .circular(
                                                   10)),
                                           child: Padding(
                                             padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 5.0),
                                             child: Center(
                                                 child: Text(
                                                   "UPI Payment",
                                                   style: TextStyle(
                                                     fontSize: 12,
                                                     color: Colors.white,
                                                     fontWeight:
                                                     FontWeight.bold,
                                                   ),
                                                 )),
                                           )),
                                     )),
                               ),
                             ],
                           ),
                         );
                        },
                        child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                gradient: const LinearGradient(colors: [
                                  ColorResources.green,
                                  ColorResources.darkgreen,
                                ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 50,
                              width: 200,
                              child: const Center(
                                child: Text("Proceed",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.bold)),
                              )),
                        )),
                  ),
                  SizedBox(height: 30),
                ],
              ),
          ),
        ),
            )));
  }

  _headings() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Confirm Your Order",
          style: TextStyle(
            fontSize: 20,
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
            fontFamily: "Ubuntu-Regular",
          )),
      SizedBox(
        height: 5,
      ),
      Text("please confirm your payment detail !",
          style: TextStyle(
            color: Colors.green.shade800,
            fontWeight: FontWeight.w500,
            fontFamily: "Ubuntu-Regular",
          )),
    ]);
  }

  _applycouponcode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          setState(() {
            isExpand = isExpand ? false : true;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                    color: isExpand ? Colors.white : ColorResources.darkgreen,
                    width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.ac_unit,
                              color: ColorResources.darkgreen,
                            )),
                        Text(
                          "Apply coupon code",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          // Get.to(CouponPage(),
                          //     transition: Transition.rightToLeftWithFade,
                          //     duration: Duration(milliseconds: 600));
                          // setState(() {
                          //   isExpand = isExpand ? false : true;
                          // });
                        },
                        child: Container(
                            child: isExpand
                                ? Container()
                                : IconButton(
                                onPressed: () {
                                  Get.to(CouponPage(),
                                      transition: Transition.rightToLeftWithFade,
                                      duration: Duration(milliseconds: 600));
                                  // setState(() {
                                  //   isExpand = isExpand ? false : true;
                                  // });
                                },
                                icon: Icon(
                                    Icons.keyboard_arrow_right_outlined,
                                    size: 30))))
                  ],
                ),
              ),
            ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Visibility(
                    visible: isExpand,
                    child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 50,
                                width: Get.width / 1 - 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: ColorResources.darkgreen, width: 1.5),
                                ),
                                child: TextFormField(
                                    controller: _couponController,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 1),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.circular(10)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.grey, width: 1),
                                            borderRadius: BorderRadius.circular(10)),
                                        border: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.yellow, width: 1),
                                            borderRadius:
                                            BorderRadius.circular(10))))),

                            if(_isLoad)
                              Center(child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: CircularProgressIndicator(),
                              ))
                            else InkWell(
                              onTap: (){
                                _trySubmit();
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: ColorResources.darkgreen,
                                ),
                                child: Center(
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// run ///////////////////////
  _pricedetail() {
    return Consumer<CartProvider>(
      builder: (context,cartProvider,child)=>
      isLoad==true?
      Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                        Text("Rs. ${cartProvider.showCartDataList[0].totalamount==null?"0.00":cartProvider.showCartDataList[0].totalamount.toString()}",
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

                            Consumer<WebViewProvider>(
                              builder: (context,webViewProvider,child)=>
                              webViewProvider.checkCouponModelList==null?
                              Text("Rs.0.00",
                                  style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold))
                                  : Text("Rs.${webViewProvider.checkCouponModelList[0].data.totalDiscountAmount==null?"0.0":webViewProvider.checkCouponModelList[0].data.totalDiscountAmount.toString()}",
                                  style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500)),
                            ),
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
                        Consumer<WebViewProvider>(
                          builder: (context,webViewProvider,child)=>
                           Text("Rs. ${(cartProvider.showCartDataList[0].totalamount)-(webViewProvider.checkCouponModelList==null?0:webViewProvider.checkCouponModelList[0].data.totalDiscountAmount)}",
                              style: TextStyle(
                                  color: ColorResources.black,
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold)),
                        )

                      ],
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              )),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: Container(
    //       width: Get.width / 1,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //         color: Colors.white,
    //         border: Border.all(color: Colors.black, width: 1.5),
    //       ),
    //       child: Padding(
    //         padding: const EdgeInsets.all(10.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text("Price details",
    //                 style: TextStyle(
    //                     color: ColorResources.darkgreen,
    //                     fontSize: 15,
    //                     letterSpacing: 0.5,
    //                     fontWeight: FontWeight.bold)),
    //             SizedBox(height: 5),
    //             Divider(
    //               color: Colors.black,
    //               thickness: 1.2,
    //             ),
    //             SizedBox(height: 10),
    //             // ignore: unnecessary_null_comparison
    //             // if(totalprice==null)
    //             //   Text("Price (items)",
    //             //       style: TextStyle(
    //             //           color: HexColor("000000"),
    //             //           fontSize: 15,
    //             //           letterSpacing: 0.5,
    //             //           fontWeight: FontWeight.w500))
    //             // else
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   // if(cartitems.isEmpty)
    //                   //   Text("")
    //                   // else
    //                       Text("Price (1 items)",
    //                       style: TextStyle(
    //                           color: HexColor("000000"),
    //                           fontSize: 15,
    //                           letterSpacing: 0.5,
    //                           fontWeight: FontWeight.w500)),
    //                   // if(totalprice.isEmpty)
    //                   //   Text("")
    //                   // else
    //                     Text("Rs. $totalprice.00",
    //                       style: TextStyle(
    //                           color: HexColor("000000"),
    //                           fontSize: 15,
    //                           letterSpacing: 0.5,
    //                           fontWeight: FontWeight.w500)),
    //                 ],
    //               ),
    //             SizedBox(height: 10),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text("Delivery charges",
    //                     style: TextStyle(
    //                         color: HexColor("000000"),
    //                         fontSize: 15,
    //                         letterSpacing: 0.5,
    //                         fontWeight: FontWeight.w500)),
    //                 Text("Rs. 00.00",
    //                     style: TextStyle(
    //                         color: HexColor("000000"),
    //                         fontSize: 15,
    //                         letterSpacing: 0.5,
    //                         fontWeight: FontWeight.w500)),
    //               ],
    //             ),
    //             SizedBox(height: 10),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text("Discounts",
    //                     style: TextStyle(
    //                         color: HexColor("000000"),
    //                         fontSize: 15,
    //                         letterSpacing: 0.5,
    //                         fontWeight: FontWeight.w500)),
    //                 //if(checkCouponModel.isEmpty)
    //                //   Text("Rs.0.00")
    //                 //else
    //                   Text("$discountprice",
    //                       style: TextStyle(
    //                           color: HexColor("000000"),
    //                           fontSize: 15,
    //                           letterSpacing: 0.5,
    //                           fontWeight: FontWeight.w500)),
    //               ],
    //             ),
    //             SizedBox(height: 10),
    //             Divider(
    //               color: Colors.black,
    //               thickness: 1.2,
    //             ),
    //             SizedBox(height: 5),
    //             // if(cartCountModel==null)
    //             //  Text("Total Amount",
    //             //   style: TextStyle(
    //             //   color: HexColor("000000"),
    //             //   fontSize: 15,
    //             //   letterSpacing: 0.5,
    //             //   fontWeight: FontWeight.bold))
    //             // else
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Text("Total Amount",
    //                     style: TextStyle(
    //                         color: HexColor("000000"),
    //                         fontSize: 15,
    //                         letterSpacing: 0.5,
    //                         fontWeight: FontWeight.bold)),
    //                 // if(dtotalprice.isEmpty)
    //                 //     Text("Rs. 0.00",
    //                 //         style: TextStyle(
    //                 //             color: HexColor("000000"),
    //                 //             fontSize: 15,
    //                 //             letterSpacing: 0.5,
    //                 //             fontWeight: FontWeight.bold))
    //                 //   else
    //                     Text(dtotalprice == "" ?"Rs.$totalprice": "Rs. $dtotalprice",
    //                         style: TextStyle(
    //                             color: HexColor("000000"),
    //                             fontSize: 15,
    //                             letterSpacing: 0.5,
    //                             fontWeight: FontWeight.bold)),
    //               ],
    //             ),
    //             SizedBox(height: 10)
    //           ],
    //         ),
    //       )),
    // );
  }
  // _delieryaddress() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(" Delivery Address",
  //           style: TextStyle(
  //             fontSize: 15,
  //             color: Colors.green.shade800,
  //             fontWeight: FontWeight.bold,
  //             fontFamily: "Ubuntu-Regular",
  //           )),
  //       SizedBox(
  //         height: 15,
  //       ),
  //       Container(
  //         width: Get.width / 1,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           color: Colors.orange[50],
  //           border: Border.all(color: HexColor("F8C07B"), width: 1.5),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(10.0),
  //           child: InkWell(
  //             onTap: () {},
  //             child: Container(
  //                 height: 100,
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     SizedBox(width: 10),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                        if(showAddressData==null)
  //                          Text("")
  //                         else Text(
  //                           showAddressData.address,
  //                           style: TextStyle(
  //                             color: Colors.black,
  //                           ),
  //                         ),
  //                         SizedBox(height: 2),
  //                         Text(
  //                           showAddressData.city,
  //                           style: TextStyle(
  //                             color: Colors.black,
  //                           ),
  //                         ),
  //                         SizedBox(height: 2),
  //                         Container(
  //                           width: Get.width / 1 - 80,
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(
  //                                     "ZIP: ${showAddressData.pincode}",
  //                                     style: TextStyle(
  //                                       color: Colors.black,
  //                                     ),
  //                                   ),
  //                                   SizedBox(height: 2),
  //                                   Text(
  //                                     "Phone: ${showAddressData.phoneNumber}",
  //                                     style: TextStyle(
  //                                       color: Colors.black,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   IconButton(
  //                                       onPressed: () {
  //                                         Get.back();
  //                                         // Get.to(ChooseAddressPage(),
  //                                         //     transition: Transition.rightToLeftWithFade,
  //                                         //     duration: Duration(milliseconds: 600));
  //                                       },
  //                                       icon: Icon(
  //                                         Icons.edit,
  //                                         color: HexColor("2E43FF"),
  //                                       )),
  //
  //                                 ],
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 )),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  _paymentmethod() {
    return Consumer<WebViewProvider>(
        builder: (context,webViewProvider,child)=>
        webViewProvider.getPartialDeductionAmountModelList==null?
            const Text("")
    :Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Method ?",
            style: TextStyle(
              fontSize: 15,
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
              fontFamily: "Ubuntu-Regular",
            )),
        SizedBox(
          height: 5,
        ),
        webViewProvider.getPartialDeductionAmountModelList[0].data.amount.toString()=="0"?
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                        color:  ColorResources.darkgreen,
                        width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.radio_button_checked,
                            color: Colors.black),
                        SizedBox(width: 10),
                        Text("Full Payment",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Ubuntu-Regular",
                            ))
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Column(
                children: [
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                            color:  ColorResources.darkgreen,
                            width: 1.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            Icon(Icons.radio_button_off,
                                color: Colors.black),
                            SizedBox(width: 10),
                            Text("Partial Payment",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Ubuntu-Regular",
                                ))
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        )
        :Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: InkWell(
                onTap: (){
                  setState(() {
                    no = false;
                    yes= true;
                  });
                },
                child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                          color:  ColorResources.darkgreen,
                          width: 1.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          yes == true?
                          Icon(Icons.radio_button_checked,size: 25,color: Colors.black,)
                              : Icon(Icons.radio_button_off,size: 25,color: Colors.black,),
                          SizedBox(width: 10),
                          Text("Full Payment",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Ubuntu-Regular",
                              ))
                        ],
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        yes= false;
                        no = true;
                      });
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              color:  ColorResources.darkgreen,
                              width: 1.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              no == true?
                              Icon(Icons.radio_button_checked,size: 25,color:Colors.black,)
                                  : Icon(Icons.radio_button_off,size: 25,color: Colors.black,),
                              SizedBox(width: 10),
                              Text("Partial Payment",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Ubuntu-Regular",
                                  ))
                            ],
                          ),
                        )),
                  ),
                  SizedBox(height: 10),
                  no == true?
                  Form(
                    key: _formKey,
                    child: Consumer<WebViewProvider>(
                      builder: (context,webViewProvider,child)=>
                       Column(
                        children: [
                          Consumer<CartProvider>(
                            builder: (context,cartProvider,child)=>
                                Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                    color:  ColorResources.darkgreen,
                                    width: 1.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10, left: 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  maxLines: 1,
                                  controller: _price,
                                  validator: (value) {
                                    var txtp = double.tryParse(_price.text);
                                    var per = (double.tryParse(webViewProvider.getPartialDeductionAmountModelList[0].data.amount)*(double.tryParse(cartProvider.showCartDataList[0].totalamount.toString())))/100;
                                   print("txtp"+txtp.toString());
                                   print("per"+per.toString());
                                    if (value.isEmpty) {
                                      return "Please enter price";
                                    } else if (txtp <= per || txtp>=cartProvider.showCartDataList[0].totalamount) {
                                      return "Price should be greater then ${per.toString()} or less then ${cartProvider.showCartDataList[0].totalamount.toString()}";
                                    }
                                    return null;
                                  },
                                  textCapitalization: TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    hintText: "Amount",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.white, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.white, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(color: Colors.white, width: 1),
                                    ),
                                    errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                    labelStyle: new TextStyle(
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  :Text("")
                ],
              ),
            ),

          ],
        )
      ],
     )
    );
  }
}
