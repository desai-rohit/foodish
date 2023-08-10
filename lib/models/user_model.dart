import 'dart:convert';

List<UserApi> userApiFromJson(String str) =>
    List<UserApi>.from(json.decode(str).map((x) => UserApi.fromJson(x)));

String userApiToJson(List<UserApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserApi {
  String id;
  String name;
  String gmail;
  String password;
  List<Address> address;
  int? v;

  UserApi({
    required this.id,
    required this.name,
    required this.gmail,
    required this.password,
    required this.address,
    this.v,
  });

  factory UserApi.fromJson(Map<String, dynamic> json) => UserApi(
        id: json["_id"],
        name: json["name"],
        gmail: json["gmail"],
        password: json["password"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "gmail": gmail,
        "password": password,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "__v": v,
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
