
import 'package:agroon/data/provider/walkthrow_provider.dart';
import 'package:agroon/screen/authentication/signin_page.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_walkthrough_screen/flutter_walkthrough_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class OnboardingScreen extends StatefulWidget {

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WalkthrowProvider>(context, listen: false).getwalkthrowData();
    Provider.of<WalkthrowProvider>(context, listen: false).getColorsData();
  }


  final List<OnbordingData> list = [
    const OnbordingData(
      fit: BoxFit.contain,
      image: AssetImage("assets/image/onb1.png",
      ),
      titleText:Text("AgroOn",
        style: TextStyle(color: ColorResources.darkgreen,
          letterSpacing: 0.5,
          fontSize: 40.0,
          fontWeight: FontWeight.bold,fontFamily: 'Roboto',),
      ),
      descText: Text("All in one shopping app that provides 100% quality with huge discount and easy shopping app the carrer ads.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black,
           letterSpacing: 0.5,
           fontSize: 16.0,
           fontWeight: FontWeight.bold,fontFamily: 'Roboto',),
         ),
    ),
    const OnbordingData(
      fit: BoxFit.contain,
      image: AssetImage("assets/image/onb2.png"),
      titleText:Text("AgroOn",
        style: TextStyle(color: ColorResources.darkgreen,
          letterSpacing: 0.5,
          fontSize: 40.0,
          fontWeight: FontWeight.bold,fontFamily: 'Roboto',),
      ),
      descText: Text("The career ads endues a secure payment platform and your all credentials information is private with online payment gateway.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black,
          letterSpacing: 0.5,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,fontFamily: 'Roboto',),
      ),
    ),
    const OnbordingData(
      fit: BoxFit.contain,
      image: AssetImage("assets/image/onb3.png"),
      titleText:Text("AgroOn",
        style: TextStyle(color: ColorResources.darkgreen,
          letterSpacing: 0.5,
          fontSize: 40.0,
          fontWeight: FontWeight.bold,fontFamily: 'Roboto',),
      ),
      descText: Text("Customer satisfaction with high quality products that gives a quick delivery option without any delay with 100% free service.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black,
          letterSpacing: 0.5,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,fontFamily: 'Roboto',),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    /* remove the back button in the AppBar is to set automaticallyImplyLeading to false
  here we need to pass the list and the route for the next page to be opened after this. */
    return IntroScreen(
      onbordingDataList: list,
      colors: const [
        //list of colors for per pages
        Colors.white,
        Colors.red,
      ],
      pageRoute: MaterialPageRoute(
        builder: (context) => SignInPage(),
      ),
      nextButton: const Text(
        "NEXT",
        style: TextStyle(
          color: ColorResources.darkgreen,
        ),
      ),
      lastButton: const Text(
        "DONE",
        style: TextStyle(
          color: ColorResources.darkgreen,
        ),
      ),
      skipButton: const Text(
        "SKIP",
        style: TextStyle(
          color: ColorResources.darkgreen,
        ),
      ),

      selectedDotColor: ColorResources.darkgreen,
      unSelectdDotColor: Colors.grey,
    );
  }
}