import 'package:agroon/data/provider/webViewProvider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key key}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {


  bool _isload = false;

  _loadData()async{
    setState(() {
      _isload = true;
    });
    await Provider.of<WebViewProvider>(context, listen: false).showOrderapi();
    await Provider.of<WebViewProvider>(context, listen: false).orderDetailsapi();
    setState(() {
      _isload = false;
    });
  }

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
          title: Text("Order details",
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                color: ColorResources.darkgreen,
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu-Regular",
              )),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:1)));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  size: 25,
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
        bottomNavigationBar: Consumer<WebViewProvider>(
          builder: (context, webViewProvider, child) =>
          webViewProvider.orderDetailsModelList.isNull?
          Text("")
              :
          webViewProvider.orderDetailsModelList[0].data.order.orderPaymentStatus.toString()=="2"?
          Text("")
          :InkWell(
              onTap: () {
                // Get.to(ChooseAddressPage(),
                //     transition: Transition.rightToLeftWithFade,
                //     duration: Duration(milliseconds: 600));
              },
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
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  height: 40,
                  width: Get.width,
                  child: Center(
                    child: Text("Make Payment",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold)),
                  )))
        ),
        body: Consumer<WebViewProvider>(
          builder: (context, webViewProvider, child) =>
          _isload==true?
          Center(child: CircularProgressIndicator())
              :webViewProvider.orderDetailsModelList.isNull?
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/image/nonotification.jpg",width: Get.width,),
                Text("You have not receive any orders",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16,
                      color: ColorResources.darkgreen,
                      fontWeight: FontWeight.bold),),
              ],
            ),
          )
              : SingleChildScrollView(
              child: Container(
            child: Padding(
              padding:  EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order Number",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    letterSpacing: 0.1,
                                    fontWeight: FontWeight.bold)),
                            Text("#${webViewProvider.orderDetailsModelList[0].data.order.orderId==null?"":webViewProvider.orderDetailsModelList[0].data.order.orderId}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    letterSpacing: 0.1,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    letterSpacing: 0.1,
                                    fontWeight: FontWeight.bold)),
                            Text("Rs. ${webViewProvider.orderDetailsModelList[0].data.product[0].totalAmount==null?"":webViewProvider.orderDetailsModelList[0].data.product[0].totalAmount}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    letterSpacing: 0.1,
                                    fontWeight: FontWeight.w600)),

                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text("Placed on",
                      style: TextStyle(
                          color: Colors.black54,
                          letterSpacing: 0.3,
                          fontWeight: FontWeight.w500)),
                  Text("${webViewProvider.orderDetailsModelList[0].data.order.placedOn==null?"":webViewProvider.orderDetailsModelList[0].data.order.placedOn.toString()}",
                      style: TextStyle(
                          color: Colors.black54,
                          letterSpacing: 0.3,
                          fontWeight: FontWeight.w500)),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 5,
                      ),
                       Text("${webViewProvider.orderDetailsModelList[0].data.address.userName==null?"":webViewProvider.orderDetailsModelList[0].data.address.userName}",
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.w500)),
                      Text("${webViewProvider.orderDetailsModelList[0].data.address.address==null?"":webViewProvider.orderDetailsModelList[0].data.address.address}",
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.w500)),
                      Text("${webViewProvider.orderDetailsModelList[0].data.address.addressState==null?"":webViewProvider.orderDetailsModelList[0].data.address.addressState}",
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.w500)),
                      Text("PIN: ${webViewProvider.orderDetailsModelList[0].data.address.addressPincode==null?"":webViewProvider.orderDetailsModelList[0].data.address.addressPincode}",
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.w500)),
                      Text("Mobile No: ${webViewProvider.orderDetailsModelList[0].data.address.mobile==null?"":webViewProvider.orderDetailsModelList[0].data.address.mobile}",
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment method",
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.bold)),
                      Text("",
                          style: TextStyle(
                              color: Colors.black54,
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(height: 15),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("Tnx Id:",
                  //         style: TextStyle(
                  //             fontSize: 15,
                  //             color: Colors.black,
                  //             letterSpacing: 0.1,
                  //             fontWeight: FontWeight.bold)),
                  //     Text("orderKey",
                  //         style: TextStyle(
                  //             color: Colors.black54,
                  //             letterSpacing: 0.1,
                  //             fontWeight: FontWeight.w500)),
                  //   ],
                  // ),
                  // SizedBox(height: 15),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("Order Id:",
                  //         style: TextStyle(
                  //             fontSize: 15,
                  //             color: Colors.black,
                  //             letterSpacing: 0.1,
                  //             fontWeight: FontWeight.bold)),
                  //     Text("102ow011,2o",
                  //         style: TextStyle(
                  //             color: Colors.black54,
                  //             letterSpacing: 0.1,
                  //             fontWeight: FontWeight.w500)),
                  //   ],
                  // ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 10,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 30),
                      child: Column(
                        children: [
                          Container(
                              width: Get.width / 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorResources.white,
                                border: Border.all(color:ColorResources.darkgreen, width: 1.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text("Item name: ${webViewProvider.orderDetailsModelList[0].data.product[0].productName==null?"":webViewProvider.orderDetailsModelList[0].data.product[0].productName}",
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: ColorResources.black,
                                                      fontWeight: FontWeight.bold)),

                                            ),
                                            Text("QTY: ${webViewProvider.orderDetailsModelList[0].data.product[0].quantity==null?"":webViewProvider.orderDetailsModelList[0].data.product[0].quantity}",

                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        Text("Rs. ${webViewProvider.orderDetailsModelList[0].data.product[0].totalAmount==null?"":webViewProvider.orderDetailsModelList[0].data.product[0].totalAmount}",
                                            style: TextStyle(
                                                color: ColorResources.black,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sub total",
                                  style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500)),
                              Text("Rs. ${webViewProvider.orderDetailsModelList[0].data.order.subTotal==null?"":webViewProvider.orderDetailsModelList[0].data.order.subTotal}",
                                  style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Shipping cost",
                                  style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500)),
                              Text("Rs. ${webViewProvider.orderDetailsModelList[0].data.order.shippingCost==null?"":webViewProvider.orderDetailsModelList[0].data.order.shippingCost}",
                                  style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total",
                                  style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500)),
                              Text("Rs. ${webViewProvider.orderDetailsModelList[0].data.order.totalPayment==null?"":webViewProvider.orderDetailsModelList[0].data.order.totalPayment}",
                                  style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Paid",
                                  style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold)),
                              Text("Rs. ${webViewProvider.orderDetailsModelList[0].data.order.paidAmount==null?"":webViewProvider.orderDetailsModelList[0].data.order.paidAmount}",
                                  style: TextStyle(
                                      color: ColorResources.black,
                                      fontSize: 15,
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                 
                  // Divider(
                  //   color: ColorResources.grey,
                  //   thickness: 1.2,
                  // ),
                  SizedBox(height: 30),


                ],
              ),
            ),
          )),
        ),
    );
  }

  _headings() {
    return Center(
      child: Text("orderHistoryData.orderStatus",
          style: TextStyle(
            fontSize: 16,
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontFamily: "Ubuntu-Regular",
          )),
    );
  }

  _checkoutpic() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image:
            DecorationImage(image: AssetImage("assets/images/checkgreen.png")),
        color: Colors.orange[50],
      ),
    );
  }

}
