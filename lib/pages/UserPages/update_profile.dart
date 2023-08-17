import 'package:flutter/material.dart';
import 'package:food_delivery/commanWidget/comman_widget.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:food_delivery/services/api_user.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UpdateProfile extends StatefulWidget {
  dynamic data;
  UpdateProfile({super.key, required this.data});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    TextEditingController updateNameController =
        TextEditingController(text: widget.data.name);
    TextEditingController updateGmailController =
        TextEditingController(text: widget.data.gmail);
    TextEditingController updatePasswordController = TextEditingController();

    setState(() {
      updateGmailController;
      updateNameController;
      updatePasswordController;
    });

    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UserProvider>(
        builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  controller: updateNameController,
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
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  controller: updateGmailController,
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
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  controller: updatePasswordController,
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
                      label: const Text("Enter Password")),
                ),
                const SizedBox(
                  height: 24,
                ),
                button(
                    context: context,
                    name: "Update",
                    onPressd: () {
                      if (widget.data.password ==
                          updatePasswordController.text) {
                        updateUserName(
                            gmail: value.currentEmail.toString(),
                            name: updateNameController.text,
                            email: updateGmailController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Password Worang")));
                      }
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
