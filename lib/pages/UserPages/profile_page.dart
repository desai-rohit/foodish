import 'package:flutter/material.dart';
import 'package:food_delivery/comman/comman_widget.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/pages/UserPages/login_page.dart';
import 'package:food_delivery/pages/UserPages/login_provider.dart';
import 'package:food_delivery/pages/myOrders/complete_order_page.dart';
import 'package:food_delivery/pages/UserPages/update_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<LoginProvider>(context, listen: false).getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<LoginProvider>(builder: (context, value, child) {
      return value.currentUserModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(),
              body: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.red,
                          ),
                          Text(
                            value.currentUserModel!.name!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            currentEmail.toString(),
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
                              height: height / 6,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    size: 24,
                                  ),
                                  Text(
                                      textAlign: TextAlign.center, "Your Order")
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: height / 6,
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
                                      builder: (context) => UpdateProfile(
                                          data: value.currentUserModel!)));
                            },
                            child: Container(
                              height: height / 6,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                    // Column(
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => const AddAddress()));
                    //       },
                    //       child: ListTile(
                    //         title: value.currentUserModel!.address![0]
                    //                     .flatHouseNo ==
                    //                 ""
                    //             ? const Text("Address")
                    //             : Text(
                    //                 value.currentUserModel!.address![0].area),
                    //         subtitle: Text(value
                    //             .currentUserModel!.address![0].flatHouseNo),
                    //         leading: const Icon(Icons.house),
                    //         trailing:
                    //             const Icon(Icons.arrow_forward_ios_outlined),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: button(
                      width: MediaQuery.of(context).size.width,
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
    });
  }
}
