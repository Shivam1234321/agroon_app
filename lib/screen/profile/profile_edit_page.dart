import 'dart:convert';
import 'dart:io';
import 'package:agroon/data/model/profileModel/getProfileModel.dart';
import 'package:agroon/data/provider/authprovider.dart';
import 'package:agroon/data/provider/profileprovider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/Dashboard/notification_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {

   // final profileController = Get.put(ProfileController());

   String files;
   File filename;
   File newFile;
  final _formkey = GlobalKey<FormState>();
   GetProfileData dataGetProfile = Get.arguments;
   String name;
   String shopname;
   String gSTNo;
   String mobilenumber;
   String address;
   String image;
   String email;
   String state;
   String city;
   String landmark;
   String pincode;




  void _allDetail()async{
    var images = dataGetProfile.image;
    var names = dataGetProfile.name;
    var shopnames = dataGetProfile.shopName;
    var mobilnumbers = dataGetProfile.mobile;
    var gSTNos = dataGetProfile.gSTNo;
    var emails = dataGetProfile.email;
    var addresses = dataGetProfile.address;
    var states = dataGetProfile.state;
    var citys = dataGetProfile.city;
    var landmarks = dataGetProfile.landmark;
    var pincodes = dataGetProfile.pincode;

    setState(() {
      name = names;
      shopname = shopnames;
      mobilenumber = mobilnumbers;
      gSTNo = gSTNos;
      address = addresses;
      state = states;
      city = citys;
      image= images;
      email= emails;
      landmark= landmarks;
      pincode= pincodes;
    });
    _name.text = names;
    _shopname.text = shopnames;
    _mobile.text = mobilnumbers;
    _gSTNo.text = gSTNos;
    _address.text = addresses;
    _email.text = emails;
    _states = states;
    _city.text = citys;
    _landmark.text = landmarks;
    _pincode.text = pincodes;
  }
  final _name = TextEditingController();
  final _shopname = TextEditingController();
  final _email = TextEditingController();
  final _mobile = TextEditingController();
  final _address = TextEditingController();
  // final _states = TextEditingController();
   String _states;
  final _city = TextEditingController();
  final _gSTNo = TextEditingController();
  final _landmark = TextEditingController();
  final _pincode = TextEditingController();






  bool _isLoad = false;
  void _updateprofile()async{
    FocusScope.of(context).unfocus();
    if(_formkey.currentState.validate()){
      setState(() {
        _isLoad = true;
      });
      await Provider.of<ProfileProvider>(context,listen: false).updateprofileApi(_name.text, _shopname.text, _email.text, _mobile.text,_gSTNo.text==null?"":_gSTNo.text,_sta.isNull?dataGetProfile.state:_sta,_city.text,_address.text,_landmark.text,_pincode.text);
      setState(() {
        _isLoad = false;
      });
    }
    await Provider.of<ProfileProvider>(context, listen: false).getProfileList();

  }

  String _sta;

   @override
   void initState() {
     _allDetail();
     super.initState();

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
              icon: const Icon(Icons.keyboard_arrow_left_outlined,
                  color: ColorResources.darkgreen, size: 28)),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text("Edit Profile",
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                color: ColorResources.darkgreen,
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu-Regular",
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigationBarPage(selectIndex:1)));
                },
                icon: Icon(
                  Icons.shopping_cart,
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
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Center(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: ColorResources.white,
                            child: Icon(Icons.person,color:ColorResources.black,size: 60,),
                            // backgroundImage: NetworkImage(image)
                        ),
                        // child: GestureDetector(
                        //   onTap: (){
                        //     _showPicker(context);
                        //   },
                        //   child: Container(
                        //     height: 150,
                        //     width: 150,
                        //     child: Obx(() => profileController.selectedImagePath.value==''
                        //         ? CircleAvatar(
                        //       radius: 75,
                        //       backgroundImage: NetworkImage(image),
                        //     )
                        //         : ClipOval(
                        //         child: Image.file(File(profileController.selectedImagePath.value),
                        //           fit: BoxFit.cover,)),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _changename(),
                    SizedBox(height: 15),
                    _changeshopename(),
                    SizedBox(height: 15),
                    _changelandmark(),
                    SizedBox(height: 15),
                    _changeGSTno(),
                    SizedBox(height: 15),

                    Container(
                      height: 70,
                      // width: Get.width,
                      child: Consumer<AuthProvider>(
                        builder: (context, authProvider, child) =>
                        authProvider.showstatesModelList==null
                            ?Text("")
                            :
                        Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Icon(Icons.location_on, color: Colors.black),
                                        ),
                                    width: 30,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Container(
                                      // width: Get.width,
                                      child: DropdownButton<dynamic>(
                                        underline: SizedBox(),
                                        isExpanded: true,
                                        hint: Padding(
                                          padding: const EdgeInsets.only(left: 10.0,top: 5,bottom: 5),
                                          child: Text('${dataGetProfile.state==null?_sta.isNull?"State":_sta:dataGetProfile.state}',
                                              style: TextStyle(
                                                color: ColorResources.black,
                                                fontSize: 15,
                                              )),
                                        ), // Not necessary for Option 1
                                        value: _sta,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _sta =  newValue;
                                          });
                                        },
                                        items: authProvider.showstatesModelList[0].date.map((item) {
                                          return DropdownMenuItem(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0,top: 5,bottom: 5),
                                              child: Text(item.toString(),
                                                  style: TextStyle(
                                                    // color: ColorResources.darkgreen,
                                                    fontSize: 15,
                                                    // letterSpacing: 0.5,
                                                    // fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                            value: item,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),
                    ),
                    SizedBox(height: 15),
                    _changeCity(),
                    SizedBox(height: 15),
                    _changelocation(),
                    SizedBox(height: 15),
                    _changepincode(),
                    SizedBox(height: 30),
                    if(_isLoad)
                      CircularProgressIndicator()
                    else InkWell(
                        onTap: () {
                           _updateprofile();
                        },
                        child: CustomButton(
                            text1: "Update", text2: "", width: 150, height: 50)),
                  ],
                ),
              ),
            ),
          ),
        ));}

  _changename() {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _name,
          autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.person, color: Colors.black)),
                hintText: "Name",
                hintStyle: TextStyle(
                  color: ColorResources.darkgreen,
                  fontSize: 15,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.yellow, width: 1),
                    borderRadius: BorderRadius.circular(10))
            ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your Name";
            }

            return null;
          },
        ),);
  }

   _changeshopename() {
     return Container(
       decoration: BoxDecoration(
         boxShadow: [
           BoxShadow(
             color: Colors.grey.withOpacity(0.5),
             spreadRadius: 1,
             blurRadius: 5,
             offset: Offset(0, 3),
           ),
         ],
         color: Colors.white,
         borderRadius: BorderRadius.circular(10),
       ),
       alignment: Alignment.bottomLeft,
       child: TextFormField(
         controller: _shopname,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         textAlignVertical: TextAlignVertical.bottom,
         decoration: InputDecoration(
             prefixIcon: IconButton(
                 onPressed: null,
                 icon: Icon(Icons.person, color: Colors.black)),
             hintText: "Firm Name",
             hintStyle: TextStyle(
               color: ColorResources.darkgreen,
               fontSize: 15,
             ),
             enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(color: Colors.white, width: 1),
             ),
             focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(color: Colors.white, width: 1),
             ),
             errorBorder: OutlineInputBorder(
                 borderSide: new BorderSide(color: Colors.grey, width: 1),
                 borderRadius: BorderRadius.circular(10)),
             focusedErrorBorder: OutlineInputBorder(
                 borderSide: new BorderSide(color: Colors.grey, width: 1),
                 borderRadius: BorderRadius.circular(10)),
             border: OutlineInputBorder(
                 borderSide: new BorderSide(color: Colors.yellow, width: 1),
                 borderRadius: BorderRadius.circular(10))
         ),
         validator: (value) {
           if (value.trim().isEmpty) {
             return "Please, enter your Firm Name";
           }

           return null;
         },
       ),);
   }

   _changelandmark() {
     return Container(
       decoration: BoxDecoration(
         boxShadow: [
           BoxShadow(
             color: Colors.grey.withOpacity(0.5),
             spreadRadius: 1,
             blurRadius: 5,
             offset: Offset(0, 3),
           ),
         ],
         color: Colors.white,
         borderRadius: BorderRadius.circular(10),
       ),
       alignment: Alignment.bottomLeft,
       child: TextFormField(
         controller: _landmark,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         textAlignVertical: TextAlignVertical.bottom,
         decoration: InputDecoration(
             prefixIcon: IconButton(
                 onPressed: null,
                 icon: Icon(Icons.location_on, color: Colors.black)),
             hintText: "Landmark",
             hintStyle: TextStyle(
               color: ColorResources.darkgreen,
               fontSize: 15,
             ),
             enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(color: Colors.white, width: 1),
             ),
             focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(color: Colors.white, width: 1),
             ),
             errorBorder: OutlineInputBorder(
                 borderSide: new BorderSide(color: Colors.grey, width: 1),
                 borderRadius: BorderRadius.circular(10)),
             focusedErrorBorder: OutlineInputBorder(
                 borderSide: new BorderSide(color: Colors.grey, width: 1),
                 borderRadius: BorderRadius.circular(10)),
             border: OutlineInputBorder(
                 borderSide: new BorderSide(color: Colors.yellow, width: 1),
                 borderRadius: BorderRadius.circular(10))
         ),
         validator: (value) {
           if (value.trim().isEmpty) {
             return "Please, enter your landmark";
           }

           return null;
         },
       ),);
   }



  _changeGSTno() {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _gSTNo,
          autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.person, color: Colors.black)),
                hintText: "GST No(Optional)",
                hintStyle: TextStyle(
                  color: ColorResources.darkgreen,
                  fontSize: 15,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.yellow, width: 1),
                    borderRadius: BorderRadius.circular(10))),
          // validator: (value) {
          //   if (value.trim().isEmpty) {
          //     return "Please, enter your GST No";
          //   }
          //
          //   return null;
          // },
        ));
  }

   // _changeState() {
   //   return Container(
   //     decoration: BoxDecoration(
   //       boxShadow: [
   //         BoxShadow(
   //           color: Colors.grey.withOpacity(0.5),
   //           spreadRadius: 1,
   //           blurRadius: 5,
   //           offset: Offset(0, 3),
   //         ),
   //       ],
   //       color: Colors.white,
   //       borderRadius: BorderRadius.circular(10),
   //     ),
   //     alignment: Alignment.bottomLeft,
   //     child: TextFormField(
   //       controller: _states,
   //       autovalidateMode: AutovalidateMode.onUserInteraction,
   //       textAlignVertical: TextAlignVertical.bottom,
   //       decoration: InputDecoration(
   //           prefixIcon: IconButton(
   //               onPressed: null,
   //               icon: Icon(Icons.location_on, color: Colors.black)),
   //           hintText: "State",
   //           hintStyle: TextStyle(
   //             color: ColorResources.darkgreen,
   //             fontSize: 15,
   //           ),
   //           enabledBorder: OutlineInputBorder(
   //             borderRadius: BorderRadius.circular(10),
   //             borderSide: BorderSide(color: Colors.white, width: 1),
   //           ),
   //           focusedBorder: OutlineInputBorder(
   //             borderRadius: BorderRadius.circular(10),
   //             borderSide: BorderSide(color: Colors.white, width: 1),
   //           ),
   //           errorBorder: OutlineInputBorder(
   //               borderSide: new BorderSide(color: Colors.grey, width: 1),
   //               borderRadius: BorderRadius.circular(10)),
   //           focusedErrorBorder: OutlineInputBorder(
   //               borderSide: new BorderSide(color: Colors.grey, width: 1),
   //               borderRadius: BorderRadius.circular(10)),
   //           border: OutlineInputBorder(
   //               borderSide: new BorderSide(color: Colors.yellow, width: 1),
   //               borderRadius: BorderRadius.circular(10))
   //       ),
   //       validator: (value) {
   //         if (value.trim().isEmpty) {
   //           return "Please, enter your State";
   //         }
   //
   //         return null;
   //       },
   //     ),);
   // }

   _changeCity() {
     return Container(
       decoration: BoxDecoration(
         boxShadow: [
           BoxShadow(
             color: Colors.grey.withOpacity(0.5),
             spreadRadius: 1,
             blurRadius: 5,
             offset: Offset(0, 3),
           ),
         ],
         color: Colors.white,
         borderRadius: BorderRadius.circular(10),
       ),
       alignment: Alignment.bottomLeft,
       child: TextFormField(
         controller: _city,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         textAlignVertical: TextAlignVertical.bottom,
         decoration: InputDecoration(
             prefixIcon: IconButton(
                 onPressed: null,
                 icon: Icon(Icons.location_on, color: Colors.black)),
             hintText: "City",
             hintStyle: TextStyle(
               color: ColorResources.darkgreen,
               fontSize: 15,
             ),
             enabledBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(color: Colors.white, width: 1),
             ),
             focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
               borderSide: BorderSide(color: Colors.white, width: 1),
             ),
             errorBorder: OutlineInputBorder(
                 borderSide: new BorderSide(color: Colors.grey, width: 1),
                 borderRadius: BorderRadius.circular(10)),
             focusedErrorBorder: OutlineInputBorder(
                 borderSide: new BorderSide(color: Colors.grey, width: 1),
                 borderRadius: BorderRadius.circular(10)),
             border: OutlineInputBorder(
                 borderSide: new BorderSide(color: Colors.yellow, width: 1),
                 borderRadius: BorderRadius.circular(10))
         ),
         validator: (value) {
           if (value.trim().isEmpty) {
             return "Please, enter your City";
           }
           return null;
         },
       ),);
   }

  _changelocation() {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _address,
          autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.location_on, color: Colors.black)),
                hintText: "Address",
                hintStyle: TextStyle(
                  color: ColorResources.darkgreen,
                  fontSize: 15,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.yellow, width: 1),
                    borderRadius: BorderRadius.circular(10))),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your Address";
            }
            return null;
          },
        ));
  }

   _changepincode() {
     return Container(
         decoration: BoxDecoration(
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.5),
               spreadRadius: 1,
               blurRadius: 5,
               offset: Offset(0, 3),
             ),
           ],
           color: Colors.white,
           borderRadius: BorderRadius.circular(10),
         ),
         alignment: Alignment.bottomLeft,
         child: TextFormField(
           controller: _pincode,
           keyboardType: TextInputType.number,
           autovalidateMode: AutovalidateMode.onUserInteraction,
           textAlignVertical: TextAlignVertical.bottom,
           decoration: InputDecoration(
               prefixIcon: IconButton(
                   onPressed: null,
                   icon: Icon(Icons.location_on, color: Colors.black)),
               hintText: "Pincode",
               hintStyle: TextStyle(
                 color: ColorResources.darkgreen,
                 fontSize: 15,
               ),

               enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10),
                 borderSide: BorderSide(color: Colors.white, width: 1),
               ),
               focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10),
                 borderSide: BorderSide(color: Colors.white, width: 1),
               ),
               errorBorder: OutlineInputBorder(
                   borderSide: new BorderSide(color: Colors.grey, width: 1),
                   borderRadius: BorderRadius.circular(10)),
               focusedErrorBorder: OutlineInputBorder(
                   borderSide: new BorderSide(color: Colors.grey, width: 1),
                   borderRadius: BorderRadius.circular(10)),
               border: OutlineInputBorder(
                   borderSide: new BorderSide(color: Colors.yellow, width: 1),
                   borderRadius: BorderRadius.circular(10))),
           validator: (value) {
             if (value.trim().isEmpty) {
               return "Please, enter your pincode";
             }
             if (value.length<6 || value.length>6) {
               return "Pincode, must be 6 digit.";
             }

             return null;
           },
         ));
   }


}


// void _showPicker(context) {
//
//   final signupController = Get.put(ProfileController());
//
//   showModalBottomSheet(
//     // enableDrag: false,
//       isDismissible: true,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20)
//       ),
//       context: context,
//       builder: (BuildContext bc) {
//         return SafeArea(
//           child: Container(
//             child: new Wrap(
//               children: <Widget>[
//                 new ListTile(
//                     leading: new Icon(Icons.photo_camera,
//                       size: 35,),
//                     title: new Text('Camera',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600
//                       ),),
//                     onTap: () {
//                       signupController.getImage(ImageSource.camera,context);
//                       Navigator.of(context).pop();
//                     }),
//                 new ListTile(
//                   leading: new Icon(Icons.photo_library,
//                     size: 35,),
//                   title: new Text('Gallery',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600
//                     ),),
//                   onTap: () {
//                     signupController.getImage(ImageSource.gallery,context);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//   );
//
//
//
// }