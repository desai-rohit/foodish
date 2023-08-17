import 'package:flutter/material.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:food_delivery/services/api_user.dart';
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
      UserProvider provider = Provider.of<UserProvider>(context, listen: false);

      provider.getAllCart();
      provider.getAllFavorite();

      for (int i = 0; i < provider.favoritedata.length; i++) {
        if (provider.favoritedata[i].productsId == widget.data.id) {
          provider.favoriteid(provider.favoritedata[i].productsId);
        }
      }

      for (int i = 0; i < provider.cartdata.length; i++) {
        if (provider.cartdata[i].productsId == widget.data.id) {
          // provider.favoriteId = provider.favoritedata[i].productsId;
          provider.cartdataid(provider.cartdata[i].productsId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, child) {
      return WillPopScope(
        onWillPop: () async {
          value.countTotalPrice = 0.0;
          value.count = 1;

          return true;
        },
        child:  Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          if (value.favoriteId == widget.data.id) {
                            value.favdelete(value.favoriteId);
                          } else {
                            addFavorite(
                                    widget.data.id.toString(),
                                    value.currentEmail.toString(),
                                    widget.data.image,
                                    widget.data.foodName,
                                    widget.data.restorantName,
                                    widget.data.price.toString())
                                .then((v) => value.getAllFavorite())
                                .then((v) => value.favoriteid(widget.data.id));
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: value.favoriteId != widget.data.id
                              ? Colors.white
                              : Colors.red,
                        ))
                  ],
                ),
                body: SingleChildScrollView(
                  child: Stack(
                    children: [


                      Opacity(
                        opacity: value.islaoding == true ? 0.5 : 1,
                        child: AbsorbPointer(
                          absorbing: value.islaoding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 400,
                              child: Image.network(
                                widget.data.image,
                                cacheWidth: 400,
                                cacheHeight: 400,
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
                                                child: Text(
                                                  "-",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary),
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
                                                child: Text(
                                                  "+",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary),
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
                                                    "${value.distanceInMeters == null ? "0" : (value.distanceInKm.toStringAsFixed(2))} KM",
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
                                                    "${(25 + 4 * value.distanceInKm).toStringAsFixed(0)} min",
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
                            opacity: value.islaoding ? 1.0 : 0,
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
                            var obtainedEmail =
                                sharedPreferences.getString("email");

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
                                    .then((v) => value.getAllCart())
                                    .then((value) => ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Add To Cart Successfully"))))
                                    .then((v) =>
                                        value.cartdataid(widget.data.id));
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
