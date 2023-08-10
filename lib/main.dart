import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/config/golbal.dart';
import 'package:food_delivery/config/my_theme.dart';
import 'package:food_delivery/pages/otherPages/bottom_nav/bottom_nav.dart';
import 'package:food_delivery/pages/UserPages/login_page.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    getValidationdata();
    networkcheck();

    super.initState();
  }

  Future networkcheck() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      // I am connected to a ethernet network.
    } else if (connectivityResult == ConnectivityResult.vpn) {
      // I am connected to a vpn network.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
      // I am connected to a bluetooth.
    } else if (connectivityResult == ConnectivityResult.other) {
      // I am connected to a network which is not in the above mentioned networks.
    } else if (connectivityResult == ConnectivityResult.none) {
      // I am not connected to any network.
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/animation/internet.json',
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          const Text(
            "Favorite List Empty",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      );
    }
  }

  Future getValidationdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String email = sharedPreferences.getString("email").toString();
    // ignore: use_build_context_synchronously
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    provider.emailadd(email);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: currentEmail == null ? const LoginPage() : const BottomNav(),
      );
    });
  }
}
