import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/models/current_user_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/pages/UserPages/login_page.dart';
import 'package:food_delivery/pages/UserPages/login_provider.dart';
import 'package:food_delivery/pages/bottom_nav/bottom_nav.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class Authservices{
   var link = "https://food-api-nu.vercel.app/";
  Future<CurrentUserModel> getUserData(email) async {
    var res = await http.get(Uri.parse("${link}user/$email"));
    if (res.body.isNotEmpty) {
      var data = currentUserModelFromJson(res.body);
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<http.Response> updateUserName({
  required String gmail,
  String? name,
  String? email,
}) async {
  return await http.put(
    Uri.parse('${link}userupdate/$gmail'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "name": name,
      "gmail": email,
    }),
  );
}
 getUser() async {
    var res = await http.get(Uri.parse("${link}userlist"));
    if (res.statusCode == 200) {
      var data = userApiFromJson(res.body.toString());
      return data;
    }
  }

  Future<Object> userlogin(
    {required String gmail, required String password, context}) async {
  var response = await http.post(
    Uri.parse('${link}login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "gmail": gmail,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    Provider.of<LoginProvider>(context, listen: false)
        .userloginSharedPrefrance(context);
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomNav()));
  } else if (response.statusCode == 400) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("worng password")));
  } else {
    return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("worng email and password")));
  }
}

Future<Object> usersignup(
    {required String name,
    required String gmail,
    required String password,
    required context}) async {
  var response = await http.post(
    Uri.parse('${link}signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'gmail': gmail,
      "password": password,
      "address": [
        {
          "lat": "",
          "lng": "",
          "flatHouseNo": "",
          "area": "",
          "nearbyLandmark": ""
        }
      ]
    }),
  );
  if (response.body == "user already exists") {
    return ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("User Already exists")));
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
    return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Create Successfully")));
  }
}

}