import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:it_coderz_test/ui/home/home_viewmodel.dart';

class GoogleMapWidget extends StatelessWidget {
  final HomeViewModel viewModel;
  const GoogleMapWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: viewModel.cameraPosition,
      mapType: MapType.hybrid,
      zoomControlsEnabled: false,
      markers: viewModel.markers,
      circles: viewModel.circles,
      onMapCreated: (GoogleMapController controller) {
        viewModel.mapController.complete(controller);
      },
    );
  }
}
