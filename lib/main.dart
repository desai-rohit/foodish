import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/config/my_theme.dart';
import 'package:food_delivery/pages/UserPages/login_page.dart';
import 'package:food_delivery/pages/otherPages/bottom_nav/bottom_nav.dart';
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

    super.initState();
  }

  Future getValidationdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String email = sharedPreferences.getString("email").toString();
    // ignore: use_build_context_synchronously
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    //await provider.emailadd(email);
    await provider.emailadd(email);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          return Consumer<UserProvider>(builder: (context, value, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.system,
              home: snapshot.data == ConnectivityResult.none
                  ? Scaffold(
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Lottie.asset(
                              'assets/animation/no_internet.json',
                              width: 250,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Text(
                            textAlign: TextAlign.center,
                            "Please Check Internet Connection",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : value.currentEmail == null
                      ? const LoginPage()
                      : const BottomNav(),
            );
          });
        });
  }
}
