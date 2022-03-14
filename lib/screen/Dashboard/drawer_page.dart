import 'dart:async';

import 'package:agroon/data/provider/walkthrow_provider.dart';
import 'package:agroon/data/provider/webViewProvider.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/screen/Dashboard/support_page.dart';
import 'package:agroon/screen/checkout/choose_address_page.dart';
import 'package:agroon/screen/checkout/coupon_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bottom_navigation_bar_page.dart';
import 'category/all_categories_page.dart';



class DrawerPage extends StatefulWidget {
  const DrawerPage({Key key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {

  var current_index = 3;

  @override
  void initState() {
    super.initState();
    Provider.of<WebViewProvider>(context,listen: false).webViewApi();
  }

  _launchURLApp(url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
      Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:0)));
                  },
                  title: Text(Strings.home,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.black,
                      letterSpacing: 0.5,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child:
                      Icon(Icons.home,color: ColorResources.black,)),
                ),
                ListTile(
                  onTap: () {
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:1)));
                  },
                  title: Text(Strings.my_cart,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.black,
                      letterSpacing: 0.5,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child:
                      Icon(Icons.shopping_cart,color: ColorResources.black,)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:2)));
                  },
                  title: Text(Strings.my_wishlist,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.black,
                      letterSpacing: 0.5,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.favorite,color: ColorResources.black,)),
                ),
                Container(
                  height: 1,
                  color: ColorResources.dash,
                ),
                ListTile(
                  onTap: () {
                    Get.to(AllCategoryPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  title: Text(Strings.all_categories,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.black,
                      letterSpacing: 0.5,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.widgets,color: ColorResources.black,)),
                ),
                ListTile(
                  onTap: (){
                    Get.to(ChooseAddressPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600),
                    );
                  },
                  title: Text(Strings.my_Address,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.black,
                      letterSpacing: 0.5,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child:
                      Icon(Icons.location_on,color: ColorResources.black,)),
                ),
                ListTile(
                  onTap: (){
                    Get.to(CouponPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600),
                    );
                  },
                  title: Text(Strings.offers,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.black,
                      letterSpacing: 0.5,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child:
                      Icon(Icons.local_offer,color: ColorResources.black,)),
                ),
                ListTile(
                  onTap: (){
                    Get.to(SupportPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600),
                    );
                  },
                  title: Text("Support",
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.black,
                      letterSpacing: 0.5,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child:
                      Icon(Icons.support_agent,color: ColorResources.black,)),
                ),
                Container(
                  height: 1,
                  color: ColorResources.dash,
                ),
                ListTile(
                  onTap: (){
                    Get.to(NotificationPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  title: const Text(Strings.notification,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.black,
                      letterSpacing: 0.5,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.notifications,color: ColorResources.black,)),
                ),
                Container(
                  height: 1,
                  color: ColorResources.dash,
                ),
                Consumer<WebViewProvider>(
                  builder: (context,webViewProvider,child)=>
                  webViewProvider.webViewModelList.isNull?
                  Text("")
                      : ListTile(
                    onTap: () {
                      _launchURLApp(webViewProvider.webViewModelList[0].data.termCondition.toString());
                    },
                    title: Text("Term Condition",
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorResources.black,
                        letterSpacing: 0.5,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                        height: 20,
                        width: 20,
                        child:
                        Icon(Icons.description,color: ColorResources.black,)),
                  ),
                ),
                Consumer<WebViewProvider>(
                  builder: (context,webViewProvider,child)=>
                  webViewProvider.webViewModelList.isNull?
                  Text("")
                      : ListTile(
                    onTap: () {
                      _launchURLApp(webViewProvider.webViewModelList[0].data.privacyPolicy.toString());
                      },
                    title: Text(Strings.privacy_policy,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorResources.black,
                        letterSpacing: 0.5,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    horizontalTitleGap: 0,
                    leading: SizedBox(
                        height: 20,
                        width: 20,
                        child:
                        Icon(Icons.privacy_tip,color: ColorResources.black,)),
                  ),
                ),
                Container(
                  height: 1,
                  color: ColorResources.dash,
                ),

                ListTile(
                  onTap: (){
                    Share.share("hello");
                  },
                  title: Text(Strings.share,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.black,
                      letterSpacing: 0.5,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.share,color: ColorResources.black,)),
                ),

                SizedBox(
                  height: 30,
                ),
                ListTile(
                  onTap: () {
                    Get.defaultDialog(
                      radius: 10,
                      contentPadding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                      titlePadding: EdgeInsets.only(top: 20.0),
                      backgroundColor: Colors.white,
                      title: Strings.areyousureyouwantto_logout,
                      titleStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      content: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                SharedPrefManager.clearPrefs();
                                Get.back();
                                Get.snackbar("Logout",
                                    "Successfully");
                              },
                              child: Center(
                                child: Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          ColorResources.green,
                                          ColorResources.darkgreen,
                                        ]),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            20)),
                                    child: Center(
                                        child: Text(
                                          Strings.yes,
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
                                        gradient: LinearGradient(colors: [
                                          ColorResources.green,
                                          ColorResources.darkgreen,

                                        ]),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            20)),
                                    child: Center(
                                        child: Text(
                                          Strings.no,
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
                  title: Text(Strings.logout,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.black,
                      letterSpacing: 0.5,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  horizontalTitleGap: 0,
                  leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.logout,color: ColorResources.black,)),
                ),
                SizedBox(
                  height: 30,
                ),
                Consumer<WalkthrowProvider>(
                    builder: (context, walkthrowProvider, child) =>
                    walkthrowProvider.colorModelList==null
                        ? Text("")
                        : Text("Version:- ${walkthrowProvider.colorModelList[0].data.versionCode==null?"1.0.0":walkthrowProvider.colorModelList[0].data.versionCode}")
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
