import 'package:flutter/material.dart';
import 'package:food_delivery/const/api_const.dart';
import 'package:food_delivery/pages/home/address_provider.dart';
import 'package:food_delivery/pages/home/home_provider.dart';
import 'package:food_delivery/pages/payment/payment_page.dart';
import 'package:food_delivery/services/api_user.dart';
import 'package:food_delivery/commanWidget/comman_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  GoogleMapController? googleMapController;
  final Map<String, Marker> _marker = {};

  double lat = 22.634192;
  double lng = 79.610161;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProvider>(context, listen: false).getUser();
    });

    checkPermission(Permission.location, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AddressProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onTap: (LatLng latlng) {
                    setState(() {
                      lat = latlng.latitude;
                      lng = latlng.longitude;

                      addmarker("test1", LatLng(lat, lng));
                    });
                  },
                  onMapCreated: (controller) {
                    googleMapController = controller;
                  },
                  markers: _marker.values.toSet(),
                  initialCameraPosition: CameraPosition(
                      target: LatLng(lat, lng), tilt: 59, zoom: 1),
                ),
              ),
              button(
                  width: MediaQuery.of(context).size.width,
                  context: context,
                  onPressd: () {
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
                                    labelText: 'Flat/House No/Floor/Building',
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextField(
                                  controller: provider.addaera,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Area/Sector/Locality',
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextField(
                                  controller: provider.addlandmark,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nearby LandMark(Optional)',
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    color: Colors.grey.shade300,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            backgroundColor: Colors.red),
                                        onPressed: () {
                                          updateUser(
                                                  gmail: currentEmail!,
                                                  lat: lat.toString(),
                                                  lng: lng.toString(),
                                                  flat: provider.addflat.text,
                                                  area: provider.addaera.text,
                                                  landmark:
                                                      provider.addlandmark.text)
                                              .then((value) => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PaymentPage(
                                                            lat: lat.toString(),
                                                            lng: lng.toString(),
                                                            house: provider
                                                                .addflat.text,
                                                            area: provider
                                                                .addaera.text,
                                                            landmark: provider
                                                                .addlandmark
                                                                .text,
                                                          ))));
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
                  },
                  name: "Confirm Location"),
            ],
          );
        },
      ),
    );
  }

  void addmarker(String markerid, LatLng location) {
    var marker = Marker(markerId: MarkerId(markerid), position: location);
    _marker[markerid] = marker;

    setState(() {});
  }

  Future<void> checkPermission(
      Permission permission, BuildContext context) async {
    final status = await permission.request();
    if (status.isGranted) {
      await Geolocator.isLocationServiceEnabled()
          .then((enabled) => {if (enabled) {} else {}});

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      lng = position.longitude;
      addmarker("test1", LatLng(lat, lng));

      // ignore: use_build_context_synchronously
      Provider.of<AddressProvider>(context, listen: false)
          .latlag(position.latitude, position.longitude);

      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 15);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Permission is Granted")));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Permission is Denied")));
    }
  }
}
