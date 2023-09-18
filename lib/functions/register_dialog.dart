import 'package:flutter/material.dart';
import 'package:it_coderz_test/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';


void setupDialogUi() {
final dialogService = locator<DialogService>();

final builders = {
  "Loader": (context, sheetRequest, completer) =>
    _BasicDialog(request: sheetRequest, completer: completer),
};

 dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest request;
final Function(DialogResponse) completer;
  const _BasicDialog({super.key, required this.request, required this.completer});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}