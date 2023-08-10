import 'package:flutter/material.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getAllFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return value.islaoding == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : value.favoritedata.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Lottie.asset(
                          'assets/animation/favorite.json',
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text(
                        "Favorite List Empty",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                : Scaffold(
                    body: ListView.builder(
                        itemCount: value.favoritedata.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            trailing: IconButton(
                                onPressed: () {
                                  value.favdelete(
                                      value.favoritedata[index].productsId);
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )),
                            leading: Image.network(
                              value.favoritedata[index].image,
                              width: 100,
                              height: 100,
                            ),
                            title: Text(value.favoritedata[index].name),
                            subtitle: Text(
                              "Rs ${value.favoritedata[index].price}",
                            ),
                          );
                        }),
                  );
      },
    );
  }
}
