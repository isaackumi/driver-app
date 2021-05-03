import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

Map<String, String> object = new Map();

class Utility {
  //code base for toast
  static toast(BuildContext context, String text) {
    Toast.show("$text", context,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Color(0xff535c68),
        //Colors.white,
        textColor: Colors.white,
        //Color(0xff1B2A53),
        gravity: Toast.BOTTOM,
        backgroundRadius: 5);
  }

  static removeIt(String item){
    return object.remove(item);
  }


  static map(dynamic key, dynamic value) {
    object.putIfAbsent("$key", () => "$value");
  }

  static loader(bool load, dynamic value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 1),
      child: Container(
        child: load
            ? Container(
          color: Colors.transparent,
          width: 60.0,
          height: 60.0,
          child: new Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Center(
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.greenAccent,
                  ))),
        )
            : new Container(),
      ),
    );
  }


  static appSnackBar(context, String message, String title, dynamic color) {
    return Flushbar(
      title: "$title",
      message: "$message",
      duration: Duration(seconds: 7),
      backgroundColor: Color(color),
    )..show(context);
  }

  static fromJson() {
    if (object.length > 0) {
      return object;
    }
    return null;
  }


}