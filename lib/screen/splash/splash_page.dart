
import 'package:agroon/data/provider/walkthrow_provider.dart';
import 'package:agroon/data/repository/walkthrow_repo/walkthrow_repo.dart';
import 'package:agroon/screen/Onboarding/onboardingScreen.dart';
import 'package:agroon/utill/color_resources.dart';
import 'package:agroon/utill/images.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      body: AnimatedSplashScreen(
        splash: Image.asset(
          Images.logo_image,
        ),
        nextScreen: OnboardingScreen(),
        // nextScreen: BottomNavigationBarPage(),
        splashTransition: SplashTransition.sizeTransition,
        backgroundColor: ColorResources.dash,
        duration: 700,
      ),
    );
  }
}
