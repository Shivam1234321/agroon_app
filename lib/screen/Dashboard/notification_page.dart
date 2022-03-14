
import 'package:agroon/data/provider/categoryprovider.dart';
import 'package:agroon/data/provider/walkthrow_provider.dart';
import 'package:agroon/data/provider/wishlistProvider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  var _index = 0;

  bool isLoad = false;

  void _loadData()async{
    setState(() {
      isLoad = true;
    });
    await Provider.of<WalkthrowProvider>(context, listen: false).offerNotificationApi();
    await Provider.of<WalkthrowProvider>(context, listen: false).orderNotificationApi();
    setState(() {
      isLoad = false;
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
        title: Text("Notifications",
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
          // IconButton(
          //     onPressed: () {
          //       // Get.to(CheckOutPage(),
          //       //     transition: Transition.rightToLeftWithFade,
          //       //     duration: Duration(milliseconds: 600));
          //     },
          //     icon: Icon(Icons.notifications, size: 30,color: ColorResources.darkgreen,)),

        ],
      ),
      body: Consumer<WalkthrowProvider>(
        builder: (context, walkthrowProvider, child) =>
        isLoad==true?
             Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
            child: Container(
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: ColorResources.darkgreen,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                  splashColor: ColorResources.darkgreen,
                                  onTap: () {
                                    setState(() {
                                      _index = 0;
                                    });
                                  },
                                  child: _index == 0
                                      ? Text("Order Notification",
                                      style: TextStyle(
                                        color: ColorResources.white,
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.bold,
                                      ))
                                      : Text("Order Notification",
                                      style: TextStyle(
                                        color: ColorResources.white,
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                      ))),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            color: ColorResources.light_blue,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                  splashColor: ColorResources.darkgreen,
                                  onTap: () {
                                    setState(() {
                                      _index = 1;
                                    });
                                  },
                                  child: _index == 1
                                      ? Text("Offer Notification",
                                      style: TextStyle(
                                        color: ColorResources.darkgreen,
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.bold,
                                      ))
                                      : Text("Offer Notification",
                                      style: TextStyle(
                                        color: ColorResources.darkgreen,
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                      ))),
                            ),
                          ),
                        ),
                      ]),
                  // Divider(color: Colors.grey),
                  Visibility(
                      visible: _index == 0,
                      child:walkthrowProvider.orderNotificationDataList.isNull?
                      Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/image/nonotification.jpg",width: Get.width,),
                            Text("You have not receive any notification",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16,
                                  color: ColorResources.darkgreen,
                                  fontWeight: FontWeight.bold),),
                          ],
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListView.builder(
                          itemCount: walkthrowProvider.orderNotificationDataList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                                elevation: 3,
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 23,
                                            backgroundColor: Colors.red[50],
                                            child:  Image.asset(Images.logo,width: 30,height: 30,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(walkthrowProvider.orderNotificationDataList[index].title==null?"Title":walkthrowProvider.orderNotificationDataList[index].title),
                                                SizedBox(height: 5),
                                                SizedBox(
                                                  width: Get.width - 100,
                                                  child: Text(walkthrowProvider.orderNotificationDataList[index].description==null?"Message":walkthrowProvider.orderNotificationDataList[index].description,
                                                    style: TextStyle(fontSize: 13),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width - 100,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text("Date:${walkthrowProvider.orderNotificationDataList[index].date==null?"Date":walkthrowProvider.orderNotificationDataList[index].date}",
                                                          style: TextStyle(fontSize: 10)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ])));
                          },
                        ),
                      )
                  ),
                  Visibility(
                      visible: _index == 1,
                      child:walkthrowProvider.offerNotificationDataList.isNull?
                      Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/image/nonotification.jpg",width: Get.width,),
                            Text("You have not receive any notification",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16,
                                  color: ColorResources.darkgreen,
                                  fontWeight: FontWeight.bold),),
                          ],
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListView.builder(
                          itemCount: walkthrowProvider.offerNotificationDataList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                                elevation: 3,
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 23,
                                            backgroundColor: Colors.red[50],
                                            child:  Image.asset(Images.logo,width: 30,height: 30,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(walkthrowProvider.offerNotificationDataList[index].title==null?"Title":walkthrowProvider.offerNotificationDataList[index].title),
                                                SizedBox(height: 5),
                                                SizedBox(
                                                  width: Get.width - 100,
                                                  child: Text(walkthrowProvider.offerNotificationDataList[index].description==null?"Message":walkthrowProvider.offerNotificationDataList[index].description,
                                                    style: TextStyle(fontSize: 13),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width - 100,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text("Date:${walkthrowProvider.offerNotificationDataList[index].date==null?"Date":walkthrowProvider.offerNotificationDataList[index].date}",
                                                          style: TextStyle(fontSize: 10)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ])));
                          },
                        ),
                      )
                  ),
                ]))
        ),
      ),
    );
  }

}
