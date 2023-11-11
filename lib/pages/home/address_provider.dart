import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurantlist_model.dart';
import 'package:food_delivery/pages/home/home_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressProvider extends ChangeNotifier {
  bool isloading = false;

  double? lat;
  double? lng;

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

  final homeservices = Homeservices();
  final Map<String, Marker> markerpont = {};

  Future<void> getRestaurants() async {
    isloading = true;
    notifyListeners();
    final response = await homeservices.getrestaurantResult();
    _restaurantList = response;
    isloading = false;
    notifyListeners();
  }

  latlag(latitude, longitude) {
    lat = latitude;
    lng = longitude;
    notifyListeners();
  }

  void addmarker(String markerid, LatLng location) {
    var marker = Marker(markerId: MarkerId(markerid), position: location);
    markerpont[markerid] = marker;
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
