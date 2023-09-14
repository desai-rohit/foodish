import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurantList_model.dart';
import 'package:food_delivery/services/api_user.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AddressProvider extends ChangeNotifier {
  bool isloading = false;

  double? lat = 0;
  double? lng = 0;

  String street = "";
  String locality = "";
  String sublocality = "";
  String thoroughfare = "";
  String postalCode = "";

  List<RestaurantListModel> _restaurantList = [];
  List<RestaurantListModel> get restaurantListData => _restaurantList;

  String? restauramtGmail;

  double? distanceInMeters;
  double distanceInKm = 0.0;

  TextEditingController addflat = TextEditingController();
  TextEditingController addaera = TextEditingController();
  TextEditingController addlandmark = TextEditingController();

  final _apiServices = ApiServices();

  Future<void> getRestaurants() async {
    isloading = true;
    notifyListeners();
    final response = await _apiServices.getrestaurantResult();
    _restaurantList = response;
    isloading = false;
    notifyListeners();
  }

  latlag(latitude, longitude) {
    lat = latitude;
    lng = longitude;
    notifyListeners();
  }

  addLocation(lat, lng) async {
    isloading = true;
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    Placemark place = placemarks[0];

    street = place.street!;
    locality = place.locality!;
    sublocality = place.subLocality!;
    postalCode = place.postalCode!;

    isloading = false;

    notifyListeners();
  }

  distance(lat1, lng1, lat2, lng2) {
    isloading = true;
    distanceInMeters = Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
    distanceInKm = distanceInMeters! * 0.001;
    isloading = false;
    notifyListeners();
  }
}
