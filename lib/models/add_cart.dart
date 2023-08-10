// To parse this JSON data, do
//
//     final addcart = addcartFromJson(jsonString);

import 'dart:convert';

List<Addcart> addcartFromJson(String str) =>
    List<Addcart>.from(json.decode(str).map((x) => Addcart.fromJson(x)));

String addcartToJson(List<Addcart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Addcart {
  String id;
  String productsId;
  String user;
  String image;
  String name;
  String restorantName;
  String restorantGmail;
  String price;
  String itemcount;
  String totalprice;
  int v;

  Addcart({
    required this.id,
    required this.productsId,
    required this.user,
    required this.image,
    required this.name,
    required this.restorantName,
    required this.restorantGmail,
    required this.price,
    required this.itemcount,
    required this.totalprice,
    required this.v,
  });

  factory Addcart.fromJson(Map<String, dynamic> json) => Addcart(
        id: json["_id"],
        productsId: json["productId"],
        user: json["user"],
        image: json["image"],
        name: json["name"],
        restorantName: json["restorant_name"],
        restorantGmail: json["restorant_gmail"],
        price: json["price"],
        itemcount: json["itemcount"],
        totalprice: json["totalprice"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productsID": productsId,
        "user": user,
        "image": image,
        "name": name,
        "restorant_name": restorantName,
        "restorant_gmail": restorantName,
        "price": price,
        "itemcount": itemcount,
        "totalprice": totalprice,
        "__v": v,
      };
}
