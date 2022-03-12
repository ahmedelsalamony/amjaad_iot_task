import 'dart:async';
import 'dart:io';
import 'package:amjaadiot_task/src/business_logic/home_provider.dart';
import 'package:amjaadiot_task/src/data/models/address.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../app/location_helper.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();
  FloatingSearchBarController controller = FloatingSearchBarController();

  // these variables for getPlaceLocation
  Set<Marker> markers = {};
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;

  // these variables for getDirections
  //PlaceDirections? placeDirections;
  var progressIndicator = false;
  late List<LatLng> polylinePoints;
  var isSearchedPlaceMarkerClicked = false;
  var isTimeAndDistanceVisible = false;
  late String time;
  late String distance;

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  @override
  initState() {
    super.initState();
    getMyCurrentLocation();
  }

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.determinePosition().whenComplete(() {
      setState(() {});
    });
  }

  Widget buildMap() {
    return PlacePicker(
      apiKey: Platform.isAndroid
          ? "AIzaSyBq_HyWPQWoIy7fyTd9mZOhN-2U7Wa31Eg"
          : "YOUR IOS API KEY",
      onPlacePicked: (result) async {
        Provider.of<HomeProvider>(context, listen: false).insertNewAddress(
            Address(result.formattedAddress!, const Uuid().v1()));
        Navigator.of(context).pop();
      },
      initialPosition: LatLng(position!.latitude, position!.longitude),
      useCurrentLocation: true,
      selectText: '',
    );

    // return GoogleMap(
    //   mapType: MapType.normal,
    //   myLocationEnabled: true,
    //   zoomControlsEnabled: false,
    //   myLocationButtonEnabled: false,
    //   initialCameraPosition: _myCurrentLocationCameraPosition,
    //   markers: markers,
    //   onMapCreated: (GoogleMapController controller) {
    //     _mapController.complete(controller);
    //   },
    // );
  }

  void buildCurrentLocationMarker() {
    currentLocationMarker = Marker(
      position: LatLng(position!.latitude, position!.longitude),
      markerId: const MarkerId('2'),
      onTap: () {},
      infoWindow: const InfoWindow(title: "Your current Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarkerToMarkersAndUpdateUI(currentLocationMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap()
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: _goToMyCurrentLocation,
          child: const Icon(Icons.place, color: Colors.white),
        ),
      ),
    ));
  }
}
