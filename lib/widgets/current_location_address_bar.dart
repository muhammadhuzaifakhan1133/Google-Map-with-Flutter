import 'package:flutter/material.dart';
import 'package:it_coderz_test/ui/home/home_viewmodel.dart';
import 'package:it_coderz_test/utils/extension.dart';

class CurrentLocationAddressBar extends StatelessWidget {
  final HomeViewModel viewModel;
  const CurrentLocationAddressBar({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: context.width * 0.85,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          "Current Location: ${viewModel.currentAddress ?? "Not Available"}",
        ),
      ),
    );
  }
}