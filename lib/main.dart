import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/mytheme/my_theme.dart';
import 'package:food_delivery/pages/UserPages/login_provider.dart';
import 'package:food_delivery/pages/cart/cart_provider.dart';
import 'package:food_delivery/pages/favorite/favorite_provider.dart';
import 'package:food_delivery/pages/home/address_provider.dart';
import 'package:food_delivery/pages/home/home_provider.dart';
import 'package:food_delivery/pages/myOrders/myorder_provider.dart';
import 'package:food_delivery/pages/orderpage/orderpage_provider.dart';
import 'package:food_delivery/pages/search/searchprovider.dart';
import 'package:food_delivery/pages/payment/payment_provider.dart';
import 'package:food_delivery/pages/spalshscreen/splash_screen.dart';
import 'package:food_delivery/provider/provider_internet.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => AddressProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(create: (_) => FavoriteProvider()),
    ChangeNotifierProvider(create: (_) => MyOrderProvider()),
    ChangeNotifierProvider(create: (_) => OrderPageProvidr()),
    ChangeNotifierProvider(create: (_) => SearchProvider()),
    ChangeNotifierProvider(create: (_) => PaymentProvider()),
    ChangeNotifierProvider(create: (_) => LoginProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(create: (_) => ProviderInternet()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getValidationdata();
    currentuseremail();

    super.initState();
  }

  Future getValidationdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String email = sharedPreferences.getString("email").toString();
    // ignore: use_build_context_synchronously
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    await provider.emailadd(email);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeMode.system,
        home: const SpalshScreen());
  }
}
