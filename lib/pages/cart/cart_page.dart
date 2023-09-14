import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/pages/cart/cart_provider.dart';
import 'package:food_delivery/pages/home/home_provider.dart';
import 'package:food_delivery/pages/payment/payment_page.dart';
import 'package:food_delivery/services/api_user.dart';
import 'package:food_delivery/commanWidget/comman_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CartProvider>(context, listen: false).getAllCart();
      Provider.of<HomeProvider>(context, listen: false).getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    return Consumer<CartProvider>(builder: (context, value, child) {
      value.totalAmount = 0.0;

      for (int i = 0; i < value.cartdata.length; i++) {
        value.cartdata[i].user == currentEmail
            ? value.totalAmount = value.totalAmount +
                (double.parse(value.cartdata[i].price) *
                    double.parse(value.cartdata[i].itemcount))
            : 0.0;
      }

      return value.cartdata.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/animation/cart.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                const Text(
                  "Cart Is Empty",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            )
          : Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                title: const Text("My Cart"),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Stack(children: [
                  Opacity(
                    opacity: value.isloading == true ? 0.5 : 1,
                    child: AbsorbPointer(
                      absorbing: value.isloading,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.cartdata.length,
                                itemBuilder: (context, index) {
                                  return value.cartdata[index].user ==
                                          currentEmail
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Image.network(
                                                    value.cartdata[index].image,
                                                    cacheHeight: 100,
                                                    cacheWidth: 100,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        maxLines: 4,
                                                        value.cartdata[index]
                                                            .name,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "RS ${value.cartdata[index].totalprice}",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    194,
                                                                    193,
                                                                    193)),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondaryContainer,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                        child: Row(
                                                          children: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  value.cartcountUpdate(value
                                                                      .cartdata[
                                                                          index]
                                                                      .itemcount);

                                                                  value.cartcountDecrease(value
                                                                      .cartdata[
                                                                          index]
                                                                      .price);
                                                                  updateCart(
                                                                          value
                                                                              .cartdata[
                                                                                  index]
                                                                              .id,
                                                                          value
                                                                              .cartcount
                                                                              .toString(),
                                                                          value
                                                                              .carttottalprice
                                                                              .toString())
                                                                      .then(
                                                                          (v) {
                                                                    value
                                                                        .getAllCart()
                                                                        .then((v) =>
                                                                            value.isloadingtf(false));
                                                                  });
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "-",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                            Text(
                                                              value
                                                                  .cartdata[
                                                                      index]
                                                                  .itemcount,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            TextButton(
                                                                onPressed: () {
                                                                  value.cartcountUpdate(value
                                                                      .cartdata[
                                                                          index]
                                                                      .itemcount);

                                                                  value.cartcountIncrease(value
                                                                      .cartdata[
                                                                          index]
                                                                      .price);

                                                                  updateCart(
                                                                          value
                                                                              .cartdata[
                                                                                  index]
                                                                              .id,
                                                                          value
                                                                              .cartcount
                                                                              .toString(),
                                                                          value
                                                                              .carttottalprice
                                                                              .toString())
                                                                      .then(
                                                                          (v) {
                                                                    value
                                                                        .getAllCart()
                                                                        .then((v) =>
                                                                            value.isloadingtf(false));
                                                                  });
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "+",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        value.deletecart(value
                                                            .cartdata[index]
                                                            .productsId);
                                                      },
                                                      icon: const Icon(
                                                          Icons.close))
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      : (Container());
                                }),
                            Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    "Total Item",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Text(
                                      "RS ${value.totalAmount.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                ListTile(
                                  title: const Text(
                                    "Tax",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Text(
                                      "RS ${(value.totalAmount / 100 * 5).toStringAsFixed(0)}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                ListTile(
                                  title: const Text(
                                    "Delivery Charges",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: Text(
                                      "RS ${(value.totalAmount / 100 * 20).toStringAsFixed(0)}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                ListTile(
                                  title: const Text(
                                    "Total Item",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    "RS ${(value.totalAmount + (value.totalAmount / 100 * 5) + (value.totalAmount / 100 * 20)).toStringAsFixed(0)}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: value.isloading ? 1.0 : 0,
                        child: const CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.only(bottom: 16),
                child: button(
                  padding: const EdgeInsets.only(bottom: 60),
                  width: MediaQuery.of(context).size.width,
                  context: context,
                  onPressd: () {
                    value.orderId =
                        "${homeProvider.user!.id!.substring(homeProvider.user!.id!.length - 5)}${DateTime.now().millisecondsSinceEpoch}";

                    value.alltotalAmount = value.totalAmount +
                        (value.totalAmount / 100 * 5) +
                        (value.totalAmount / 100 * 20);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentPage(
                                  lat: homeProvider.user!.address![0].lat,
                                  lng: homeProvider.user!.address![0].lat,
                                  house: homeProvider
                                      .user!.address![0].flatHouseNo,
                                  area: homeProvider.user!.address![0].area,
                                  landmark: homeProvider
                                      .user!.address![0].nearbyLandmark,
                                )));
                  },
                  name: "Check out",
                ),
              ));
    });
  }
}
