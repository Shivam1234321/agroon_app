import 'dart:async';

import 'package:agroon/data/provider/profileprovider.dart';
import 'package:agroon/data/provider/webViewProvider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/checkout/choose_address_page.dart';
import 'package:agroon/screen/profile/order_related/my_order_page.dart';
import 'package:agroon/screen/profile/profile_edit_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'change_password_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool favbutton = false;
  var current_index = 3;

  _launchURLApp(url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).getProfileList();
    Provider.of<WebViewProvider>(context,listen: false).webViewApi();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,

      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) =>
        profileProvider.getProfileModelList == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
            child: Container(
                child: Column(
          children: [
             Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                 Center(
                  child: Container(
                      child: Center(
                       child: Card(
                         elevation: 5,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(100.0),
                         ),
                         child: CircleAvatar(
                           radius: 50,
                           backgroundColor: ColorResources.white,
                           child: Icon(Icons.person,color:ColorResources.black,size: 60,),
                          // backgroundImage: NetworkImage(getProfileModel[0].data.customerImage),
                         ),
                       ),
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(profileProvider.getProfileModelList[0].data.name==null?"XYZ":profileProvider.getProfileModelList[0].data.name.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 1,
                      color: ColorResources.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Ubuntu-Regular",
                    )),
                SizedBox(
                  height: 5,
                ),
                Text(profileProvider.getProfileModelList[0].data.email==null?"xyz@gmail.com":profileProvider.getProfileModelList[0].data.email.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 1,
                      color: ColorResources.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Ubuntu-Regular",
                    )),
                SizedBox(
                  height: 5,
                ),
                 Text(profileProvider.getProfileModelList[0].data.address==null?"":profileProvider.getProfileModelList[0].data.address.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 1,
                      color: ColorResources.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Ubuntu-Regular",
                    )),
                 ],
              ),
              SizedBox(height: 20),
              Divider(
              color: ColorResources.black,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Strings.settings,
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.5,
                        color: ColorResources.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Ubuntu-Regular",
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              Get.to(ProfileEditPage(),arguments: profileProvider.getProfileModelList[0].data,
                                  transition: Transition.rightToLeftWithFade,
                                  duration: Duration(milliseconds: 600));
                            });
                             },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.person,
                                    color: ColorResources.black,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.account_Update,
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                        color: ColorResources.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Ubuntu-Regular",
                                      )),
                                  SizedBox(height: 5),
                                  Text(Strings.tap_to_edit_your_account,
                                      style: TextStyle(
                                        letterSpacing: 0.3,
                                        color: ColorResources.black,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Ubuntu-Regular",
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            Get.to(ChangePasswordPage(),
                                transition: Transition.rightToLeftWithFade,
                                duration: Duration(milliseconds: 600));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.password,
                                    color: ColorResources.black,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.password,
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                        color: ColorResources.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Ubuntu-Regular",
                                      )),
                                  SizedBox(height: 5),
                                  Text(Strings.tap_to_change_your_password,
                                      style: TextStyle(
                                        letterSpacing: 0.3,
                                        color: ColorResources.black,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Ubuntu-Regular",
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            Get.to(MyOrdersPage(),
                                transition: Transition.rightToLeftWithFade,
                                duration: Duration(milliseconds: 600));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: ColorResources.black,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.orders,
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                        color: ColorResources.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Ubuntu-Regular",
                                      )),
                                  SizedBox(height: 5),
                                  Text(Strings.show_your_purchased_order_list,
                                      style: TextStyle(
                                        letterSpacing: 0.3,
                                        color: ColorResources.black,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Ubuntu-Regular",
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: (){
                            Share.share("Hey");
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.share,
                                    color: ColorResources.black,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.share,
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                        color: ColorResources.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Ubuntu-Regular",
                                      )),
                                  SizedBox(height: 5),
                                  Text(Strings.share_application,
                                      style: TextStyle(
                                        letterSpacing: 0.3,
                                        color: ColorResources.black,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Ubuntu-Regular",
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: (){
                            Get.to(ChooseAddressPage(),
                                transition: Transition.rightToLeftWithFade,
                                duration: Duration(milliseconds: 600));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: (){},
                                  icon: Icon(
                                    Icons.location_on_outlined,
                                    color: ColorResources.black,
                                  ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.my_Address,
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                        color: ColorResources.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Ubuntu-Regular",
                                      )),
                                  SizedBox(height: 5),
                                  Text(Strings.show_your_address,
                                      style: TextStyle(
                                        letterSpacing: 0.3,
                                        color: ColorResources.black,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Ubuntu-Regular",
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Consumer<WebViewProvider>(
                          builder: (context,webViewProvider,child)=>
                          webViewProvider.webViewModelList.isNull?
                          Text("")
                              : InkWell(
                              onTap: () {
                              _launchURLApp(webViewProvider.webViewModelList[0].data.contactus.toString());
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.call,
                                      color: ColorResources.black,
                                    )),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(Strings.contact_us,
                                        style: TextStyle(
                                          fontSize: 15,
                                          letterSpacing: 0.5,
                                          color: ColorResources.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Ubuntu-Regular",
                                        )),
                                    SizedBox(height: 5),
                                    Text(Strings.any_enquiry_please_contact_us,
                                        style: TextStyle(
                                          letterSpacing: 0.3,
                                          color: ColorResources.black,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Ubuntu-Regular",
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
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
                                        Get.back();
                                        SharedPrefManager.clearPrefs();
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
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.logout,
                                    color: ColorResources.black,
                                  )),
                              Text(Strings.logout,
                                  style: TextStyle(
                                    fontSize: 15,
                                    letterSpacing: 0.5,
                                    color: ColorResources.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Ubuntu-Regular",
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ))),
      ),
    ));
  }
}
