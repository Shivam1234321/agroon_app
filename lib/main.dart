import 'package:agroon/data/provider/addressProvider.dart';
import 'package:agroon/data/provider/cartProvider.dart';
import 'package:agroon/data/provider/productprovider.dart';
import 'package:agroon/data/provider/webViewProvider.dart';
import 'package:agroon/data/provider/wishlistProvider.dart';
import 'package:agroon/screen/Dashboard/Home/homeScreen.dart';
import 'package:agroon/screen/Dashboard/bottom_navigation_bar_page.dart';
import 'package:agroon/screen/splash/splash_page.dart';
import 'package:agroon/utill/sharedprefrence.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'data/provider/authprovider.dart';
import 'data/provider/categoryprovider.dart';
import 'data/provider/profileprovider.dart';
import 'data/provider/walkthrow_provider.dart';
import 'di_container.dart' as di;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true; // Set this flag.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await di.init();
  Widget _default = new MyApp();
  bool status = await SharedPrefManager.getBooleanPreferences() != null;
  if(status == true) {
    _default = BottomNavigationBarPage();
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<WalkthrowProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CategoryProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProductProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AddressProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WishlistProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<WebViewProvider>()),
    ],child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: _default,
    ),
   )
  );
}

class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SplashPage(),
    );
  }
}