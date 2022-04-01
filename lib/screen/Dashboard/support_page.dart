import 'package:agroon/data/provider/categoryprovider.dart';
import 'package:agroon/data/provider/webViewProvider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {


  bool _isload = false;

  _loadData()async{
    setState(() {
      _isload = true;
    });
    await  Provider.of<WebViewProvider>(context, listen: false).supportNumbersApi();
    setState(() {
      _isload = false;
    });
  }


  Future<void> _callNowApp(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
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
          title: Text("Support",
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
                :webViewProvider.supportModelList.isNull?
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
               :SingleChildScrollView(
              child:  Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Support System",
                        style: TextStyle(
                          fontSize: 20,
                          color: ColorResources.darkgreen,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Ubuntu-Regular",
                        ),),
                      SizedBox(
                        height: 20,
                      ),

                      Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("WhatsApp Number",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Ubuntu-Regular",
                                ),),
                              SizedBox(height: 10,),
                              ListView.builder(
                              itemCount: webViewProvider.supportModelList[0].data.whatsappNo.length,
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
                                             Padding(
                                               padding: const EdgeInsets.all(5.0),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Text(webViewProvider.supportModelList[0].data.whatsappNo[index]==null?"":webViewProvider.supportModelList[0].data.whatsappNo[index]),
                                                 ],
                                               ),
                                             ),
                                           ])));
                                     },
                                 ),

                              SizedBox(height: 30,),
                              Text("Contact Number",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorResources.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Ubuntu-Regular",
                                ),),

                              SizedBox(height: 10,),
                              Card(
                                  elevation: 3,
                                  color: ColorResources.darkgreen,
                                  child: InkWell(
                                    onTap: () {
                                      _callNowApp(webViewProvider.supportModelList[0].data.contactNo);
                                    },
                                    child: Container(
                                      width: 180,
                                      child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        alignment: Alignment.center,
                                                        child: Text("Call on: ${webViewProvider.supportModelList[0].data.contactNo==null?"":webViewProvider.supportModelList[0].data.contactNo}",
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: ColorResources.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: "Ubuntu-Regular",
                                                             ),
                                                           ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                    ),
                                  ))
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
