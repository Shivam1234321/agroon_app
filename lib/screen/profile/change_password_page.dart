import 'package:agroon/data/provider/authprovider.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/custom_button.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _password = TextEditingController();
  TextEditingController _oldpassword = TextEditingController();
  TextEditingController _confirm_password = TextEditingController();
   String oldPassword;



  bool _isLoad = false;

  void _trySubmit()async{
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoad = true;
      });
      await Provider.of<AuthProvider>(context,listen: false).changePasswordApi(_oldpassword.text,_password.text,_confirm_password.text);
      setState(() {
        _isLoad = false;
      });}}

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
          title: Text(Strings.change_Password,
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                color: ColorResources.darkgreen,
                fontWeight: FontWeight.bold,
                fontFamily: "Ubuntu-Regular",
              )),
          centerTitle: true,
          backgroundColor: Colors.white,
          // actions: [
          //   // IconButton(
          //   //     onPressed: () {
          //   //       // Get.to(WishListPage(),
          //   //       //     transition: Transition.rightToLeftWithFade,
          //   //       //     duration: Duration(milliseconds: 600));
          //   //     },
          //   //     icon: Icon(
          //   //       Icons.favorite_border,
          //   //       color: HexColor("2E43FF"),
          //   //     )),
          //   // IconButton(
          //   //     onPressed: () {
          //   //       // Get.to(CheckOutPage(),
          //   //       //     transition: Transition.rightToLeftWithFade,
          //   //       //     duration: Duration(milliseconds: 600));
          //   //     },
          //   //     icon: Icon(
          //   //       Icons.shopping_bag,
          //   //       color: HexColor("2E43FF"),
          //   //     ))
          // ],
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 15),
                  _logo(),
                  SizedBox(height: 60),
                  _oldpasswordtextfeild(),
                  SizedBox(height: 15),
                  _newpasswordtextfield(),
                  SizedBox(height: 15),
                  _reenterpasswordtextfield(),
                  SizedBox(height: 50),
                  if(_isLoad)
                    CircularProgressIndicator()
                  else InkWell(
                      onTap: () {
                        _trySubmit();
                      },
                      child: CustomButton(
                          text1: "Change password",text2: "", width: 200, height: 50)),

                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        )));
  }

  _logo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              height: 90,
              // width: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Images.logo_image)
                  ))),
        ),

      ],
    );
  }


  _oldpasswordtextfeild() {
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
        height: 50,
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _oldpassword,
            textAlignVertical: TextAlignVertical.bottom,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.lock, color: ColorResources.darkgreen)),
                hintText: Strings.old_password,
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
              return "Please, enter the old password";
            }
            // if (value!=oldPassword) {
            //   return " Old password not match";
            // }
            return null;
          },
        ),);
  }

  _newpasswordtextfield() {
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
        height: 50,
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _password,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.lock, color: ColorResources.darkgreen)),
                hintText: Strings.newpassword,
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
              return "Please, enter the password";
            }
            if (value.trim().length < 8) {
              return "Password should be more then 8 characters";
            }
            return null;
          },
        ),
    );
  }

  _reenterpasswordtextfield() {
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
        height: 50,
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _confirm_password,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.lock, color: ColorResources.darkgreen)),
                hintText: Strings.confirmPassword,
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
              return "Please, enter the confirm password";
            }
            if (value!=_password.text) {
              return "Confirm password not match";
            }
            return null;
          },
        ),);
  }
}
