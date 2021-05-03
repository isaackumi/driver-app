
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:qr_flutter/qr_flutter.dart';



import 'Login.dart';


double widthScreen, heightScreen;

class BarcodeScan extends StatefulWidget {
  @override
  _BarcodeScanState createState() => _BarcodeScanState();
}

class _BarcodeScanState extends State<BarcodeScan> {
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Here is the text that will generate the barcode";
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Unique Barcode'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuItem(
            child: InkWell(
              child: Text('Logout'),
              onTap: () {
                var route = new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new LoginPage());
                Navigator.of(context).push(route);
              },
            ),
          ),

        ],
      ),
      body: _contentWidget(),
    );
  }



  _contentWidget() {



    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          widthScreen = MediaQuery.of(context).size.width;
          heightScreen = MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            child: Container(
              color: const Color(0xFFFFFFFF),
              height: heightScreen,
              width: widthScreen,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: RepaintBoundary(
                        key: globalKey,
                        child: QrImage(
                          data: _dataString,
                          size: 0.4 * heightScreen,
                        ),
                      ),
                    ),
                  ),



                  Column(children: [

                    Padding(
                      padding:  EdgeInsets.all(heightScreen * 0.033),
                      child: Text("Generate your unique BARCODE.", style: TextStyle(fontSize: 15,),),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          errorText: _inputErrorText,
                          hintText: "Enter your car number plate",
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xffd2dae2), width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xffd2dae2), width: 2),
                          ),
                          hintStyle: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54),
                          contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),




                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FlatButton(
                        color: Colors.green,
                        child: Text("Generate Code", style: TextStyle(color: Colors.white, fontSize: 18),),
                        onPressed: () {
                          setState(() {
                            _dataString = _textController.text;
                            _inputErrorText = null;
                          });
                        },
                      ),
                    )
                  ],)







                ],
              ),
            ),
          );});







  }
}
