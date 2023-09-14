import 'package:flutter/material.dart';
import 'package:food_delivery/const/category_image.dart';
import 'package:food_delivery/mytheme/my_colors.dart';
import 'package:food_delivery/pages/home/address.dart';
import 'package:food_delivery/pages/home/home_provider.dart';
import 'package:food_delivery/pages/orderpage/order_page.dart';
import 'package:food_delivery/pages/search/search_page.dart';
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
    HomeProvider value = Provider.of<HomeProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await value.homePageProductsLoad();

      value.getsldieimage();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(viewportFraction: 0.8);
    return Consumer<HomeProvider>(builder: (context, value, child) {
      return Stack(children: [
        Opacity(
          opacity: value.isloading == true ? 0.5 : 1,
          child: AbsorbPointer(
            absorbing: value.isloading,
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
                                  value.slideactivepage(page);
                                },
                                itemBuilder: (contex, index) {
                                  bool active = index == value.activePage;
                                  double margin = active ? 4 : 8;
                                  return AnimatedContainer(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOutCubic,
                                    margin: EdgeInsets.all(margin),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(24),
                                      child: Image.network(
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return const Text('😢');
                                        },
                                        value.slideImageData[index].imges,
                                        fit: BoxFit.fill,
                                        cacheWidth: 300,
                                        cacheHeight: 250,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 30,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: value.slideImageData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(10),
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: index == value.activePage
                                            ? Colors.black
                                            : Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                                      builder: (context) =>
                                          SearchPage(query: value)));
                            },
                            autofocus: false,
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
                            height: MediaQuery.of(context).size.height * 0.25,
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
                                          if (value.user!.address![0].area !=
                                              "") {
                                            categoryName[index] == "All Food"
                                                ? value.getProducts(
                                                    gmail:
                                                        value.restauramtGmail!)
                                                : value.getcategoryProducts(
                                                    gmail:
                                                        value.restauramtGmail!,
                                                    category:
                                                        categoryName[index++],
                                                  );
                                          } else {
                                            value.fontsizea();
                                          }
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
                    value.distanceInKm == 0.0
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                "Please Select Location",
                                style: TextStyle(
                                    fontSize: value.fontsize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : value.productsListData.isEmpty
                            ? const SliverToBoxAdapter(
                                child: Center(
                                  child: Text("This Category No Food",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            : SliverGrid(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0,
                                  childAspectRatio: 6 / 11,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return Material(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      child: InkWell(
                                          splashColor: Colors.grey,
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
                    const SliverPadding(padding: EdgeInsets.only(bottom: 60))
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
              opacity: value.isloading ? 1.0 : 0,
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
