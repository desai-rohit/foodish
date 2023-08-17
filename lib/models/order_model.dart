// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  String id;
  String productsId;
  String username;
  String useremail;
  String image;
  String foodname;
  String rating;
  String restorantName;
  String price;
  String countTotalPrice;
  List<Address> address;
  int v;
  String restorantGmail;
  bool ordership;
  bool orderaccepted;

  OrderModel(
      {required this.id,
      required this.productsId,
      required this.username,
      required this.useremail,
      required this.image,
      required this.foodname,
      required this.rating,
      required this.restorantName,
      required this.price,
      required this.countTotalPrice,
      required this.address,
      required this.v,
      required this.restorantGmail,
      required this.ordership,
      required this.orderaccepted});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      id: json["_id"],
      productsId: json["productsID"],
      username: json["username"],
      useremail: json["useremail"],
      image: json["image"],
      foodname: json["foodname"],
      rating: json["rating"],
      restorantName: json["restorant_name"],
      price: json["price"],
      countTotalPrice: json["countTotalPrice"],
      address:
          List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
      v: json["__v"],
      restorantGmail: json["restorant_gmail"],
      ordership: json["ordership"],
      orderaccepted: json["orderaccepted"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productsID": productsId,
        "username": username,
        "useremail": useremail,
        "image": image,
        "foodname": foodname,
        "rateing": rating,
        "restorant_name": restorantName,
        "price": price,
        "countTotalPrice": countTotalPrice,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "__v": v,
        "restorant_gmail": restorantGmail,
        "ordership": ordership,
        "orderaccepted": orderaccepted
      };
}

class Address {
  String lat;
  String lng;
  String flatHouseNo;
  String area;
  String nearbyLandmark;
  String id;

  Address({
    required this.lat,
    required this.lng,
    required this.flatHouseNo,
    required this.area,
    required this.nearbyLandmark,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        lat: json["lat"],
        lng: json["lng"],
        flatHouseNo: json["flatHouseNo"],
        area: json["area"],
        nearbyLandmark: json["nearbyLandmark"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "flatHouseNo": flatHouseNo,
        "area": area,
        "nearbyLandmark": nearbyLandmark,
        "_id": id,
      };
}
