import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/UserPages/auth_services.dart';
import 'package:food_delivery/pages/UserPages/login_page.dart';
import 'package:food_delivery/pages/UserPages/login_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                "Resistor",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 99, 245)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenheight / 2.5),
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                TextFormField(
                  controller: provider.namecontroller,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32))),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    prefixIcon: const Icon(Icons.account_circle),
                    label: const Text("Name"),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: provider.gmailcontroller,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32))),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    prefixIcon: const Icon(Icons.email),
                    label: const Text("Email"),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: provider.passworController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimary),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32))),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    prefixIcon: const Icon(Icons.lock),
                    label: const Text("Password"),
                  ),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8, bottom: 10),
              alignment: Alignment.bottomLeft,
              child: RichText(
                  text: TextSpan(
                      text: "Alredy Account? ",
                      style: const TextStyle(),
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage())),
                        text: 'Login',
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
                       Authservices().usersignup(
                                name: provider.namecontroller.text,
                                gmail: provider.gmailcontroller.text,
                                password: provider.passworController.text,
                                context: context)
                            .then((value) {
                          provider.namecontroller.clear();
                          provider.gmailcontroller.clear();
                          provider.passworController.clear();
                        });
                      },
                      child: const Text("Register")),
                ))
          ],
        );
      }),
    );
  }
}
