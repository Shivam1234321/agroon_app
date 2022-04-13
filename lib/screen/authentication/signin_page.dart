
import 'package:agroon/data/provider/authprovider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/authentication/signup_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/custom_button.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/strings.dart';
import 'package:agroon/utill/styles.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'forgot_password_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() =>
      _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _mobile = TextEditingController();
  final _password = TextEditingController();
  bool rememberMe = false;
  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;
  });

  bool _isLoad = false;
  void _trySubmit()async{
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoad = true;
      });
      await Provider.of<AuthProvider>(context,listen: false).signinApi(_mobile.text,_password.text);
      setState(() {
        _isLoad = false;
      });}}

  bool isChecked = true;

  TextEditingController numbers = TextEditingController();
  TextEditingController phoneCode = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Center(
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                        _logo(),
                        _welcometext(),
                        SizedBox(height: 30),
                        _numberfield(),
                            SizedBox(height: 20),
                            if(_isLoad)
                              CircularProgressIndicator()
                            else
                            _continuebutton(),
                        SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(Strings.create_an_account,
                                    style: TextStyle(
                                      // fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        fontFamily: "Roboto",
                                        letterSpacing: 0.1,
                                        color: ColorResources.black)
                                ),

                                    InkWell(
                                      onTap: (){
                                        Get.to(SignUpPage(),
                                            transition: Transition.rightToLeftWithFade,
                                            duration: Duration(milliseconds: 600));
                                      },
                                      child: Text(Strings.signup,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              fontFamily: "Roboto",
                                              letterSpacing: 0.5,
                                              color: ColorResources.darkgreen)
                                      ),
                                    )
                              ],
                            ),
                            SizedBox(height: 20),
                      ])),
                ))));
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

  _welcometext() {
    return Column(
      children: const [
        SizedBox(height: 90),
        Text(
          Strings.WelcomeBack,
          style: robotoExtraBold,
        ),
        SizedBox(height: 5),
        Text(
          Strings.Login_in_to_your_account,
          style: robotoBold,
        ),
      ],
    );
  }

  _numberfield() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              // height: 50,
              // width: Get.width,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 1),
                child: Row(
                  children: [
                    Container(
                      // height: 45,
                      width: 50,
                      child: Icon(Icons.person),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: 1,
                        controller: _mobile,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter mobile number";
                          } else if (value.length < 10) {
                            return "Mobile number have must be atleast 10 digits";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: "Mobile Number",
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white, width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white, width: 1),
                          ),
                          errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          labelStyle: new TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    // Icon(
                    //   Icons.clear,
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              // height: 50,
              // width: Get.width,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 1),
                child: Row(
                  children: [
                    Container(
                      // height: 45,
                      width: 50,
                      child: Icon(Icons.lock),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText:true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.done,
                        maxLines: 1,
                        controller: _password,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter password";
                          } else if (value.length < 8) {
                            return "Password have must be atleast 8 digits";
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white, width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white, width: 1),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white, width: 1),
                          ),
                          errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          labelStyle: new TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    // Icon(
                    //   Icons.clear,
                    //   color: Colors.grey,
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Row(
                //   children: [
                //     Checkbox(
                //         value: rememberMe,
                //          activeColor: Colors.black,
                //         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                //         onChanged: _onRememberMeChanged
                //     ),
                //     Container(
                //       alignment: Alignment.centerRight,
                //       child: const Text(Strings.RememberMe,
                //           style: TextStyle(
                //               // fontWeight: FontWeight.w600,
                //               fontSize: 14,
                //               fontFamily: "Roboto",
                //               letterSpacing: 0.1,
                //               color: ColorResources.black)
                //       ),
                //     ),
                //   ],
                // ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(onPressed: (){
                    Get.to(ForgotPasswordPage(),
                        transition: Transition.rightToLeftWithFade,
                        duration: Duration(milliseconds: 600));
                  },
                      child: const Text(Strings.Forgot_Password+"?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "Roboto",
                        letterSpacing: 0.5,
                        color: ColorResources.darkgreen)
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  _continuebutton() {
    return GestureDetector(
      onTap: (){
        _trySubmit();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomButton(
            text1: Strings.login, text2: "", width: Get.width, height: 50),
      ),
    );
  }
}
