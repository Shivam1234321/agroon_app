import 'package:agroon/data/provider/addressProvider.dart';
import 'package:agroon/data/provider/authprovider.dart';
import 'package:agroon/data/provider/cartProvider.dart';
import 'package:agroon/data/provider/productprovider.dart';
import 'package:agroon/data/provider/webViewProvider.dart';
import 'package:agroon/data/provider/wishlistProvider.dart';
import 'package:agroon/data/repository/address_repo/address_repo.dart';
import 'package:agroon/data/repository/auth_repo/auth_repo.dart';
import 'package:agroon/data/repository/cart_repo/cart_repo.dart';
import 'package:agroon/data/repository/category_repo/category_repo.dart';
import 'package:agroon/data/repository/product_repo/product_repo.dart';
import 'package:agroon/data/repository/profile_repo/profile_repo.dart';
import 'package:agroon/data/repository/walkthrow_repo/walkthrow_repo.dart';
import 'package:agroon/data/repository/wevView_repo/webView_repo.dart';
import 'package:agroon/data/repository/wishlist_repo/wishlist_repo.dart';
import 'package:agroon/utill/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/provider/categoryprovider.dart';
import 'data/provider/profileprovider.dart';
import 'data/provider/walkthrow_provider.dart';



final sl = GetIt.instance;

Future<void> init() async {

  sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));
  // Repository
  sl.registerLazySingleton(() => WalkthrowRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CartRepo(dioClient: sl()));
  sl.registerLazySingleton(() => AddressRepo(dioClient: sl()));
  sl.registerLazySingleton(() => WishlistRepo(dioClient: sl()));
  sl.registerLazySingleton(() => WebViewRepo(dioClient: sl()));


  // Provider
  sl.registerFactory(() => WalkthrowProvider(walkthrowRepo: sl()));
  sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => ProductProvider(productRepo: sl()));
  sl.registerFactory(() => CartProvider(cartRepo: sl()));
  sl.registerFactory(() => AddressProvider(addressRepo: sl()));
  sl.registerFactory(() => WishlistProvider(wishlistRepo: sl()));
  sl.registerFactory(() => WebViewProvider(webViewRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}