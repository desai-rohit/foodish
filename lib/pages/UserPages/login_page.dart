import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/commanWidget/comman_widget.dart';
import 'package:food_delivery/pages/UserPages/register_page.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:food_delivery/services/api_user.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Future userapi;

  // @override
  // void initState() {
  //   super.initState();
  //   // userapi = getUser();
  //   getUser();
  // }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Scaffold(
          appBar: AppBar(),
          body: Consumer<UserProvider>(builder: (context, provider, child) {
            return FutureBuilder(
              future: getUser(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  //List<UserApi> data = snapshot.data;
                  provider.data = snapshot.data;
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Email Address";
                              }
                              return null;
                            },
                            controller: provider.logingmailcontroller,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(32))),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32))),
                              prefixIcon: const Icon(Icons.email),
                              label: const Text(
                                "Email",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Password";
                              }
                              return null;
                            },
                            controller: provider.loginpassworController,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(32))),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32))),
                              prefixIcon: const Icon(Icons.lock),
                              label: const Text("Password"),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          button(
                              context: context,
                              name: "Login",
                              onPressd: () {
                                for (var i = 0; i < provider.data.length; i++) {
                                  if (provider.logingmailcontroller.text ==
                                          provider.data[i].gmail &&
                                      provider.loginpassworController.text ==
                                          provider.data[i].password) {
                                    provider.userloginSharedPrefrance(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Email And Password Check Please')),
                                    );
                                    break;
                                  }
                                }
                              }),
                          const SizedBox(
                            height: 16,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "You Have No Account ",
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterPage())),
                                    text: 'Create Account',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue))
                              ]))
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          })),
    );
  }
}
