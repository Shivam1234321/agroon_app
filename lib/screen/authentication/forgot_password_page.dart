
import 'package:agroon/data/provider/authprovider.dart';
import 'package:agroon/screen/authentication/signin_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/custom_button.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'otp_page.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _formKey = GlobalKey<FormState>();

  final _mobile = TextEditingController();

  bool _isLoading = false;
  void _resendOtp()async{
    setState(() {
      _isLoading = true;
    });
    await Provider.of<AuthProvider>(context,listen: false).getOtpApi(_mobile.text);
    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.white,
        appBar: AppBar(
          backgroundColor: ColorResources.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back,
                size: 25,
                color: ColorResources.darkgreen,)),
          title: Text(Strings.Forgot_Password,
            style: TextStyle(color: ColorResources.darkgreen,
              fontWeight: FontWeight.bold,fontFamily: 'Roboto',),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      _logo(),
                      SizedBox(
                        height: 90,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
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
                      ),
                      SizedBox(height: 80),
                     if(_isLoading)
                      CircularProgressIndicator()
                    else
                      InkWell(
                        onTap: (){
                          _resendOtp();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CustomButton(
                              text1: "Get OTP", text2: "", width: Get.width, height: 50),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(height: 2,
                            width: 60,
                            color: Colors.black12),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.black12,
                            child: Text("Or",style: TextStyle(
                              color: ColorResources.black,
                              fontFamily: "Roboto",
                              fontSize: 12
                            ),),
                          ),
                          Container(height: 2,
                            width: 60,
                            color: Colors.black12),
                        ],
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: (){
                          Get.off(() => SignInPage(),
                              transition: Transition.rightToLeftWithFade,
                              duration: const Duration(milliseconds: 600));
                         },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                gradient: LinearGradient(colors: [
                                  Colors.white,
                                  Colors.white,
                                ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 50,
                              width: Get.width,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text("Go to Login",
                                          style: TextStyle(
                                            color: ColorResources.black,
                                            fontSize: 16,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      SizedBox(height: 40,),
                      // _extratext(),

                    ]),
                  ),
                ),
              )),
        ));
  }

  // _extratext(){
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       Text(Strings.text1,
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //         fontFamily: 'Roboto',
  //         fontSize: Dimensions.text_size15,
  //         fontWeight: FontWeight.w600,
  //         letterSpacing: 0.5,
  //         color: AppColors.titleColor
  //       ),
  //       ),
  //       SizedBox(height: Dimensions.sizebox_size20,),
  //       Text(Strings.text2,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //             fontFamily: 'Roboto',
  //             fontSize: Dimensions.text_size15,
  //             fontWeight: FontWeight.w400,
  //             letterSpacing: 0,
  //             color: Colors.grey
  //         ),
  //       ),
  //       SizedBox(height: Dimensions.sizebox_size20,),
  //       Text(Strings.text3,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //             fontFamily: 'Roboto',
  //             fontSize: Dimensions.text_size15,
  //             fontWeight: FontWeight.w600,
  //             letterSpacing: 0.5,
  //             color: AppColors.titleColor
  //         ),
  //       ),
  //     ],
  //
  //   );
  // }

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

}

