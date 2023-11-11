import 'package:food_delivery/comman/urls.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:http/http.dart' as http;


class Searchservices{
    Future<List<Products>> getSearchResult(query) async {
    var res = await http.get(Uri.parse("${link}search/$query"));
    if (res.statusCode == 200) {
      var data = productsFromJson(res.body.toString());

      return data;
    }
    return [];
  }

}