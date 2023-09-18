import 'package:flutter/material.dart';
import 'package:it_coderz_test/ui/home/home_viewmodel.dart';

class ButtonForCurrentLocation extends StatelessWidget {
  final HomeViewModel viewModel;
  const ButtonForCurrentLocation({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 60,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: IconButton(
          onPressed: () {
            viewModel.goToCurrentPosition();
          },
          icon: const Icon(
            Icons.location_on,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
