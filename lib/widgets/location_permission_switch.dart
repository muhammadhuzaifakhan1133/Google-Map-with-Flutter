import 'package:flutter/material.dart';
import 'package:it_coderz_test/ui/home/home_viewmodel.dart';

class LocationPermissionSwitch extends StatelessWidget {
  final HomeViewModel viewModel;
  const LocationPermissionSwitch({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text("Permission"),
          const SizedBox(width: 15),
          Switch(
              value: viewModel.isLocationEnable,
              onChanged: (value) {
                viewModel.changeLocationPermission();
              })
        ],
      ),
    );
  }
}
