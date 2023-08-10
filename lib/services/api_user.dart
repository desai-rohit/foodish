import 'dart:convert';
import 'package:food_delivery/models/add_cart.dart';
import 'package:food_delivery/models/favorite_model.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/models/restaurantList_model.dart';
import 'package:food_delivery/models/current_user_model.dart';
import 'package:food_delivery/models/slideModel.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:http/http.dart' as http;

var link = "https://food-api-sable.vercel.app/";

Future<http.Response> createUser({
  String? name,
  String? gmail,
  String? password,
}) async {
  return await http.post(
    Uri.parse('${link}usercreate'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'gmail': gmail,
      "password": password,
      "address": [
        {
          "lat": "lat",
          "lng": "lng",
          "flat": "flat",
          "area": "area",
          "landmark": "landmark"
        }
      ]
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

getcurrentUser(currentEmail) async {
  var res = await http.get(Uri.parse("${link}user/$currentEmail"));
  if (res.statusCode == 200) {
    var data = userApiFromJson(res.body.toString());
    return data;
  }
}

class ProductsServices {
  Future<List<Products>> getProducts() async {
    var res = await http.get(Uri.parse("${link}list"));
    if (res.statusCode == 200) {
      var data = productsFromJson(res.body.toString());
      return data;
    }
    return [];
  }
}

Future<http.Response> addFavorite(
    productsID, user, image, name, restorantName, price) async {
  return await http.post(
    Uri.parse('${link}favorite'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "productsID": productsID,
      'user': user,
      'image': image,
      'foodname': name,
      'restorant_name': restorantName,
      "price": price
    }),
  );
}

class FavoriteService {
  Future<List<Favorite>> favoriteList(email) async {
    var res = await http.get(Uri.parse("${link}favoritelist/$email"));
    if (res.statusCode == 200) {
      var data = favoriteFromJson(res.body.toString());
      return data;
    }
    return [];
  }
}

Future<http.Response> addcart(productsID, user, image, name, restorantName,
    gmail, price, itemcount, totalprice) async {
  return await http.post(
    Uri.parse('${link}cart'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "productId": productsID,
      'user': user,
      'image': image,
      'name': name,
      'restorant_name': restorantName,
      "restorant_gmail": gmail,
      "price": price.toString(),
      "itemcount": itemcount,
      "totalprice": totalprice
    }),
  );
}

Future<http.Response> updateCart(id, itemcount, totalprice) async {
  return await http.put(
    Uri.parse('${link}cartupdate/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'itemcount': itemcount, "totalprice": totalprice}),
  );
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

Future<http.Response> updateUser(
    {required String gmail,
    String? lat,
    String? lng,
    String? flat,
    String? area,
    String? landmark}) async {
  return await http.put(
    Uri.parse('${link}userupdate/$gmail'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "address": [
        {
          "lat": lat,
          "lng": lng,
          "flatHouseNo": flat,
          "area": area,
          "nearbyLandmark": landmark
        }
      ]
    }),
  );
}

Future<http.Response> order(
    {String? name,
    String? gmail,
    String? password,
    String? lat,
    String? lng,
    String? house,
    String? area,
    String? landmark,
    String? user,
    String? image,
    String? foodname,
    String? restorantName,
    String? restorantGmail,
    String? price,
    String? countTotalPrice,
    String? productid}) async {
  return await http.post(
    Uri.parse('${link}order'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "productsID": productid,
      'username': name,
      'useremail': gmail,
      "image": image,
      "foodname": foodname,
      "restorant_name": restorantName,
      "restorant_gmail": restorantGmail,
      "price": price,
      "countTotalPrice": countTotalPrice,
      "orderaccepted": false,
      "ordership": false,
      "address": {
        "lat": lat,
        "lng": lng,
        "flatHouseNo": house,
        "area": area,
        "nearbyLandmark": landmark,
      }
    }),
  );
}

Future<http.Response> deleteCart(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('${link}cartdelete/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  return response;
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

class ApiServices {
  Future<List<Addcart>> getListaddcart(currentEmail) async {
    var res = await http.get(Uri.parse("${link}cartlist/$currentEmail"));
    if (res.statusCode == 200) {
      var data = addcartFromJson(res.body.toString());

      return data;
    }
    return [];
  }

  Future<List<Products>> getSearchResult(query) async {
    var res = await http.get(Uri.parse("${link}search/$query"));
    if (res.statusCode == 200) {
      var data = productsFromJson(res.body.toString());

      return data;
    }
    return [];
  }

  Future<List<RestaurantListModel>> getrestaurantResult() async {
    var res = await http.get(Uri.parse("${link}restaurantList"));
    if (res.statusCode == 200) {
      var data = restaurantListModelFromJson(res.body.toString());

      return data;
    }
    return [];
  }

  Future<List<Products>> getProductsList({String? gmail}) async {
    var res = await http.get(Uri.parse("${link}products/$gmail"));
    if (res.statusCode == 200) {
      var data = productsFromJson(res.body.toString());
      return data;
    }
    return [];
  }

  Future<List<Products>> getcategoryProductsList(
      {String? gmail, String? category}) async {
    var res = await http.get(Uri.parse("${link}products/$gmail&$category"));
    if (res.statusCode == 200) {
      var data = productsFromJson(res.body.toString());
      return data;
    }
    return [];
  }

  Future<List<OrderModel>> getCompleteOrder(currentEmail) async {
    var res = await http.get(Uri.parse("${link}userorder/$currentEmail"));
    if (res.statusCode == 200) {
      var data = orderModelFromJson(res.body.toString());
      return data;
    }
    return [];
  }

  Future<List<Slidemodel>> sildeImage() async {
    var res = await http.get(Uri.parse("${link}sildeimage"));
    if (res.statusCode == 200) {
      var data = slidemodelFromJson(res.body.toString());

      return data;
    }
    return [];
  }
}

class UserServices {
  Future<CurrentUserModel> getUserData(email) async {
    var res = await http.get(Uri.parse("${link}currentUser/$email"));
    if (res.statusCode == 200) {
      var data = currentUserModelFromJson(res.body.toString());
      return data;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

Future<http.Response> rateing({required String id, String? rateing}) async {
  return await http.put(
    Uri.parse('${link}rateing/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"rateing": rateing!}),
  );
}