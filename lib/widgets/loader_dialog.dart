import 'package:it_coderz_test/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';

Future<dynamic> loaderDialog() {
  return locator<DialogService>().showCustomDialog(
    variant: "Loader",
  );
}
