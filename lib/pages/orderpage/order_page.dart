import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/pages/cart/cart_provider.dart';
import 'package:food_delivery/pages/favorite/favorite_provider.dart';
import 'package:food_delivery/pages/home/address_provider.dart';
import 'package:food_delivery/pages/home/home_provider.dart';
import 'package:food_delivery/pages/orderpage/order_services.dart';
import 'package:food_delivery/pages/orderpage/orderpage_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OrderPage extends StatefulWidget {
  dynamic data;
  OrderPage({super.key, required this.data});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      OrderPageProvidr provider =
          Provider.of<OrderPageProvidr>(context, listen: false);
      CartProvider cartProvider =
          Provider.of<CartProvider>(context, listen: false);

      cartProvider.getAllCart();
      FavoriteProvider favoriteProvider =
          Provider.of<FavoriteProvider>(context, listen: false);

      favoriteProvider.getAllFavorite();

      for (int i = 0; i < favoriteProvider.favoritedata.length; i++) {
        if (favoriteProvider.favoritedata[i].productsId == widget.data.id) {
          favoriteProvider
              .favoriteid(favoriteProvider.favoritedata[i].productsId);
        }
      }

      for (int i = 0; i < cartProvider.cartdata.length; i++) {
        if (cartProvider.cartdata[i].productsId == widget.data.id) {
          provider.cartdataid(cartProvider.cartdata[i].productsId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of(context);
    FavoriteProvider favoriteProvider = Provider.of(context);
    AddressProvider addressProvider = Provider.of(context);
    HomeProvider homeProvider = Provider.of(context);
    return Consumer<OrderPageProvidr>(builder: (context, value, child) {
      return WillPopScope(
        onWillPop: () async {
          value.countTotalPrice = 0.0;
          value.count = 1;

          return true;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    if (favoriteProvider.favoriteId == widget.data.id) {
                      favoriteProvider.favdelete(favoriteProvider.favoriteId);
                    } else {
                      value.truefalse(true);
                      Orderservices()
                          .addFavorite(
                              widget.data.id.toString(),
                              currentEmail.toString(),
                              widget.data.image,
                              widget.data.foodName,
                              widget.data.restorantName,
                              widget.data.price.toString())
                          .then((v) => favoriteProvider.getAllFavorite())
                          .then((v) {
                        favoriteProvider.favoriteid(widget.data.id);
                        value.truefalse(false);
                      });
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: favoriteProvider.favoriteId != widget.data.id
                        ? Colors.grey
                        : Colors.red,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Stack(children: [
              Opacity(
                opacity: value.isloading == true ? 0.5 : 1,
                child: AbsorbPointer(
                  absorbing: value.isloading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 400,
                        child: CachedNetworkImage(
                          imageUrl: widget.data.image,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.data.foodName,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.data.restorantName,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            value.countDecrease(
                                                widget.data.price);
                                          },
                                          child: const Text(
                                            "-",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                      Text(
                                        value.count.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            value.countIncrease(
                                                widget.data.price);
                                          },
                                          child: const Text(
                                            "+",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'size \n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'medium',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary)),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'kilo Meter \n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              "${homeProvider.distanceInKm == 0.0 ? "0" : (homeProvider.distanceInKm.toStringAsFixed(2))} KM",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary)),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Time \n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              "${(25 + 4 * addressProvider.distanceInKm).toStringAsFixed(0)} min",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(widget.data.des)
                          ],
                        ),
                      ),
                    ],
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
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  value.countTotalPrice == 0.0
                      ? "RS ${widget.data.price}"
                      : "RS  ${value.countTotalPrice.toString()}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.red),
                    onPressed: () async {
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      var obtainedEmail = sharedPreferences.getString("email");

                      value.cartDataId == widget.data.id
                          // ignore: use_build_context_synchronously
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Allready Add Item")))
                          : value
                              .addtocart(
                                  widget.data.id,
                                  obtainedEmail,
                                  widget.data.image,
                                  widget.data.foodName,
                                  widget.data.restorantName,
                                  widget.data.gmail,
                                  widget.data.price,
                                  value.count.toString(),
                                  value.countTotalPrice == 0.0
                                      ? widget.data.price.toString()
                                      : value.countTotalPrice.toString())
                              .then((v) => cartProvider.getAllCart())
                              .then((value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content:
                                          Text("Add To Cart Successfully"))))
                              .then((v) => value.cartdataid(widget.data.id));
                      value.count = 1;
                      value.countTotalPrice = 0.0;
                    },
                    child: const Text("Add To Cart"))
              ],
            ),
          ),
        ),
      );
    });
  }
}
