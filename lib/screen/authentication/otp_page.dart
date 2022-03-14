import 'dart:async';

import 'package:agroon/data/provider/authprovider.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/custom_button.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';


class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();

  var pincode ;
  bool _isLoad = false;

  String getOTP = Get.arguments;

  void _trySubmit()async{
    if(pincode!=null){
      setState(() {
        _isLoad = true;
      });
      await Provider.of<AuthProvider>(context,listen: false).otpVerifyApi(pincode);
      setState(() {
        _isLoad = false;
      });
    }
  }

  bool _isLoading = false;
  void _resendOtp()async{
    setState(() {
      _isLoading = true;
    });
    await Provider.of<AuthProvider>(context,listen: false).resendOtpApi();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 60,),
                _logo(),
                SizedBox(height: 50,),
                _welcometext(),
                SizedBox(height: 35,),
                _otpfield(),
                SizedBox(height: 50),
                if(_isLoad)
                  CircularProgressIndicator()
                else
                  GestureDetector(
                  onTap: (){
                    _trySubmit();
                    },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomButton(
                        text1: "Submit", text2: "", width: Get.width, height: 50),
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
                if(_isLoading)
                  CircularProgressIndicator()
                else
                GestureDetector(
                  onTap: (){
                    _resendOtp();
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
                                child: Text("Resend OTP",
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
              ],
            ),
          ),
        ));
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
    return Text(Strings.OTPtext,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          color: ColorResources.darkgreen
      ),
    );
  }

  _otpfield() {
    return Form(
      child: OTPTextField(
        length: 6,
        width: MediaQuery.of(context).size.width,
        fieldWidth: 40,
        style: TextStyle(
            fontSize: 16
        ),
        textFieldAlignment: MainAxisAlignment.spaceEvenly,
        fieldStyle: FieldStyle.underline,
        onChanged: (pin) {
          print("Changed: " + pin);
        },
        onCompleted: (pin) {
          pincode=pin;
          print("Completed: " + pin);
          print("pincode"+pincode);
        },
      ),
    );
  }
}
