import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../common.dart';
import '../securestorage.dart';


final secured = SecureStorage();

class UserApiProvider {
  //API for user login using POST method
  Future<dynamic> userLogin(
      BuildContext context, String loginUrl, var body) async {
    return await http
        .post(
      Uri.encodeFull(loginUrl),
      headers: {
        "Accept": "application/json",
        "App-Version": "1.0.0",
      },
      body: body,
    )
        .then((http.Response response) async {
      Utility.map("statusCode", response.statusCode);
      Utility.map("body", response.body);
      return Utility.fromJson();
    }).catchError((e) {
      print("${e.error}"); // Finally, callback fires.
    });
  }

  //API for user sign up using POST method
  Future<dynamic> userSignUp(
      BuildContext context, String signUpUrl, var body) async {
    return await http
        .post(
      Uri.encodeFull(signUpUrl),
      headers: {
        "Accept": "application/json",
        "App-Version": "1.0.0",
      },
      body: body,
    ).then((http.Response response) async {
      Utility.map("uCode", response.statusCode);
      Utility.map("up", response.body);
      return Utility.fromJson();
    }).catchError((e) {
      print("${e.toString()}"); // Finally, callback fires.
    });
  }

  //API for Forgot Password using POST method
  Future<dynamic> verifyEmail(
      BuildContext context, String forgotUrl, var body) async {
    return await http.post(Uri.encodeFull(forgotUrl), body: body, headers: {
      "Accept": "application/json",
      "App-Version": "1.0.0",
    }).then((http.Response response) async {
      Utility.map("verifyCode", response.statusCode);
      Utility.map("verifyBody", response.body);
      return Utility.fromJson();
    }).catchError((e) {
      print("${e.error}"); // Finally, callback fires.
    });
  }

//Reset Password API
  Future<dynamic> userResetPasswordRequest(
      BuildContext context, String resetUrl, var body) async {
    return await http.post(Uri.encodeFull(resetUrl), body: body, headers: {
      "Accept": "application/json",
      "App-Version": "1.0.0",
    }).then((http.Response response) async {
      //print(response.body);
      Utility.map("Code", response.statusCode);
      Utility.map("Body", response.body);
      return Utility.fromJson();
    }).catchError((e) {
      print("${e.error}"); // Finally, callback fires.
    });
  }

  //API for Change Password using POST method
  Future<dynamic> userChangePassword(
      BuildContext context, String changePasswordUrl, var body) async {
    print("checcking");
    return await http
        .patch(Uri.encodeFull(changePasswordUrl), body: body, headers: {
      "Accept": "application/json",
      "App-Version": "1.0.0",
      "authorization": "Bearer ${await secured.getInstance().read(key: "token")}"
    }).then((http.Response response) async {
      print(response);
      print(response.body);
      Utility.map("cCode", response.statusCode);
      Utility.map("cBody", response.body);
      return Utility.fromJson();
    }).catchError((e) {
      print("${e.error}"); // Finally, callback fires.
    });
  }

//API for OTP using POST
  Future<dynamic> sendCode(
      BuildContext context, String sendCodeUrl, var body) async {
    return await http.patch(Uri.encodeFull(sendCodeUrl), body: body, headers: {
      "Accept": "application/json",
      "App-Version": "1.0.0",
    }).then((http.Response response) async {
      final int statusCode = response.statusCode;
      print(statusCode);
      Utility.map("statusCode", response.statusCode);
      Utility.map("body", response.body);
      return Utility.fromJson();
    }).catchError((e) {
      print("${e.error}"); // Finally, callback fires.
    });
  }



  Future<dynamic> sendFCMTokenToServer(
      BuildContext context, String fcmUrl, var body) async {
    return await http.post(Uri.encodeFull(fcmUrl), body: body, headers: {
      "Accept": "application/json",
      "App-Version": "1.0.0",
      "authorization": "Bearer ${await secured.getInstance().read(key: "token")}"
    }).then((http.Response response) async {
      //print(response.body);
      Utility.map("fcmCode", response.statusCode);
      Utility.map("fcmBody", response.body);
      return Utility.fromJson();
    }).catchError((e) {
      print("${e.error}"); // Finally, callback fires.
    });
  }
}
