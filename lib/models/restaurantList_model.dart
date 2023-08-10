import 'dart:convert';

List<RestaurantListModel> restaurantListModelFromJson(String str) =>
    List<RestaurantListModel>.from(
        json.decode(str).map((x) => RestaurantListModel.fromJson(x)));

String restaurantListModelToJson(List<RestaurantListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantListModel {
  String id;
  String ownersName;
  String restaurantName;
  String openTimeing;
  String closeTimeing;
  String gmail;
  String password;
  List<Address> address;
  int v;

  RestaurantListModel({
    required this.id,
    required this.ownersName,
    required this.restaurantName,
    required this.openTimeing,
    required this.closeTimeing,
    required this.gmail,
    required this.password,
    required this.address,
    required this.v,
  });

  factory RestaurantListModel.fromJson(Map<String, dynamic> json) =>
      RestaurantListModel(
        id: json["_id"],
        ownersName: json["ownersName"],
        restaurantName: json["restaurantName"],
        openTimeing: json["openTimeing"],
        closeTimeing: json["closeTimeing"],
        gmail: json["gmail"],
        password: json["password"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ownersName": ownersName,
        "restaurantName": restaurantName,
        "openTimeing": openTimeing,
        "closeTimeing": closeTimeing,
        "gmail": gmail,
        "password": password,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "__v": v,
      };
}

class Address {
  String lat;
  String lng;
  String area;
  String nearbyLandmark;
  String id;
  String dis;
  String tal;

  Address({
    required this.lat,
    required this.lng,
    required this.area,
    required this.nearbyLandmark,
    required this.id,
    required this.dis,
    required this.tal,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        lat: json["lat"],
        lng: json["lng"],
        area: json["area"],
        nearbyLandmark: json["nearbyLandmark"],
        id: json["_id"],
        dis: json["dis"],
        tal: json["tal"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "area": area,
        "nearbyLandmark": nearbyLandmark,
        "_id": id,
        "dis": dis,
        "tal": tal,
      };
}
