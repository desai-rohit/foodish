import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/pages/UserPages/login_provider.dart';
import 'package:food_delivery/pages/cart/cart_provider.dart';
import 'package:food_delivery/pages/payment/payment_provider.dart';
import 'package:food_delivery/services/api_user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  String lat;
  String lng;
  String house;
  String area;
  String landmark;
  PaymentPage(
      {super.key,
      required this.lat,
      required this.lng,
      required this.house,
      required this.area,
      required this.landmark});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _razorpay = Razorpay();
  var rndnumber = "";
  String formattedDate = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false).getAllCart();
      Provider.of<LoginProvider>(context, listen: false).getUser();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });

    super.initState();
  }

  void randomNumber() {
    var rnd = Random();
    for (var i = 0; i < 12; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
  }

  void getDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat.yMd().add_jm();
    formattedDate = formatter.format(now);
    // 2016-01-25
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    for (var i = 0; i < cartProvider.cartdata.length; i++) {
      await order(
              productid: cartProvider.cartdata[i].productsId,
              name: cartProvider.cartdata[i].name,
              gmail: cartProvider.cartdata[i].user,
              image: cartProvider.cartdata[i].image,
              foodname: cartProvider.cartdata[i].name,
              restorantName: cartProvider.cartdata[i].restorantName,
              restorantGmail: cartProvider.cartdata[i].restorantGmail,
              price: cartProvider.cartdata[i].price,
              countTotalPrice: cartProvider.cartdata[i].totalprice,
              lat: widget.lat,
              lng: widget.lng,
              house: widget.house,
              area: widget.area,
              landmark: widget.landmark,
              orderid: cartProvider.orderId,
              paymentid: response.paymentId)
          .then((value) => Provider.of<CartProvider>(context, listen: false)
              .deletecart(cartProvider.cartdata[i].productsId));
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    return Consumer<PaymentProvider>(
      builder: (context, value, child) {
        //  pcartdata = value;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    value.chash();
                  });
                },
                child: ListTile(
                  title: const Text("Credit Card / Debit Card"),
                  leading: IconButton(
                      onPressed: () {},
                      icon: value.cashOnDSelivery == true
                          ? const Icon(
                              Icons.circle,
                              color: Colors.blue,
                            )
                          : const Icon(Icons.circle)),
                  trailing: const Icon(Icons.credit_card),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    value.paymentui();
                  });
                },
                child: ListTile(
                  title: const Text("UPI  Payment"),
                  leading: IconButton(
                      onPressed: () {},
                      icon: value.payment == true
                          ? const Icon(
                              Icons.circle,
                              color: Colors.blue,
                            )
                          : const Icon(Icons.circle)),
                  trailing: const Icon(Icons.mobile_friendly),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      backgroundColor: Colors.red),
                  onPressed: () {
                    var options = {
                      'key': 'rzp_test_HCp0lrzi56DnFI',
                      'amount': (double.parse(
                              cartProvider.alltotalAmount.toString()) *
                          100),
                      //in the smallest currency sub-unit.
                      'name': loginProvider.currentUserModel!.name,
                      //'order_id': value.orderId,

                      'description': "",
                      'timeout': 300, // in seconds
                      'prefill': {
                        'contact': "91" "1456874515",
                        'email': currentEmail,
                      }
                    };

                    _razorpay.open(options);
                  },
                  child: Text(
                    value.payment == true ? "Payment" : "Cash On Delivery",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ))),
        );
      },
    );
  }
}
