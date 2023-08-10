import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery/commanWidget/comman_widget.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OrderDetails extends StatefulWidget {
  dynamic data;
  OrderDetails({super.key, required this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.primaryContainer),
                  child: Column(
                    children: [
                      Image.network(
                        "https://greggospizza.com/wp-content/uploads/2023/02/IMG_6053.png",
                        width: 250,
                        height: 250,
                        cacheHeight: 250,
                        cacheWidth: 250,
                        fit: BoxFit.cover,
                      ),
                      const Text(
                        "Pizza",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "cafe choco",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Total Price Rs 312",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                RatingBar.builder(
                  initialRating: double.parse(widget.data.rateing),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    //value.prodcutsRateing = rating.toString();
                    value.fetchrateing(rating.toString());
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                button(
                  context: context,
                  onPressd: () {
                    value.updateRateing(widget.data.id, value.prodcutsRateing);
                  },
                  name: "Submit",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
