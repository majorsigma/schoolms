import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:schoolms/pages/widgets/online_slider.dart';
import 'package:schoolms/pages/widgets/schoolms_bottom_navigation_bar.dart';
import 'package:schoolms/utils/schoolms_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String defaultAddress;
  late Location location;
  late bool _isLocationServiceEnabled;
  late bool _isLocationPermissionGranted;
  final _logger = SchoolMsUtils.getLogger("HomePage");
  final Completer<GoogleMapController> _mapCompleter = Completer();
  LatLng? _markedLocation;

  // Initialize the state of the home page by setting the default address
  // to the Dufferin Mall, Toronto, Cananda
  @override
  void initState() {
    super.initState();
    defaultAddress = "Dufferin Mall, Toronto, Cananda";
    location = loc.Location();
    _isLocationPermissionGranted = false;
    _isLocationServiceEnabled = false;
    _resolveLocation();
  }

  // Resolve location by first checking if location service is enabled
  // and then requesting permission from the user
  Future<void> _resolveLocation() async {
    // request for location service permission
    _isLocationServiceEnabled = await location.serviceEnabled();
    if (!_isLocationServiceEnabled) {
      _isLocationServiceEnabled = await location.requestService();
      if (!_isLocationServiceEnabled) {
        return;
      }
    }

    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      _isLocationPermissionGranted = false;
      permissionStatus = await location.requestPermission();

      while (permissionStatus != PermissionStatus.granted) {
        permissionStatus = await location.requestPermission();
      }
    } else if (permissionStatus == PermissionStatus.granted) {
      _isLocationPermissionGranted = true;
      _logger.d("Location permission granted: $_isLocationPermissionGranted");

      List<gc.Location> locations =
          await gc.locationFromAddress(defaultAddress);

      final controller = await _mapCompleter.future;
      final markedLocation = LatLng(
        locations.first.latitude,
        locations.first.longitude,
      );
      setState(() {
        _markedLocation = markedLocation;
      });
      await controller.animateCamera(
        CameraUpdate.newLatLng(markedLocation),
      );
    }
  }

  // Builds the widget tree for the home page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            GoogleMap(
              onMapCreated: (mapController) {
                _mapCompleter.complete(mapController);
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(43.675820, -79.433020),
                zoom: 12.4746,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position:
                      _markedLocation ?? const LatLng(43.675820, -79.433020),
                  infoWindow: InfoWindow(title: defaultAddress),
                ),
              },
            ),
            const Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: OnlineSlider(),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: SchoolMsBottomNavigationBar(onChanged: (index) {}),
            )
          ],
        ),
      ),
    );
  }
}
