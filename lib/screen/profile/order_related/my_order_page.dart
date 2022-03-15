import 'package:agroon/data/provider/webViewProvider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/screen/profile/order_related/order_detail_page.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key key}) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {

  bool _isload = false;

  _loadData()async{
    setState(() {
      _isload = true;
    });
    await Provider.of<WebViewProvider>(context, listen: false).showOrderapi();
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
          title: Text("My Orders",
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
        body: Consumer<WebViewProvider>(
          builder: (context, webViewProvider, child) =>
          _isload==true?
          Center(child: CircularProgressIndicator())
          :webViewProvider.showOrderModelList.isNull?
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
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: webViewProvider.showOrderModelList[0].data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () async{
                            await  SharedPrefManager.savePrefString(AppConstants.ORDERID, webViewProvider.showOrderModelList[0].data[index].orderId.toString());
                            await  SharedPrefManager.savePrefString(AppConstants.ORDERKEY, webViewProvider.showOrderModelList[0].data[index].orderKey.toString());
                              Get.to(OrderDetailPage(),
                                  transition: Transition.rightToLeftWithFade,
                                  duration: Duration(milliseconds: 600));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  border: Border.all(color: ColorResources.darkgreen, width: 1.5),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("#${(webViewProvider.showOrderModelList[0].data[index].orderId==null?"":webViewProvider.showOrderModelList[0].data[index].orderId)+" "+(webViewProvider.showOrderModelList[0].data[index].userName==null?"":webViewProvider.showOrderModelList[0].data[index].userName)}",
                                                  style: TextStyle(
                                                      color: ColorResources.darkgreen,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold)),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Order Status: ${(webViewProvider.showOrderModelList[0].data[index].orderStatus==null?"":webViewProvider.showOrderModelList[0].data[index].orderStatus)}",
                                                      style: TextStyle(
                                                          color: ColorResources.black,
                                                          fontWeight: FontWeight.w500)),
                                                  Text("Price: ${(webViewProvider.showOrderModelList[0].data[index].totalPayment==null?"":webViewProvider.showOrderModelList[0].data[index].totalPayment)}",
                                                      style: TextStyle(
                                                          color: ColorResources.black,
                                                          fontWeight: FontWeight.w500)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Text("Email Id: ${(webViewProvider.showOrderModelList[0].data[index].email==null?"":webViewProvider.showOrderModelList[0].data[index].email)}",
                                              style: TextStyle(
                                                  color: ColorResources.black,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    Divider(color: Colors.black, height: 2),
                                    // SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("View details",
                                          style: TextStyle(
                                              color: ColorResources.darkgreen,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                )),
                          ));
                    },
                  ),
                ],
              )),
        ));
  }
}
