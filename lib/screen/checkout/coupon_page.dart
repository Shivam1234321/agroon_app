import 'package:agroon/data/provider/categoryprovider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class CouponPage extends StatefulWidget {
  const CouponPage({Key key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {



  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).getoffersData();
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.keyboard_arrow_left_outlined,
                color: ColorResources.darkgreen, size: 28)),
        centerTitle: true,
        title: const Text("Coupons",
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
                    duration: Duration(milliseconds: 600)); },
              icon: Icon(Icons.notifications, size: 30,color: ColorResources.darkgreen,)),

        ],
      ),
      body:  Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) =>
        categoryProvider.offersDataList == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
            child: Column(
              children: [
                 Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0,left: 5,right: 5),
                    child: Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                        new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                          childAspectRatio: 2.5,
                        ),
                        itemCount: categoryProvider.offersDataList.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            onTap: () {

                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: index % 2 == 0
                                            ? ColorResources.white
                                            : Colors.redAccent,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image.network(categoryProvider.offersDataList[index].image,),
                                            height: 110,
                                            width: 135,
                                            padding: EdgeInsets.only(left: 10),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(categoryProvider.offersDataList[index].title==null?"":categoryProvider.offersDataList[index].title,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    letterSpacing: 0.3,
                                                    color: ColorResources.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Ubuntu-Regular",
                                                  )),
                                              SizedBox(height: 10),
                                              Center(
                                                  child: SelectableText(categoryProvider.offersDataList[index].couponCode==null?"":categoryProvider.offersDataList[index].couponCode,
                                                      cursorColor: ColorResources.darkgreen,
                                                      showCursor: true,
                                                      toolbarOptions: ToolbarOptions(
                                                          copy: true,
                                                          selectAll: true,
                                                          cut: false,
                                                          paste: false
                                                      ),
                                                      style: Theme.of(context).textTheme.bodyText2)
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(15, 15, 20, 15),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("Valid till ${categoryProvider.offersDataList[index].expire==null?"":categoryProvider.offersDataList[index].expire}  ",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            )),
                                        // Text(categoryProvider.offersDataList[index].title==null?"":categoryProvider.offersDataList[index].title,,
                                        //     style: TextStyle(
                                        //       fontSize: 12,
                                        //       color: Colors.black,
                                        //     )),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 2,
                                  top: 0,
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 3,
                                              color: ColorResources.darkgreen,
                                              offset: Offset(0, 3),
                                              spreadRadius: 1,
                                            )
                                          ],
                                          shape: BoxShape.circle,
                                          color: ColorResources.darkgreen,),
                                      child: Center(
                                        child: Text("${categoryProvider.offersDataList[index].discount==null?"":categoryProvider.offersDataList[index].discount}%",
                                            style: TextStyle(
                                              fontSize: 15,
                                              letterSpacing: 0.1,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Ubuntu-Regular",
                                            )),
                                      )),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
      ),
    );
  }
}
