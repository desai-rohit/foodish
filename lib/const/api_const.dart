import 'package:shared_preferences/shared_preferences.dart';

String? currentEmail;

currentuseremail() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  currentEmail = sharedPreferences.getString("email").toString();
}
