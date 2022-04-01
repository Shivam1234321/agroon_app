import 'package:agroon/data/provider/webViewProvider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class OrderSuccessfulCashOnDPage extends StatefulWidget {

  OrderSuccessfulCashOnDPage({Key key}) : super(key: key);


  @override
  _OrderSuccessfulCashOnDPageState createState() => _OrderSuccessfulCashOnDPageState();
}

class _OrderSuccessfulCashOnDPageState extends State<OrderSuccessfulCashOnDPage> {


  @override
  void initState() {
     Provider.of<WebViewProvider>(context, listen: false).orderPaymentAPi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                height: Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    _headings(),
                    SizedBox(height: 50),
                    Image.asset("assets/image/confirmorder.jpg",width: 180,height: 180,),
                    SizedBox(height: 30),
                    _gretings(),
                    SizedBox(height: 30),
                    _orderid(),
                    SizedBox(height: 100),
                    _proceedbutton(),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            )));
  }

  _headings() {
    return Center(
      child: Text(" Congratulations!",
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "Ubuntu-Regular",
          )),
    );
  }



  _gretings() {
    return Center(
      child: Column(
        children: [
          Text("Order placed successfully",
              style: TextStyle(
                fontSize: 20,
                color: ColorResources.darkgreen,
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu-Regular",
              )),
          SizedBox(height: 5),
          Text("Thank you!",
              style: TextStyle(
                fontSize: 20,
                color: ColorResources.darkgreen,
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu-Regular",
              )),
        ],
      ),
    );
  }

  _orderid() {
    return Consumer<WebViewProvider>(
      builder: (context,webViewProvider,child)=>
      webViewProvider.orderModellList==null?
      Text("")
          : Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text("Order Id : ${webViewProvider.orderModellList[0].data.orderId}",
                // textAlign: TextAlign.center,
                 style: TextStyle(
                  fontSize: 16,
                  color: ColorResources.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Ubuntu-Regular",
                )),
            SizedBox(height: 5),
             Text("Txn Id : ${webViewProvider.orderModellList[0].data.orderKey}",
                style: TextStyle(
                  fontSize: 16,
                  color: ColorResources.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Ubuntu-Regular",
                )),
          ],
        ),
      ),
    );
  }

  _proceedbutton() {
    return InkWell(
        onTap: () {
          Get.off(BottomNavigationBarPage(),
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
                child: Text("Continue shopping",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold)),
              )),
        ));
  }
 }
