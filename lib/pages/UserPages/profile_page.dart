import 'package:flutter/material.dart';
import 'package:food_delivery/commanWidget/comman_widget.dart';
import 'package:food_delivery/pages/UserPages/login_page.dart';
import 'package:food_delivery/pages/address/add_address.dart';
import 'package:food_delivery/pages/myOrders/complete_order_page.dart';
import 'package:food_delivery/pages/UserPages/update_profile.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, child) {
      return value.user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(),
              body: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // for (int index = 0;
                        //     index < value.userData.length;
                        //     index++) ...[
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.red,
                        ),
                        Text(
                          value.user!.name!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          value.currentEmail.toString(),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        )
                        //]
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CompleteOrderPage()));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(16)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  size: 24,
                                ),
                                Text("Your Order")
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(16)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.credit_card_outlined,
                                size: 24,
                              ),
                              Text("payment")
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateProfile(data: value.user!)));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(16)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.settings,
                                  size: 24,
                                ),
                                Text("setting")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // for (int index = 0; index < value.userData.length; index++) ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddAddress()));
                        },
                        child: ListTile(
                          title: value.user!.address![0].flatHouseNo == ""
                              ? const Text("Address")
                              : Text(value.user!.address![0].area),
                          subtitle: Text(value.user!.address![0].flatHouseNo),
                          leading: const Icon(Icons.house),
                          trailing:
                              const Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ),
                      //]
                    ],
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: button(
                      context: context,
                      name: "Logout",
                      onPressd: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('email');
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext ctx) =>
                                    const LoginPage()));
                      })),
            );
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // );
    });
  }
}
