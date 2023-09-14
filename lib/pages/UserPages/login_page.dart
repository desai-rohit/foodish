import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/UserPages/login_provider.dart';
import 'package:food_delivery/pages/UserPages/register_page.dart';
import 'package:food_delivery/services/api_user.dart';

import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;

    return Form(
      // key: formKey,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Consumer<LoginProvider>(builder: (context, provider, child) {
            return Stack(
              children: [
                Image.asset(
                  "assets/images/login.png",
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/images/login2.png",
                    height: MediaQuery.of(context).size.height / 6,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: screenheight / 4.5),
                  padding: const EdgeInsets.only(left: 24),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 1, 99, 245)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: screenheight / 2.5),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: provider.logingmailcontroller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))),
                          prefixIcon: Icon(Icons.email),
                          label: Text(
                            "Email",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        controller: provider.loginpassworController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))),
                          prefixIcon: Icon(Icons.lock),
                          label: Text("Password"),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: RichText(
                            text: TextSpan(
                                text: "Forget Password? ",
                                style: const TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage())),
                                  text: 'Forget',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue))
                            ])),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8, bottom: 10),
                  alignment: Alignment.bottomLeft,
                  child: RichText(
                      text: TextSpan(
                          text: "New Hare? ",
                          style: const TextStyle(),
                          children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage())),
                            text: 'Register',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white))
                      ])),
                ),
                Container(
                    padding: const EdgeInsets.only(right: 8),
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 0,
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            userlogin(
                                gmail: provider.logingmailcontroller.text,
                                password: provider.loginpassworController.text,
                                context: context);
                          },
                          child: const Text("Login")),
                    )),
              ],
            );
          })),
    );
  }
}
