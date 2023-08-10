import 'package:flutter/material.dart';
import 'package:food_delivery/config/category_image.dart';
import 'package:food_delivery/config/my_colors.dart';
import 'package:food_delivery/pages/home/address.dart';
import 'package:food_delivery/pages/productsDetails/products_details.dart';
import 'package:food_delivery/pages/otherPages/search/search_page.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late PageController _pageController;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    UserProvider value = Provider.of<UserProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await value.getRestaurants();

      await value.getUser();

      value
          .homePageProductsLoad()
          .then((v) => value.getProducts(gmail: value.restauramtGmail!));

      ///value.getOrderList();
      value.getsldieimage();
    });

    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(viewportFraction: 0.8);

    return Consumer<UserProvider>(builder: (context, value, child) {
      return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
              title: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddressLocation()));
            },
            title: Text(
              value.user?.address![0].area == ""
                  ? "Address ▼"
                  : "${value.user?.address![0].area} ▼",
              style: const TextStyle(
                  color: redcolors, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(value.user?.address![0].nearbyLandmark == ""
                ? "Exact Location"
                : '${value.user?.address![0].nearbyLandmark}'),
          )),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(children: [
                //image slider

                // SizedBox(
                //   height: 200,
                //   child: CarouselSlider.builder(
                //       itemCount: 3,
                //       itemBuilder: ((context, index, realIndex) {
                //         //  final slideimage = value.slideImageData[index].imges;
                //         return Container(
                //           child: Image.network(
                //             value.slideImageData[index].imges,
                //             fit: BoxFit.cover,
                //             cacheHeight: 200,
                //             cacheWidth: 200,
                //           ),
                //         );
                //       }),
                //       options: CarouselOptions(
                //           height: 200,
                //           autoPlay: true,
                //           reverse: true,
                //           autoPlayAnimationDuration: const Duration(seconds: 2),
                //           enlargeCenterPage: true)),
                // ),
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.slideImageData.length,
                      controller: _pageController,
                      pageSnapping: true,
                      onPageChanged: (page) {},
                      itemBuilder: (contex, index) {
                        return Container(
                          // margin: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 16),
                          child: Image.network(
                            value.slideImageData[index].imges,
                            cacheWidth: 250,
                            cacheHeight: 200,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),

                const SizedBox(
                  height: 24,
                ),
                //search Box
                TextField(
                  controller: value.searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPage(query: value)));
                  },
                  autofocus: false,
                  style: const TextStyle(color: Color(0xFFbdc6cf)),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primaryContainer,
                    hintText: 'Find Your Food...',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                // food category
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryImage.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            categoryName[index] == "All Food"
                                ? value.getProducts(
                                    gmail: value.restauramtGmail!)
                                : value.getcategoryProducts(
                                    gmail: value.restauramtGmail!,
                                    category: categoryName[index++]);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  categoryImage[index],
                                  cacheHeight: 100,
                                  cacheWidth: 100,
                                  fit: BoxFit.cover,
                                ),
                                Text(categoryName[index])
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 16,
                ),

                const SizedBox(
                  height: 8,
                ),
                value.islaoding == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : value.distanceInKm == 0.0
                        ? const Center(
                            child: Text("Please select location"),
                          )
                        : value.productsListData.isEmpty
                            ? const Center(
                                child: Text("This Category No Food"),
                              )
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.productsListData.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                      data: value
                                                              .productsListData[
                                                          index],
                                                    )));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              value.productsListData[index]
                                                  .image,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              cacheHeight: 115,
                                              cacheWidth: 115,
                                            ),
                                            Text(
                                              value.productsListData[index]
                                                  .foodName,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              value.productsListData[index]
                                                  .restorantName,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                "30 min |  ${value.distanceInMeters == null ? "0" : (value.distanceInKm.toStringAsFixed(2))} km "),
                                            Text(
                                              " RS ${value.productsListData[index].price.toString()}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ));
                                })
              ]
                  // ],
                  ),
            ),
          ));
    });
  }
}
