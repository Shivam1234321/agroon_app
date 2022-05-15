import 'package:agroon/data/provider/addressProvider.dart';
import 'package:agroon/data/provider/cartProvider.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({Key key}) : super(key: key);

  @override
  _AddNewAddressPageState createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _distController = TextEditingController();
  TextEditingController _zipcodeController = TextEditingController();

  bool _isLoad = false;
  bool isLoad = false;

  void _trySubmit()async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoad = true;
      });
      await Provider.of<AddressProvider>(context,listen: false).addAddressapi(_nameController.text, _mobileController.text, _addressController.text,_cityController.text,_landmarkController.text,_zipcodeController.text);
      setState(() {
        _isLoad = false;
      });
    }
    await Provider.of<AddressProvider>(context, listen: false).getshowAddressData();
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
              icon: Icon(Icons.keyboard_arrow_left_outlined,
                  color: ColorResources.darkgreen, size: 28)),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text("Add new address",
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
                  // Get.to(CheckOutPage(),
                  //     transition: Transition.rightToLeftWithFade,
                  //     duration: Duration(milliseconds: 600));
                },
                icon: Icon(Icons.notifications, size: 30,color: ColorResources.darkgreen,)),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  _headings(),
                  SizedBox(height: 40),
                  _nametextfield(),
                  SizedBox(height: 20),
                  _mobilenumbertextfield(),
                  SizedBox(height: 20,),
                  _addresstextfield(),
                  SizedBox(height: 20),
                  _citytextfield(),
                  SizedBox(height: 20),
                  _landmarktextfield(),
                  SizedBox(height: 20),
                  _zipcodetextfield(),
                  SizedBox(height: 50),
                  if(_isLoad)
                    Center(child: CircularProgressIndicator())
                  else _saveaddressbutton(),
                ],
              ),
            ),
          ),
        )));
  }

  _headings() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(" New Address",
          style: TextStyle(
            fontSize: 20,
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
            fontFamily: "Ubuntu-Regular",
          )),
      SizedBox(
        height: 15,
      ),
      Text(" Note: All field are mandatory.*",
          style: TextStyle(
            fontSize: 12,
            color: Colors.red,
            fontWeight: FontWeight.w400,
            fontFamily: "Ubuntu-Regular",
          )),
    ]);
  }

  _nametextfield() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _nameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              hintMaxLines: 3,
              hintText: "Name",
              hintStyle: TextStyle(
                color: ColorResources.black,
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
              return "Please, enter your Name";
            }

            return null;
          },
        ));
  }
  _addresstextfield() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _addressController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                hintMaxLines: 3,
                hintText: "Address",
                hintStyle: TextStyle(
                  color: ColorResources.black,
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

  _landmarktextfield() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _landmarkController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                hintMaxLines: 3,
                hintText: "Land Mark",
                hintStyle: TextStyle(
                  color: ColorResources.black,
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
              return "Please, enter your Land Mark";
            }

            return null;
          },
        ));
  }

  _citytextfield() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _cityController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                hintMaxLines: 3,
                hintText: "City",
                hintStyle: TextStyle(
                  color: ColorResources.black,
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
              return "Please, enter your City";
            }

            return null;
          },
        ));
  }

  _disttextfield() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _distController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              hintMaxLines: 3,
              hintText: "District",
              hintStyle: TextStyle(
                color: ColorResources.black,
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
              return "Please, enter your District";
            }

            return null;
          },
        ));
  }

  _mobilenumbertextfield() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          controller: _mobileController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.phone,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                hintMaxLines: 3,
                hintText: "Mobile Number",
                hintStyle: TextStyle(
                  color: ColorResources.black,
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
              return "Please, enter your Mobile number";
            }

            return null;
          },
        ),
    );
  }

  _zipcodetextfield() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.bottomLeft,
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: _zipcodeController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                hintMaxLines: 3,
                hintText: "Pincode",
                hintStyle: TextStyle(
                  color: ColorResources.black,
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
              return "Please, enter your Pincode";
            }
            if (value.length<6 || value.length>6) {
              return "Pincode must be 6 digit only.";
            }

            return null;
          },
        ));
  }



  _saveaddressbutton() {
    return InkWell(
        onTap: () {
          _trySubmit();
        },
        child: Center(
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 50,
              width: Get.width,
              child: Center(
                child: Text("Save Address",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold)),
              )),
        ));
  }
}
