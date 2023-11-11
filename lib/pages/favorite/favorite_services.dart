import 'package:food_delivery/comman/urls.dart';
import 'package:food_delivery/models/favorite_model.dart';
import 'package:http/http.dart' as http;


class Favoriteservice {
  Future<List<Favorite>> favoriteList(email) async {
    var res = await http.get(Uri.parse("${link}favoritelist/$email"));
    if (res.statusCode == 200) {
      var data = favoriteFromJson(res.body.toString());
      return data;
    }
    return [];
  }

  Future<http.Response> favoritedelete(id) async {
  final http.Response response = await http.delete(
    Uri.parse('${link}favoritedelete/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
}
}