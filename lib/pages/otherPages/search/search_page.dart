import 'package:flutter/material.dart';
import 'package:food_delivery/pages/productsDetails/products_details.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  String query;
  SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false)
          .searchResult(widget.query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Search"),
            centerTitle: true,
          ),
          body: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.serachData.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 6 / 8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderPage(
                                  data: value.serachData[index],
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Image.network(
                          value.serachData[index].image,
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.height * 0.15,
                          cacheHeight: 115,
                          cacheWidth: 115,
                        ),
                        Text(
                          value.serachData[index].foodName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          value.serachData[index].restorantName,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Text("30 min | 8km "),
                        const Text(
                          " RS 150",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
