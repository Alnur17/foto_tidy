import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../../common/app_color/app_colors.dart';
import '../../common/widgets/custom_snackbar.dart';



class BaseClient {

  static getRequest({required String api, params, headers}) async {

    debugPrint("API Hit: $api");
    debugPrint("Header: $headers");

    http.Response response = await http.get(
      Uri.parse(api).replace(queryParameters: params),
      headers: headers,
    );
    return response;
  }

  static postRequest({required String api, body, headers}) async {

    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.post(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    debugPrint("<================= response ====== ${response.body} ===========>");

    return response;
  }
  static patchRequest({required String api, body,headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.patch(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }

  static putRequest({required String api, body,headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.put(
      Uri.parse(api),
      body: body,
      headers: headers,
    );
    return response;
  }


  static deleteRequest({required String api, body,headers}) async {
    debugPrint("API Hit: $api");
    debugPrint("body: $body");
    http.Response response = await http.delete(
      Uri.parse(api),
      headers: headers,
    );
    return response;
  }


  static handleResponse(http.Response response) async {
    try {
      debugPrint('ResponseCode: ${response.statusCode}');
      debugPrint('ResponseBody: ${response.body}');

      var decodedBody = response.body.isNotEmpty ? jsonDecode(response.body) : null;

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return decodedBody;
      }

      // For all known errors — return decoded response instead of throwing
      if (response.statusCode == 400 ||
          response.statusCode == 401 ||
          response.statusCode == 403 ||
          response.statusCode == 404 ||
          response.statusCode == 406 ||
          response.statusCode == 409 ||
          response.statusCode == 500) {

        // Extract message if available
        String message = decodedBody?['message'] ?? 'Something went wrong.';

        // Show snackbar automatically for quick user feedback
        kSnackBar(message: message, bgColor: AppColors.red);

        // Return decoded body so controller can still handle it
        return decodedBody;
      }

      // Default fallback
      String msg = decodedBody?['message'] ?? 'Unexpected error occurred.';
      kSnackBar(message: msg, bgColor: AppColors.red);
      return decodedBody;

    } on SocketException {
      kSnackBar(message: "No Internet connection", bgColor: AppColors.red);
      throw "No Internet connection";
    } on FormatException {
      kSnackBar(message: "Bad response format", bgColor: AppColors.red);
      throw "Bad response format";
    } catch (e) {
      kSnackBar(message: e.toString(), bgColor: AppColors.red);
      throw e.toString();
    }
  }

  static void logout() {
    //  LocalStorage.removeData(key: AppConstant.token);
    //  Get.offAllNamed(AppRoute.signInScreen);
  }
}