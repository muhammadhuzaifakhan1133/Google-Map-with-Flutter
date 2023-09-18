import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:it_coderz_test/app/app.locator.dart';
import 'package:it_coderz_test/services/map_services.dart';
import 'package:it_coderz_test/widgets/loader_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 19.151926040649414,
  );
  Position? currentPosition;
  String? currentAddress;
  Set<Marker> markers = const <Marker>{};
  Set<Circle> circles = const <Circle>{};
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  bool isLocationEnable = false;

  determineLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      isLocationEnable = true;
    } else {
      isLocationEnable = false;
    }
    notifyListeners();
  }

  changeLocationPermission() async {
    if (!isLocationEnable) {
      await Geolocator.requestPermission();
      await determineLocationPermission();
    } else {
      isLocationEnable = false;
      notifyListeners();
    }
  }

  goToCurrentPosition() async {
    loaderDialog();
    final GoogleMapController controller = await mapController.future;
    currentPosition = await _determinePosition();
    if (currentPosition != null) {
      isLocationEnable = true;
      final currentPositionLatLng =
          LatLng(currentPosition!.latitude, currentPosition!.longitude);
      currentAddress =
          await MapServices().getAddressFromLatLng(currentPositionLatLng);
      locator<NavigationService>().back();
      markers = {
        Marker(
            markerId: const MarkerId("currentLocation"),
            position: currentPositionLatLng)
      };
      circles = {
        Circle(
            circleId: const CircleId("currentLocation"),
            center: currentPositionLatLng,
            fillColor: Colors.blue[50]!.withOpacity(0.65),
            strokeWidth: 0,
            radius: 5000)
      };
      await controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 19.151926040649414,
              target: LatLng(
                  currentPosition!.latitude, currentPosition!.longitude))));
      notifyListeners();
    } else {
      locator<NavigationService>().back();
    }
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Location services are disabled.');
      return null;
    }
    if (!isLocationEnable) {
      Fluttertoast.showToast(msg: 'Location Permission is not allowed.');
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }
}
