import 'package:flutter/material.dart';
import 'package:food_delivery/config/category_image.dart';
import 'package:food_delivery/config/my_colors.dart';
import 'package:food_delivery/pages/home/address.dart';
import 'package:food_delivery/pages/orderpage/order_page.dart';
import 'package:food_delivery/pages/otherPages/search/search_page.dart';
import 'package:food_delivery/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late PageController _pageController;
int activePage = 1;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    UserProvider value = Provider.of<UserProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await value.homePageProductsLoad();

      value.getsldieimage();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(viewportFraction: 0.8);
    return Consumer<UserProvider>(builder: (context, value, child) {
      return Stack(children: [
        Opacity(
          opacity: value.islaoding == true ? 0.5 : 1,
          child: AbsorbPointer(
            absorbing: value.islaoding,
            child: Scaffold(
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
                padding: const EdgeInsets.all(16),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: value.slideImageData.length,
                                controller: _pageController,
                                pageSnapping: true,
                                onPageChanged: (page) {
                                  setState(() {
                                    activePage = page;
                                  });
                                },
                                itemBuilder: (contex, index) {
                                  bool active = index == activePage;
                                  double margin = active ? 4 : 8;
                                  return

                                      // CachedNetworkImage(
                                      //   imageUrl: value.slideImageData[index].imges,
                                      //   placeholder: (context, url) =>
                                      //       const CircularProgressIndicator(
                                      //     color: Colors.red,
                                      //   ),
                                      //   imageBuilder: (context, imageProvider) {
                                      //     return AnimatedContainer(
                                      //       width: 250,
                                      //       height: 200,
                                      //       duration:
                                      //           const Duration(milliseconds: 500),
                                      //       curve: Curves.easeInOutCubic,
                                      //       margin: EdgeInsets.all(margin),
                                      //       decoration: BoxDecoration(
                                      //           image: DecorationImage(
                                      //               image: imageProvider,
                                      //               fit: BoxFit.fill)),
                                      //     );
                                      //   },
                                      // );

                                      AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOutCubic,
                                    margin: EdgeInsets.all(margin),
                                    child: Image.network(
                                      value.slideImageData[index].imges,
                                      fit: BoxFit.fill,
                                      cacheWidth: 300,
                                      cacheHeight: 250,
                                    ),
                                  );
                                }),
                          ),

                          const SizedBox(
                            height: 24,
                          ),

                          // SliverList(
                          //   delegate: SliverChildBuilderDelegate(
                          //     (BuildContext context, int index) {
                          //       return Container(
                          //         child: Text("$index"),
                          //       );
                          //     },
                          //     childCount: value.slideImageData.length,
                          //   ),
                          // ),

                          // ListView.builder(
                          //     itemCount: value.slideImageData.length,
                          //     itemBuilder: (context, index) {
                          //       return Row(
                          //         children: [
                          //           Container(
                          //             width: 10,
                          //             height: 10,
                          //             decoration: const BoxDecoration(
                          //                 // color: activePage == index
                          //                 //     ? Colors.black
                          //                 //     : Colors.grey
                          //                 color: Colors.black),
                          //           )
                          //         ],
                          //       );
                          //     }),

                          //search Box
                          TextField(
                            controller: value.searchController,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchPage(query: value)));
                            },
                            autofocus: false,
                            style: const TextStyle(color: Color(0xFFbdc6cf)),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              hintText: 'Find Your Food...',
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
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
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 4),
                                    child: Material(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        onTap: () async {
                                          categoryName[index] == "All Food"
                                              ? value.getProducts(
                                                  gmail: value.restauramtGmail!)
                                              : value.getcategoryProducts(
                                                  gmail: value.restauramtGmail!,
                                                  category:
                                                      categoryName[index++]);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(4),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
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
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      ),
                    ),
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 6 / 11,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return value.distanceInKm == 0.0
                              ? const Center(
                                  child: Text("Please select location"),
                                )
                              // ignore: prefer_is_empty
                              : value.productsListData.isEmpty
                                  ? const Center(
                                      child: Text("This Category No Food"))
                                  : Material(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      child: InkWell(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16)),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderPage(
                                                          data: value
                                                                  .productsListData[
                                                              index],
                                                        )));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                  textAlign: TextAlign.center,
                                                  value.productsListData[index]
                                                      .foodName,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  value.productsListData[index]
                                                      .restorantName,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "${(25 + 4 * value.distanceInKm).toStringAsFixed(0)} min |  ${value.distanceInMeters == null ? "0" : (value.distanceInKm.toStringAsFixed(2))} km "),
                                                Text(
                                                  " RS ${value.productsListData[index].price.toString()}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          )),
                                    );
                        },
                        childCount: value.productsListData.length,
                      ),
                    ),
                  ],
                ),
              ),
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
      ]);
    });
  }
}
