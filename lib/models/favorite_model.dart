// To parse this JSON data, do
//
//     final favorite = favoriteFromJson(jsonString);

import 'dart:convert';

List<Favorite> favoriteFromJson(String str) =>
    List<Favorite>.from(json.decode(str).map((x) => Favorite.fromJson(x)));

String favoriteToJson(List<Favorite> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Favorite {
  String id;
  String productsId;
  String user;
  String image;
  String name;
  String restorantName;
  String price;
  int v;

  Favorite({
    required this.id,
    required this.productsId,
    required this.user,
    required this.image,
    required this.name,
    required this.restorantName,
    required this.price,
    required this.v,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["_id"],
        productsId: json["productsID"],
        user: json["user"],
        image: json["image"],
        name: json["foodname"],
        restorantName: json["restorant_name"],
        price: json["price"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productsID": productsId,
        "user": user,
        "image": image,
        "name": name,
        "restorant_name": restorantName,
        "price": price,
        "__v": v,
      };
}
