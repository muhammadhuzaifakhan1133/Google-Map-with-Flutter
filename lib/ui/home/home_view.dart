import 'package:flutter/material.dart';
import 'package:it_coderz_test/ui/home/home_viewmodel.dart';
import 'package:it_coderz_test/utils/extension.dart';
import 'package:it_coderz_test/widgets/button_for_current_location.dart';
import 'package:it_coderz_test/widgets/current_location_address_bar.dart';
import 'package:it_coderz_test/widgets/google_map_widget.dart';
import 'package:it_coderz_test/widgets/location_permission_switch.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.determineLocationPermission();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              GoogleMapWidget(viewModel: viewModel),
              Positioned(
                top: context.height * 0.05,
                child: CurrentLocationAddressBar(viewModel: viewModel),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LocationPermissionSwitch(viewModel: viewModel),
                    ButtonForCurrentLocation(viewModel: viewModel),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}