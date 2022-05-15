import 'package:agroon/data/provider/authprovider.dart';
import 'package:agroon/screen/authentication/signin_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/custom_button.dart';
import 'package:agroon/utill/email_validation.dart';
import 'package:agroon/utill/images.dart';
import 'package:agroon/utill/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _shopnameController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  TextEditingController _gstController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  bool _isLoad = false;

  void _trySubmit()async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoad = true;
      });
      await Provider.of<AuthProvider>(context,listen: false).registerApi(_nameController.text, _shopnameController.text,_landmarkController.text, _emailController.text, _phonenumberController.text,_gstController.text,_stateController.text,_cityController.text,_addressController.text,_pincodeController.text,_passwordController.text,_confirmpasswordController.text);
      setState(() {
        _isLoad = false;
      });

    }

  }
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorResources.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                        _logo(),
                      SizedBox(height: 10,),
                      _fullnametextfeild(),
                      _shopnametextfield(),
                      _landmarktextfield(),
                      _emailaddresstextfield(),
                      _mobilenumbertextfield(),
                      _gsttextfield(),
                      _adresstextfield(),
                      _citytextfield(),
                      _statetextfield(),
                      _pincodetextfield(),
                      _passwordtextfield(),
                      _confirmpasswordtextfield(),



                      SizedBox(height: 30,),
                      if(_isLoad)
                        CircularProgressIndicator()
                      else
                        _signupbutton(),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
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

  _fullnametextfeild() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          controller: _nameController,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Name',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your full name";
            }

            return null;
          },
        ),
      ),
    );
  }

  _shopnametextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          controller: _shopnameController,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Firm Name',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your Firm Name";
            }

            return null;
          },
        ),
      ),
    );
  }

  _landmarktextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          controller: _landmarkController,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Landmark',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your landmark";
            }

            return null;
          },
        ),
      ),
    );
  }

  _emailaddresstextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Email ID',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) => validateEmail(value),
        ),
      ),
    );
  }

  _mobilenumbertextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          controller: _phonenumberController,
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Mobile No.',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your Mobile number";
            }
            if(value.length<10 || value.length>10){
              return "Mobile number be 10 digit only.";
            }

            return null;
          },
        ),
      ),
    );
  }

  _gsttextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          controller: _gstController,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'GST No.',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your GST number";
            }

            return null;
          },
        ),
      ),
    );
  }

  _citytextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          controller: _cityController,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'City',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your city";
            }

            return null;
          },
        ),
      ),
    );
  }

  _statetextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          controller: _stateController,
          keyboardType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'State',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your state";
            }

            return null;
          },
        ),
      ),
    );
  }

  _pincodetextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          controller: _pincodeController,
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Pincode',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your pincode"+value.length.toString();
            }
            if(value.length<6 || value.length>6){
              return "Pincode be 6 digit only.";
            }

            return null;
          },
        ),
      ),
    );
  }

  _adresstextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          minLines: 2,
          controller: _addressController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Address',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your address";
            }

            return null;
          },
        ),
      ),
    );
  }

  _sttextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          minLines: 2,
          controller: _addressController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Address',
            labelStyle: TextStyle(
              color: ColorResources.darkgreen,
            ),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter your address";
            }

            return null;
          },
        ),
      ),
    );
  }

  _passwordtextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          obscuringCharacter: "*",
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _passwordController,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Password',
            labelStyle: TextStyle(color: ColorResources.darkgreen),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter the password";
            }
            if (value.trim().length < 8) {
              return "Password should be more then 5 characters";
            }
            return null;
          },
        ),
      ),
    );
  }

  _confirmpasswordtextfield() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextFormField(
          obscuringCharacter: "*",
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _confirmpasswordController,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            errorBorder: new OutlineInputBorder(borderSide: BorderSide.none),
            labelText: 'Confirm Password',
            labelStyle: TextStyle(color: ColorResources.darkgreen),
            errorStyle: TextStyle(color: ColorResources.errorColor),
          ),
          validator: (value) {
            if (value.trim().isEmpty) {
              return "Please, enter the Confirm password";
            }
            if (value.trim().length < 8) {
              return "Confirm Password not match";
            }
            return null;
          },
        ),
      ),
    );
  }

  _signupbutton() {
    return GestureDetector(
      onTap: (){
        _trySubmit();
        },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomButton(
            text1: Strings.sign_up, text2: "", width: Get.width, height: 50),
      ),
    );
  }
}
