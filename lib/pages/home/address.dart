import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/pages/home/address_provider.dart';
import 'package:food_delivery/pages/bottom_nav/bottom_nav.dart';

import 'package:food_delivery/services/api_user.dart';
import 'package:food_delivery/commanWidget/comman_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddressLocation extends StatefulWidget {
  const AddressLocation({super.key});

  @override
  State<AddressLocation> createState() => _AddressLocationState();
}

class _AddressLocationState extends State<AddressLocation> {
  GoogleMapController? googleMapController;
  final Map<String, Marker> _marker = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AddressProvider provider =
          Provider.of<AddressProvider>(context, listen: false);

      provider.getRestaurants();
      checkPermission(Permission.location, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (context, value, child) {
      return Stack(children: [
        Opacity(
          opacity: value.isloading == true ? 0.5 : 1,
          child: AbsorbPointer(
            absorbing: value.isloading,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        checkPermission(Permission.location, context);
                      },
                      icon: const Icon(Icons.location_city))
                ],
              ),
              body: Consumer<AddressProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: provider.lat == 0
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              )
                            : GoogleMap(
                                onTap: (LatLng latlng) {
                                  provider.latlag(
                                      latlng.latitude, latlng.longitude);

                                  addmarker("test1",
                                      LatLng(provider.lat!, provider.lng!));
                                  // });
                                },
                                onMapCreated: (controller) {
                                  googleMapController = controller;
                                },
                                markers: _marker.values.toSet(),
                                initialCameraPosition: CameraPosition(
                                    target:
                                        LatLng(provider.lat!, provider.lng!),
                                    zoom: 15),
                              ),
                      ),
                      Text(provider.street),
                      button(
                          width: MediaQuery.of(context).size.width,
                          context: context,
                          onPressd: () async {
                            for (int i = 0;
                                i < provider.restaurantListData.length;
                                i++) {
                              if (Geolocator.distanceBetween(
                                      provider.lat!,
                                      provider.lng!,
                                      double.parse(provider
                                          .restaurantListData[i]
                                          .address[0]
                                          .lat),
                                      double.parse(provider
                                          .restaurantListData[i]
                                          .address[0]
                                          .lng)) <=
                                  7000) {
                                provider.addLocation(
                                    provider.lat, provider.lng);
                                provider.restauramtGmail =
                                    provider.restaurantListData[i].gmail;

                                provider.distance(
                                    provider.lat,
                                    provider.lng,
                                    double.parse(provider
                                        .restaurantListData[i].address[0].lat),
                                    double.parse(provider
                                        .restaurantListData[i].address[0].lng));

                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Enter Complete Address",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            TextField(
                                              controller: provider.addflat,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    'Flat/House No/Floor/Building',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            TextField(
                                              controller: provider.addaera,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    'Area/Sector/Locality',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            TextField(
                                              controller: provider.addlandmark,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText:
                                                    'Nearby LandMark(Optional)',
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                color: Colors.grey.shade300,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 16),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        backgroundColor:
                                                            Colors.red),
                                                    onPressed: () {
                                                      updateUser(
                                                              gmail: currentEmail
                                                                  .toString(),
                                                              lat: provider.lat
                                                                  .toString(),
                                                              lng: provider.lng
                                                                  .toString(),
                                                              flat: provider
                                                                  .addflat.text,
                                                              area: provider
                                                                  .addaera.text,
                                                              landmark: provider
                                                                  .addlandmark
                                                                  .text)
                                                          .then((value) => Navigator
                                                              .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const BottomNav())));
                                                    },
                                                    child: const Text(
                                                      "Save Address",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    )))
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Your location store not avilable")));
                              }
                            }
                          },
                          name: "Confirm Location")
                    ],
                  );
                },
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

  void addmarker(String markerid, LatLng location) {
    var marker = Marker(markerId: MarkerId(markerid), position: location);
    _marker[markerid] = marker;

    setState(() {});
  }

  Future<void> checkPermission(
      Permission permission, BuildContext context) async {
    AddressProvider provider =
        Provider.of<AddressProvider>(context, listen: false);
    final status = await permission.request();
    if (status.isGranted) {
      await Geolocator.isLocationServiceEnabled()
          .then((enabled) => {if (enabled) {} else {}});

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      provider.lat = position.latitude;
      provider.lng = position.longitude;
      addmarker("test1", LatLng(provider.lat!, provider.lng!));

      // ignore: use_build_context_synchronously
      Provider.of<AddressProvider>(context, listen: false)
          .latlag(position.latitude, position.longitude);

      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 15);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Permission is Granted")));
    } else if (status.isDenied) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Permission is Denied")));
      await Permission.location.request();
    } else if (status.isPermanentlyDenied) {
      // ignore: use_build_context_synchronously
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Location Enable'),
          content: const Text(
              'Kindly allow Permission from App Setting, without this permission app would not show maps'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const BottomNav()),
                ModalRoute.withName('/'),
              ),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>
                  openAppSettings().then((value) => const AddressLocation()),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
