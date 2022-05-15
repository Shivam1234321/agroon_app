import 'package:agroon/data/provider/categoryprovider.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../bottom_navigation_bar_page.dart';
import 'product_page.dart';

class AllCategoryPage extends StatefulWidget {

  @override
  _AllCategoryPageState createState() => _AllCategoryPageState();
}

class _AllCategoryPageState extends State<AllCategoryPage> {


  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).getcategoryData();
  }

  var CateogryNames = [
    "Fruits &\nVegitables",
    "Daily Needs",
    "Personal Care",
    "Cleaning &\nHousehold",
  ];
  var CategoryImages = [
    "assets/images/fruitsimage.jpg",
    "assets/images/GroceryItems.jpg",
    "assets/images/PersonalCare.jpg",
    "assets/images/cleaningitems.jpg",
  ];
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
          title: Text("All Categories",
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
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 25,
                  color: ColorResources.darkgreen,
                )),
            IconButton(
                onPressed: () {
                  Get.to(NotificationPage(),
                      transition: Transition.rightToLeftWithFade,
                      duration: Duration(milliseconds: 600));  },
                icon: Icon(Icons.notifications, size: 30,color: ColorResources.darkgreen,)),

          ],
        ),
        body: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) =>
            categoryProvider.categoryDataList == null
                ? Center(child: CircularProgressIndicator())
                :SingleChildScrollView(
            child:  Container(
              child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(Strings.ALL_CATEGORY,
                  style: TextStyle(
                  fontSize: 20,
                  color: ColorResources.darkgreen,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Ubuntu-Regular",
                ),),
                  const SizedBox(
                    height: 20,
                  ),

                  categoryProvider.categoryDataList.isEmpty?
                  const Text("No Data found",
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Ubuntu-Regular",
                      ))
                      :Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics:  const NeverScrollableScrollPhysics(),
                      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: categoryProvider.categoryDataList.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () async{
                                await SharedPrefManager.savePrefString(AppConstants.CATEGORYID, categoryProvider.categoryDataList[index].categoryId.toString());
                                Get.to(() => ProductPage(),
                                    transition: Transition.rightToLeftWithFade,
                                    duration: Duration(milliseconds: 600));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          child: categoryProvider.categoryDataList[index].image==null?Image.asset(
                                            Images.fruitsimage,
                                            fit: BoxFit.fill,
                                           )
                                              :Image.network(categoryProvider.categoryDataList[index].image,
                                              fit: BoxFit.fill,
                                              )
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          child:  Text(categoryProvider.categoryDataList[index].category==null?"Category Name":categoryProvider.categoryDataList[index].category.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Ubuntu-Regular",
                                              )),
                                          width: 115,
                                        ),
                                      )
                                    ],
                                  )),
                            )
                        );
                      },
                    ),
                  ),
                ],
              ),
          ),
        ),
            )));
  }
}
