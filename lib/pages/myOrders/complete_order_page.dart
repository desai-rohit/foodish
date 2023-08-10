import 'package:flutter/material.dart';
import 'package:food_delivery/pages/myOrders/order_details.dart';
import 'package:food_delivery/provider/user_provider.dart';
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
      Provider.of<UserProvider>(context, listen: false).getOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                bottom: const TabBar(
                    indicatorColor: Colors.red,
                    labelColor: Colors.red,
                    tabs: [
                      Text("New Order"),
                      Text("Ship Order"),
                      Text("complete Order"),
                    ]),
              ),
              body: TabBarView(children: [
                ListView.builder(
                    itemCount: value.orderListData.length,
                    itemBuilder: (context, index) {
                      return value.orderListData[index].orderaccepted == false
                          ? ListTile(
                              leading: Image.network(
                                  value.orderListData[index].image),
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
                      return value.orderListData[index].ordership == true
                          ? ListTile(
                              leading: Image.network(
                                  value.orderListData[index].image),
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
                                leading: Image.network(
                                    value.orderListData[index].image),
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
