import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/myOrders/myorder_provider.dart';
import 'package:food_delivery/pages/myOrders/order_details.dart';
import 'package:provider/provider.dart';

class CompleteOrderPage extends StatefulWidget {
  const CompleteOrderPage({
    super.key,
  });

  @override
  State<CompleteOrderPage> createState() => _CompleteOrderPageState();
}

class _CompleteOrderPageState extends State<CompleteOrderPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MyOrderProvider>(context, listen: false).getOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyOrderProvider>(
      builder: (context, value, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                bottom: const TabBar(
                    indicatorColor: Colors.red,
                    labelColor: Colors.red,
                    tabs: [
                      Text(textAlign: TextAlign.center, "New Order"),
                      Text(textAlign: TextAlign.center, "Ship Order"),
                      Text(textAlign: TextAlign.center, "complete Order"),
                    ]),
              ),
              body: TabBarView(children: [
                ListView.builder(
                    itemCount: value.orderListData.length,
                    itemBuilder: (context, index) {
                      return value.orderListData[index].orderaccepted == false
                          ? ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: value.orderListData[index].image,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              // Image.network(
                              //     value.orderListData[index].image),
                              title: Text(value.orderListData[index].foodname),
                              subtitle: Text(
                                  "RS ${value.orderListData[index].countTotalPrice}"),
                              trailing: IconButton(
                                  onPressed: () {
                                    // value.newOrderUpdate();
                                  },
                                  icon: const Icon(Icons.check_box)),
                            )
                          : Container();
                    }),
                ListView.builder(
                    itemCount: value.orderListData.length,
                    itemBuilder: (context, index) {
                      return value.orderListData[index].ordership == false &&
                              value.orderListData[index].orderaccepted == true
                          ? ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: value.orderListData[index].image,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              title: Text(value.orderListData[index].foodname),
                              subtitle: Text(
                                  "RS ${value.orderListData[index].countTotalPrice}"),
                              trailing: IconButton(
                                  onPressed: () {
                                    // value.shipOrderUpdate();
                                  },
                                  icon: const Icon(
                                    Icons.check_box,
                                    color: Colors.red,
                                  )),
                            )
                          : Container();
                    }),
                ListView.builder(
                    itemCount: value.orderListData.length,
                    itemBuilder: (context, index) {
                      return value.orderListData[index].orderaccepted == true &&
                              value.orderListData[index].ordership == true
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderDetails(
                                              data: value.orderListData[index],
                                            )));
                              },
                              child: ListTile(
                                leading: CachedNetworkImage(
                                  imageUrl: value.orderListData[index].image,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                title:
                                    Text(value.orderListData[index].foodname),
                                subtitle: Text(
                                    "RS ${value.orderListData[index].countTotalPrice}"),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                              ),
                            )
                          : Container();
                    }),
              ])),
        );
      },
    );
  }
}
