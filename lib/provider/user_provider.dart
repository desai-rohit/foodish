import 'package:flutter/material.dart';
import 'package:food_delivery/config/golbal.dart';
import 'package:food_delivery/models/add_cart.dart';
import 'package:food_delivery/models/favorite_model.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/models/restaurantList_model.dart';
import 'package:food_delivery/models/current_user_model.dart';
import 'package:food_delivery/models/slideModel.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/pages/otherPages/bottom_nav/bottom_nav.dart';
import 'package:food_delivery/services/api_user.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  //signup page controller
  TextEditingController namecontroller = TextEditingController();
  TextEditingController gmailcontroller = TextEditingController();
  TextEditingController passworController = TextEditingController();

  //login page controller
  TextEditingController loginpassworController = TextEditingController();
  TextEditingController logingmailcontroller = TextEditingController();

  //address page controller
  TextEditingController addflat = TextEditingController();
  TextEditingController addaera = TextEditingController();
  TextEditingController addlandmark = TextEditingController();

  //search controller
  TextEditingController searchController = TextEditingController();

  //addrress page
  String street = "";
  String locality = "";
  String sublocality = "";
  String thoroughfare = "";
  String postalCode = "";

  //currentemail
  //String? currentEmail;

  List<UserApi> data = [];
  bool validate = false;

  bool favorite = false;

  int count = 1;
  double? countTotalPrice = 0;

  int cartcount = 1;
  dynamic carttottalprice;
  List<Favorite> favdata = [];

  //List<int> cartitemsuntottal = [];

  //List<int> totalprice = [];

  double totalAmount = 0.0;
  double alltotalAmount = 0.0;

  bool cashOnDSelivery = false;
  bool payment = false;

  // List<Addcart> cartdata = [];

  List<OrderModel> completeOrder = [];

  ThemeData lightThemedata = ThemeData();
  ThemeData darkThemedata = ThemeData();

  final _favoriteService = FavoriteService();
  List<Favorite> _favorite = [];
  bool islaoding = false;
  List<Favorite> get favoritedata => _favorite;

  // final _productsServices = ProductsServices();
  // List<Products> _products = [];
  // List<Products> get productsData => _products;

  final _apiServices = ApiServices();
  List<Addcart> _addCart = [];
  List<Addcart> get cartdata => _addCart;

  final _userServices = UserServices();
  CurrentUserModel? user;
  //CurrentUserModel get userData => _user;

  List<Products> _searchResult = [];
  List<Products> get serachData => _searchResult;

  List<RestaurantListModel> _restaurantList = [];
  List<RestaurantListModel> get restaurantListData => _restaurantList;

  List<Products> productsList = [];
  List<Products> get productsListData => productsList;

  List<OrderModel> _orderLst = [];
  List<OrderModel> get orderListData => _orderLst;

  List<Slidemodel> _sildelist = [];
  List<Slidemodel> get slideImageData => _sildelist;

  bool cartProduct = false;

  double lat = 22.634192;
  double lng = 79.610161;

  double? distanceInMeters;
  double distanceInKm = 0.0;

  String? restauramtGmail;

  String? prodcutsRateing;

  List<double> totalrateing = [];

  List result = [];

  String favoriteId = '';
  String cartDataId = '';

  emailadd(email) {
    currentEmail = email;
    notifyListeners();
  }

  favoriteid(id) {
    favoriteId = id;
    notifyListeners();
  }

  cartdataid(id) {
    cartDataId = id;
    notifyListeners();
  }

  cartcountUpdate(data) {
    cartcount = int.parse(data);
    notifyListeners();
  }

  updategmail(data) {
    restauramtGmail = data;
    notifyListeners();
  }

  chash() {
    cashOnDSelivery = true;
    payment = false;
    notifyListeners();
  }

  paymentui() {
    cashOnDSelivery = false;
    payment = true;
    notifyListeners();
  }

//order page
  countIncrease(price) {
    count++;
    countTotalPrice = (count * price).toDouble();
    notifyListeners();
  }

  countDecrease(price) {
    if (count == 1) {
      count;
    } else {
      count--;
      countTotalPrice = (count * price).toDouble();
      notifyListeners();
    }
  }

  //cart

  cartcountIncrease(price) {
    cartcount++;
    carttottalprice = (cartcount * int.parse(price));
    notifyListeners();
  }

  cartcountDecrease(price) {
    if (cartcount == 1) {
      cartcount;
    } else {
      cartcount--;
      carttottalprice = (cartcount * int.parse(price));
      notifyListeners();
    }
  }

  userloginSharedPrefrance(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("email", logingmailcontroller.text).then(
          (value) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const BottomNav())),
        );
    notifyListeners();
  }

  getValidationdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString("email");

    currentEmail = obtainedEmail!;
    notifyListeners();
  }

  favdelete(id) {
    islaoding = true;
    favoritedelete(id)
        .then((value) => getAllFavorite().then((value) => favoriteid("")));
    islaoding = false;
    notifyListeners();
  }

  deletecart(id) {
    deleteCart(id)
        .then((value) => getAllCart())
        .then((value) => cartdataid(""));
    notifyListeners();
  }

  favoritetrue() {
    favorite = true;
    notifyListeners();
  }

  favoritefalse() {
    favorite = false;
    notifyListeners();
  }

  Future<void> getAllFavorite() async {
    islaoding = true;
    notifyListeners();
    final response = await _favoriteService.favoriteList(currentEmail);
    _favorite = response;
    islaoding = false;
    notifyListeners();
  }

  Future<void> getAllCart() async {
    islaoding = true;
    notifyListeners();
    final response = await _apiServices.getListaddcart(currentEmail);
    _addCart = response;
    islaoding = false;
    notifyListeners();
  }

  getIndexcart(productId) {
    for (var i = 0; i < cartdata.length; i++) {
      if (cartdata[i].productsId == productId) {
        cartProduct = true;
      } else {
        cartProduct = false;
      }
    }
    notifyListeners();
  }

  Future<void> getUser() async {
    islaoding = true;
    notifyListeners();
    final response = await _userServices.getUserData(currentEmail);
    user = response;

    islaoding = false;
    notifyListeners();
  }

  Future<void> searchResult(query) async {
    islaoding = true;
    notifyListeners();
    final response = await _apiServices.getSearchResult(query);
    _searchResult = response;
    islaoding = false;
    notifyListeners();
  }

  addLocation(lat, lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    Placemark place = placemarks[0];

    street = place.street!;
    locality = place.locality!;
    sublocality = place.subLocality!;
    postalCode = place.postalCode!;

    notifyListeners();
  }

  distance(lat1, lng1, lat2, lng2) {
    distanceInMeters = Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
    distanceInKm = distanceInMeters! * 0.001;
    notifyListeners();
  }

  homePageDistance(lat1, lng1, lat2, lng2) {
    distanceInMeters = Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
    distanceInKm = distanceInMeters! * 0.001;
    notifyListeners();
  }

  latlag(latitude, longitude) {
    lat = latitude;
    lng = longitude;
    notifyListeners();
  }

  Future<void> getRestaurants() async {
    islaoding = true;
    notifyListeners();
    final response = await _apiServices.getrestaurantResult();
    _restaurantList = response;
    islaoding = false;
    notifyListeners();
  }

  Future<void> getProducts({required String gmail}) async {
    islaoding = true;
    notifyListeners();
    final response = await _apiServices.getProductsList(gmail: gmail);
    productsList = response;
    islaoding = false;
    productsListData;
    notifyListeners();
  }

  Future<void> getcategoryProducts(
      {required String gmail, String? category}) async {
    islaoding = true;
    notifyListeners();
    final response = await _apiServices.getcategoryProductsList(
        gmail: gmail, category: category);
    productsList = response;
    islaoding = false;
    productsListData;
    notifyListeners();
  }

  homePageProductsLoad() async {
    for (var i = 0; i < restaurantListData.length; i++) {
      if (Geolocator.distanceBetween(
              double.parse(user!.address![0].lat),
              double.parse(user!.address![0].lng),
              double.parse(restaurantListData[i].address[0].lat),
              double.parse(restaurantListData[i].address[0].lng)) <=
          7000) {
        // await updategmail(restaurantListData[i].gmail);
        restauramtGmail = restaurantListData[i].gmail;
        homePageDistance(
            double.parse(user!.address![0].lat),
            double.parse(user!.address![0].lng),
            double.parse(restaurantListData[i].address[0].lat),
            double.parse(restaurantListData[i].address[0].lng));
      }
    }
    notifyListeners();
  }

  fetchrateing(rateing) {
    prodcutsRateing = rateing;
    notifyListeners();
  }

  updateRateing(id, prateing) {
    rateing(id: id, rateing: prateing).then((value) => getOrderList());
    notifyListeners();
  }

  Future<void> getOrderList() async {
    islaoding = true;
    notifyListeners();
    final response = await _apiServices.getCompleteOrder(currentEmail);
    _orderLst = response;
    islaoding = false;

    notifyListeners();
  }

  avgrateing() {
    for (var index = 0; index < orderListData.length; index++) {
      for (var i = 0; i < productsListData.length; i++) {
        if (productsListData[i].id == orderListData[index].productsId) {}
      }
    }
    notifyListeners();
  }

  Future<void> getsldieimage() async {
    islaoding = true;
    notifyListeners();
    final response = await _apiServices.sildeImage();
    _sildelist = response;
    islaoding = false;
    notifyListeners();
  }
}
