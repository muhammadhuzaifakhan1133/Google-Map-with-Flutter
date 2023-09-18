import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:it_coderz_test/api_client/api_client.dart';
import 'package:it_coderz_test/utils/api_constants.dart';

class MapServices {
  final ApiClient _apiClient = ApiClient();
  Future<String?> getAddressFromLatLng(LatLng latLng) async {
    final response = await _apiClient.sendData(
      endpoint: ApiConstants.getAddress,
      sendMethod: SendMethod.GET,
      queryParams: {
        "key": "AIzaSyCiWQDqz7jWLdsYvMmQGCqOCQSmUuQzgdM",
        "language": "en",
        "latlng": "${latLng.latitude},${latLng.longitude}",
      },
      headers: {},
      body: {},
    );
    if (response != null) {
      return response["results"][0]["formatted_address"];
    }
    return null;
  }
}
