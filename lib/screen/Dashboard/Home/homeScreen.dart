
import 'package:agroon/data/provider/cartProvider.dart';
import 'package:agroon/data/provider/categoryprovider.dart';
import 'package:agroon/data/provider/productprovider.dart';
import 'package:agroon/data/provider/walkthrow_provider.dart';
import 'package:agroon/data/provider/wishlistProvider.dart';
import 'package:agroon/screen/Dashboard/category/all_categories_page.dart';
import 'package:agroon/screen/Dashboard/category/product_detail_page.dart';
import 'package:agroon/screen/Dashboard/category/product_page.dart';
import 'package:agroon/screen/Dashboard/category/subProduct_page.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {




  final List<String> imageList = [
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
    ];
  final List<String> imageList1 = [
    Images.allCategoryimage,
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
    Images.fruitsimage,
  ];

  final List<String> categoryName = [
    "All Categories",
    "Category 1",
    "Category 2",
    "Category 3",
    "Category 4",
    "Category 5",
    "Category 6",
    "Category 7",
    "Category 8",
  ];



  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false).getcategoryData();
    Provider.of<WalkthrowProvider>(context, listen: false).getsplashData();
    Provider.of<ProductProvider>(context, listen: false).getproductData();
    Provider.of<WalkthrowProvider>(context, listen: false).getColorsData();
  }

  bool _isLoading = false;
  void _addCart(String productId,String priceId, var quantity)async{
    setState(() {
      _isLoading = true;
    });
    await Provider.of<CartProvider>(context,listen: false).addCartapi(productId, priceId, quantity);
    setState(() {
      _isLoading = false;
    });
  }
  bool isExpand = false;
  void _addWish(String productId,String priceId)async{
    setState(() {
      isExpand = true;
    });
    await Provider.of<WishlistProvider>(context,listen: false).addWishlistapi(productId, priceId);
    setState(() {
      isExpand = false;
    });
  }
  

  var wish = 0;
  var selectedtab = 0;
  bool favbutton = false;
  var current_index = 0;
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
    return  Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) =>
      categoryProvider.categoryDataList==null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
            child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(3, 3),
                  ),
                ], color: Colors.white),
                child: Column(
                  children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(AllCategoryPage(),
                                  transition: Transition.rightToLeftWithFade,
                                  duration: Duration(milliseconds: 600));
                            },
                            child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(colors: [
                                      ColorResources.darkgreen,
                                      ColorResources.darkgreen,
                                    ])
                                ),
                                child: ClipRRect(
                                 borderRadius: BorderRadius.all(Radius.circular(100)),
                                    child: Image.asset(
                                      Images.allCategoryimage,
                                      fit: BoxFit.fill,
                                     )
                                    ),
                              ),
                              SizedBox(height: 10,),
                              const Text(Strings.all_categories,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto",
                                      color: ColorResources.darkgreen)),
                             ],
                            ),
                           ),
                          ),
                          Expanded(
                            child: Container(
                            margin: EdgeInsets.only(top: 10),
                            width: Get.width,
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryProvider.categoryDataList.length,
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () async{
                                            await SharedPrefManager.savePrefString(AppConstants.CATEGORYID, categoryProvider.categoryDataList[index].categoryId.toString());
                                            Get.to(() => ProductPage(),
                                                transition: Transition.rightToLeftWithFade,
                                                duration: Duration(milliseconds: 600));
                                          },
                                          child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.3),
                                                      spreadRadius: 1,
                                                      blurRadius: 3,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                  borderRadius: BorderRadius.circular(50),
                                                  gradient: LinearGradient(colors: [
                                                    Colors.white60,
                                                    Colors.white
                                                  ])
                                                  // gradient: selectedtab == index
                                                  //     ? LinearGradient(colors: [
                                                  //   ColorResources.darkgreen,
                                                  //   ColorResources.darkgreen
                                                  // ])
                                                  //     : LinearGradient(colors: [
                                                  //   Colors.white60,
                                                  //   Colors.white
                                                  // ])
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 5),
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.all(Radius.circular(50)),
                                                    child: categoryProvider.categoryDataList[index].image==null?Image.asset(
                                                      imageList1[index],
                                                      height: 40,
                                                      width: 40,
                                                      fit: BoxFit.fill,
                                                     )
                                                      :Image.network(categoryProvider.categoryDataList[index].image,
                                                      fit: BoxFit.fill,
                                                      height: 40,
                                                      width: 40,
                                                  )
                                                  ),
                                                  // Icon(Icons.category,
                                                  //   size: 40,
                                                  //   color: selectedtab == index?ColorResources.white:ColorResources.black,
                                                  // )
                                                ],
                                              )),
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          child: Expanded(
                                            child: Text(categoryProvider.categoryDataList[index].category.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Roboto",
                                                    color:ColorResources.darkgreen)),
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                            ),
                    ),
                          ),
                        ],
                      ),
                      _caroselslider(),
                      SizedBox(height: 20,),
                      Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(Strings.top_categories,
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorResources.darkgreen,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Ubuntu-Regular",
                          )),
                    ),
                      SizedBox(height: 10,),
                    categoryProvider.categoryDataList.isEmpty?
                    Text("No Data found",
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
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
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
                                              imageList[index],
                                              fit: BoxFit.fill,
                                            )
                                                :Image.network(categoryProvider.categoryDataList[index].image,
                                              fit: BoxFit.fill,
                                            )
                                          ),),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            child:  Text(categoryProvider.categoryDataList[index].category==null?"Category Name":categoryProvider.categoryDataList[index].category.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
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
                              ));
                        },
                      ),
                    ),
                      SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(Strings.top_discount_items,
                          style: TextStyle(
                            fontSize: 20,
                            color: ColorResources.darkgreen,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Ubuntu-Regular",
                          )),
                    ),
                      SizedBox(height: 10,),
                    Consumer<ProductProvider>(
                      builder: (context, productProvider, child) =>
                      productProvider.productDataList==null
                          ? Text("")
                          : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: productProvider.productDataList.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: () async{
                                    await SharedPrefManager.savePrefString(AppConstants.PRODUCTID, productProvider.productDataList[index].productId.toString());
                                    // Navigator.of(context).push(MaterialPageRoute(builder: (builder) => ProductDetailPage()));
                                    // Get.to(ProductDetailPage(),
                                    //     transition: Transition.rightToLeftWithFade,
                                    //     duration: Duration(milliseconds: 600));
                                    Get.to(() => ProductDetailPage(),
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
                                                child: productProvider.productDataList[index].priceDetails[0].priceImg[0]==null?Image.asset(
                                                  imageList[index],
                                                  fit: BoxFit.fill,
                                                )
                                                    :Image.network(productProvider.productDataList[index].priceDetails[0].priceImg[0],
                                                  fit: BoxFit.fill,
                                                )
                                            ),),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(productProvider.productDataList[index].productName==null?"":productProvider.productDataList[index].productName.toString(),
                                                          overflow: TextOverflow.ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                            fontFamily: "Ubuntu-Regular",
                                                          )),
                                                      width: 115,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(productProvider.productDataList[index].shortDescription==null?"":productProvider.productDataList[index].shortDescription.toString(),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: "Ubuntu-Regular",
                                                        )),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text("Rs.${productProvider.productDataList[index].priceDetails[0].totlaAmount==null?"":productProvider.productDataList[index].priceDetails[0].totlaAmount.toString()}",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w500,
                                                              fontFamily: "Ubuntu-Regular",
                                                            )),
                                                        SizedBox(width: 5),
                                                        // Text(
                                                        //   "Rs.${productProvider.productDataList[index].priceDetails[0].mrp==null?"":productProvider.productDataList[index].priceDetails[0].mrp.toString()}",
                                                        //   style: TextStyle(
                                                        //     color: Colors.blue,
                                                        //     fontWeight: FontWeight.w500,
                                                        //     fontFamily: "Ubuntu-Regular",
                                                        //     decoration:
                                                        //     TextDecoration.lineThrough,
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _addWish(productProvider.productDataList[index].productId,productProvider.productDataList[index].priceDetails[0].priceId);
                                                          isExpand = isExpand ? false : true;
                                                        });
                                                      },
                                                      child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                blurRadius: 3,
                                                                color: Colors.grey.shade400,
                                                                offset: Offset(0, 3),
                                                                spreadRadius: 1,
                                                              )
                                                            ],
                                                            shape: BoxShape.circle,
                                                            color: favbutton == true ? Colors.red:Colors.white,
                                                          ),
                                                          child: Center(
                                                            child: isExpand
                                                                ? Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            )
                                                                : Icon(
                                                              Icons.favorite,
                                                              color: favbutton == true ? Colors.white:Colors.red,
                                                            ),
                                                          )),
                                                    ),
                                                    SizedBox(height: 5),
                                                    InkWell(
                                                      onTap: (){
                                                        _addCart((productProvider.productDataList[index].productId),(productProvider.productDataList[index].priceDetails[0].priceId),1);
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 3,
                                                              color: Colors.grey.shade400,
                                                              offset: Offset(0, 3),
                                                              spreadRadius: 1,
                                                            )
                                                          ],
                                                          shape: BoxShape.circle,
                                                          color: ColorResources.darkgreen,
                                                        ),
                                                        child: Center(
                                                          child: Icon(Icons.shopping_cart,
                                                              color: Colors.white, size: 20),
                                                        ),),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                ));
                          },
                        ),
                    ),
                      ),
                      SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  _caroselslider() {
    return Consumer<WalkthrowProvider>(
      builder: (context, walkthrowProvider, child) =>
      walkthrowProvider.splashModelList==null
          ? Text("")
          : GFCarousel(
          pagination: true,
          height: 190,
          pagerSize: 10.0,
          autoPlay: true,
          viewportFraction: 1.0,
          activeIndicator: Colors.blue,
          passiveIndicator: Colors.grey,
          initialPage: 0,
          autoPlayInterval: Duration(seconds: 7),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          items: walkthrowProvider.splashModelList.map(
                (url) {
              return Container(
                margin: EdgeInsets.only(top: 10,right: 10,left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Image.network(url.image,
                  fit: BoxFit.fitWidth,
                )
                ),
              );
            },
          ).toList(),
          onPageChanged: (index) {
            setState(() {
              index;
            });
          },
        ),
    );
  }


}
