// ignore_for_file: unused_field, prefer_const_constructors, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart' as cod;
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_farm/shared/widgets/custom_button.dart';

class AddressCombo {
  late final String? _address;
  late final LatLng? _coordinates;

  AddressCombo(this._address, this._coordinates);
  String? get address => _address;
  LatLng? get coordinates => _coordinates;
}

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _StorePageState();
}

class _StorePageState extends State<NavigationPage> {
  LatLng? destLocation = const LatLng(35.7051885, -0.650106);
  Location location = Location();
  loc.LocationData? _currentPosition;
  final Completer<GoogleMapController> _controller = Completer();
  String? _address;
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height / 8,
          child: CustomButton(
            buttonText: "Use location",
            onPressed: () async {
              final navigator = Navigator.of(context);
              await getAddressFromLatLng();
              navigator.pop(AddressCombo(_address, destLocation));
              //TODO implement the send location back to store window
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(
              //       builder: (context) => NavigationScreen(
              //           destLocation!.latitude, destLocation!.longitude),
              //     ),
              //     (route) => false);
            },
          ),
        ),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 8,
          leading: IconButton(
            icon: SvgPicture.asset("assets/icons/arrow-left.svg"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff0D986A),
          title: Text(
            'Choose a location',
            style: TextStyle(
                color: Colors.white, fontFamily: "Poppins", fontSize: 24),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: destLocation!,
                zoom: 14,
              ), // CameraPosition
              onCameraMove: (CameraPosition? position) {
                if (destLocation != position!.target) {
                  setState(() {
                    destLocation = position.target;
                  });
                }
              },
              onCameraIdle: () {
                print('camera idle');
              },
              onTap: (latLng) {
                print(latLng);
              },

              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ), // GoogleMap
            Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: Icon(
                    color: Colors.green.shade900,
                    Icons.location_on,
                    size: 50,
                  )), // Padding
            ), // Align
          ],
        ));
  }

  getAddressFromLatLng() async {
    try {
      List<cod.Placemark> placemarks = await cod.placemarkFromCoordinates(
          destLocation!.latitude, destLocation!.longitude);
      setState(() {
        print(placemarks);
        _address = placemarks[0].administrativeArea;
        print(_address);
      });
    } catch (e) {
      print(e);
    }
  }

  getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    // ignore: unused_local_variable, unnecessary_nullable_for_final_variable_declarations
    final GoogleMapController? controller = await _controller.future;

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (_permissionGranted == loc.PermissionStatus.granted) {
      location.changeSettings(accuracy: loc.LocationAccuracy.high);
    }
  }
}
