import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';


class Internet {
  Future<bool> checkInternetConnectivity(BuildContext context) async {
    var result = await Connectivity().checkConnectivity();
    print(result);
    if (result == ConnectivityResult.none) {
      internetAlert(context, "No Internet",
          "  Check your internet connection.");
//      showDialogInternet(context, 'No Internet',
//          "Unable to connect. Please Check Internet Connection");
      return false;
    }
    return true;
  }

  void internetAlert(BuildContext context, title, subtitle) {
    return SweetAlert.show(context, title: "$title", subtitle: "$subtitle");
  }

//  void showDialogInternet(BuildContext context, title, text) {
//    showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            title: Text(
//              title,
//              style: TextStyle(color: Colors.black),
//            ),
//            content: Text(
//              text,
//              style: TextStyle(color: Colors.black),
//            ),
//            actions: <Widget>[
//              FlatButton(
//                child: Text(
//                  'Ok',
//                  style: TextStyle(color: Colors.black),
//                ),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              )
//            ],
//          );
//        });
//  }
}
