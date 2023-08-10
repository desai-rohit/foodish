import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/commanWidget/comman_widget.dart';
import 'package:food_delivery/pages/UserPages/login_page.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:food_delivery/services/api_user.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UserProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
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
                  height: 16,
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
                  height: 16,
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
                const SizedBox(
                  height: 24,
                ),
                button(
                    context: context,
                    name: "Create Accout",
                    onPressd: () {
                      for (var i = 0; i < provider.data.length; i++) {
                        if (provider.data[i].gmail ==
                            provider.gmailcontroller.text) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("This Email Alredy Resistor")));
                        } else {
                          FocusManager.instance.primaryFocus?.unfocus();

                          createUser(
                            name: provider.namecontroller.text.toString(),
                            gmail: provider.gmailcontroller.text.toString(),
                            password:
                                provider.passworController.text.toString(),
                          ).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Account Created")));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ));

                            provider.namecontroller.text = "";
                            provider.gmailcontroller.text = "";
                            provider.passworController.text = "";
                          });
                          break;
                        }
                      }
                    }),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                    text: TextSpan(
                        text: "Alredy Have An Account ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage())),
                          text: 'Login',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue))
                    ]))
              ],
            ),
          ),
        );
      }),
    );
  }
}
