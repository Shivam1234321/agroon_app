import 'dart:async';


import 'package:agroon/data/provider/authprovider.dart';
import 'package:agroon/data/provider/categoryprovider.dart';
import 'package:agroon/data/provider/profileprovider.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/screen/Dashboard/wishlist/favorites_page.dart';
import 'package:agroon/screen/checkout/checkout_page.dart';
import 'package:agroon/screen/profile/profile_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/strings.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Home/homeScreen.dart';
import 'drawer_page.dart';


class BottomNavigationBarPage extends StatefulWidget {





  int selectIndex;

  BottomNavigationBarPage({this.selectIndex});

  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int currentPage = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var newIn = Get.arguments;



  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).checkUserApi();
    Provider.of<ProfileProvider>(context, listen: false).getProfileList();
    if(widget.selectIndex==null){
    }else{
      currentPage = widget.selectIndex;
    }
    super.initState();
  }


  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }


  @override
  Widget build(BuildContext context) {


    final tabs = [
      HomePage(),
      CheckOutPage(),
      FavoritePage(),
      ProfilePage(),
    ];

    final tab = [
      TabData(iconData: Icons.home_outlined, title: Strings.home),
      TabData(iconData: Icons.shopping_cart, title: Strings.my_cart),
      TabData(iconData: Icons.favorite, title: Strings.my_wishlist),
      TabData(iconData: Icons.person, title: Strings.account),
    ];

    return SafeArea(
      top: false,
      child: Scaffold(
        key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: InkWell(
              splashColor: Colors.white,
              onTap: _openDrawer,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Icon(Icons.menu,color: ColorResources.darkgreen,)
              ),
            ),
            title: Image.asset(Images.logo,width: 50,),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(NotificationPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                  icon: Icon(Icons.notifications, size: 30,color: ColorResources.darkgreen,)),
            ],
          ),
          drawer: Drawer(
            child: Consumer<ProfileProvider>(
              builder: (context, profileProvider, child) =>
              profileProvider.getProfileModelList == null
                  ? Text("")
                  : Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: DrawerHeader(
                      decoration: BoxDecoration(color: ColorResources.greenAccent,),
                        child: Container(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   children: [
                                     CircleAvatar(
                                         // radius: 25,
                                         backgroundColor: ColorResources.darkgreen,
                                         child: Icon(Icons.person,color: Colors.white,)),
                                     SizedBox(width: 10,),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Text(Strings.hello,
                                             style: TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 18,
                                                 fontFamily: "Roboto",
                                                 letterSpacing: 0.5,
                                                 color: ColorResources.black)
                                         ),
                                         Text(profileProvider.getProfileModelList[0].data.name==null?"XYZ":profileProvider.getProfileModelList[0].data.name.toString(),
                                             style: TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 18,
                                                 fontFamily: "Roboto",
                                                 letterSpacing: 0.5,
                                                 color: ColorResources.black)
                                         ),
                                       ],
                                     ),

                                   ],
                                 ),
                                 Image.asset(Images.logo_image,height: 30,width: 90,),
                               ],
                             ),
                           ),
                    ),
                  ),
                   Expanded(
                      flex: 8,
                      child: DrawerPage()),
                ],
              ),
            ),
          ),
          body: tabs[currentPage],
          bottomNavigationBar: FancyBottomNavigation(
            circleColor: ColorResources.darkgreen,
            textColor: ColorResources.darkgreen,
            initialSelection: currentPage,
            barBackgroundColor: Colors.white,
            inactiveIconColor: Colors.grey,
            tabs: tab,
            onTabChangedListener: (position) {
              setState(() {
                currentPage = position;

              });
            },
          )),
    );
  }
}
