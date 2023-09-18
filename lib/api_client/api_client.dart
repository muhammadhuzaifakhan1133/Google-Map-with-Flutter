import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:it_coderz_test/app/app.locator.dart';
import 'package:it_coderz_test/utils/api_constants.dart';
import 'package:it_coderz_test/widgets/loader_dialog.dart';
import 'package:stacked_services/stacked_services.dart';

class ApiClient {
  Future<dynamic> sendData({
    required String endpoint,
    required Map<String, String> headers,
    required Object? body,
    Map<String, dynamic>? queryParams,
    bool showError = true,
    bool isLoadershow = false,
    String Function(http.Response)? onError,
    SendMethod sendMethod = SendMethod.POST,
  }) async {
    if (isLoadershow) loaderDialog();
    final url = Uri.https(ApiConstants.baseUrl, endpoint, queryParams);
    String encodedBody = jsonEncode(body);
    late Future<http.Response> response;
    if (sendMethod == SendMethod.POST) {
      response = http.post(url, headers: headers, body: encodedBody);
    } else if (sendMethod == SendMethod.GET) {
      response = http.get(url, headers: headers);
    } else if (sendMethod == SendMethod.PUT) {
      response = http.put(url, headers: headers, body: encodedBody);
    } else if (sendMethod == SendMethod.DELETE) {
      response = http.delete(url, headers: headers);
    } else if (sendMethod == SendMethod.PATCH) {
      response = http.patch(url, headers: headers, body: encodedBody);
    }
    // ignore: avoid_print
    print("Calling ${sendMethod.toString().split('.').last} API: $url");
    // ignore: use_build_context_synchronously
    return await _handleResponse<dynamic>(
        response: response,
        showError: showError,
        isLoaderShow: isLoadershow,
        onError: onError);
  }

  Future<dynamic> sendDataWithImages({
    required String endpoint,
    required Map<String, String> headers,
    required Map<String, dynamic> body,
    required List<String> filePaths,
    required String fileKey,
    Map<String, dynamic>? queryParams,
    bool isLoaderShow = false,
    bool showError = true,
    String Function(http.Response)? onError,
  }) async {
    if (isLoaderShow) loaderDialog();
    final url = Uri.http(ApiConstants.baseUrl, endpoint, queryParams);
    var request = http.MultipartRequest("POST", url);
    for (String filePath in filePaths) {
      var bytes = File(filePath).readAsBytesSync();
      var filename = filePath.split("/").last;
      var multipartFile = http.MultipartFile.fromBytes(
        fileKey,
        bytes,
        filename: filename,
      );
      request.files.add(multipartFile);
    }
    for (var key in headers.keys) {
      request.headers[key] = headers[key]!;
    }
    for (var key in body.keys) {
      request.fields[key] = body[key];
    }
    final streamResponse = await request.send();
    final response = http.Response.fromStream(streamResponse);
    // ignore: use_build_context_synchronously
    return _handleResponse(
        response: response,
        isLoaderShow: isLoaderShow,
        showError: showError,
        onError: onError);
  }

  _handleResponse<T>({
    required Future<http.Response> response,
    required bool showError,
    required bool isLoaderShow,
    String Function(http.Response)? onError,
  }) async {
    final res = await response;
    if (isLoaderShow) locator<NavigationService>().back();
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body);
    } else {
      if (showError) {
        String error = onError == null ? jsonDecode(res.body) : onError(res);
        locator<DialogService>().showDialog(
          title: "Error",
          description: error,
        );
      }
    }
  }
}

enum SendMethod { POST, GET, PUT, DELETE, PATCH }
