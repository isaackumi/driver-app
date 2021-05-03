import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'common.dart';
import 'dashboard.dart';

double heightScreen, widthScreen;
bool haveIt = false;

class BarcodePage extends StatefulWidget {
  @override
  _BarcodePageState createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  ScanResult scanResult;
  final _barcodeController = TextEditingController();

  Future scan() async {
    try {
      var barcode = await BarcodeScanner.scan();
      setState(() {
        scanResult = barcode;
        _barcodeController.text = scanResult.rawContent;
        haveIt = true;
      });
      print(_barcodeController.text);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          Utility.toast(
            context,
            "Camera permission was denied",
          );
        });
      } else {
        setState(() {
          Utility.toast(
            context,
            "Unknown error",
          );
        });
      }
    } on FormatException {
      setState(() {
        Utility.toast(context, "You clicked before scanning");
      });
    } catch (e) {
      setState(() {
        Utility.toast(
          context,
          "Unknown error",
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              widthScreen = MediaQuery.of(context).size.width;
              heightScreen = MediaQuery.of(context).size.height;

              return new Container(
                  height: heightScreen,
                  width: widthScreen,
                  color: Color(0xffffdf9),
                  child: Padding(
                    padding: const EdgeInsets.only(top:80.0),
                    child: new Column(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                scan();
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.0),
                                child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        Color(0xffffffff), BlendMode.modulate),
                                    child: SvgPicture.asset(
                                        "assets/scanner.svg",
                                        fit: BoxFit.cover,
                                        height: heightScreen * 0.240,
                                        width: widthScreen * 0.180)),
                              ),
                            ),
                          ),
                        ),
                        haveIt != true
                            ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Click to Scan",
                            style: TextStyle(
                                color: Colors.blue, fontSize: 17),
                          ),
                        )
                            : Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 50.0, left: 25, right: 25, bottom: 8),
                              child:  TextFormField(
                                onFieldSubmitted: (data) {
                        nextButton();
                        },
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0),
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0),
                            ),
                            hintText: haveIt == true
                                ? _barcodeController.text
                                : 'Barcode',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Roboto',
                                fontSize: 18.0,
                                color: Colors.black),
                            contentPadding: EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                          ),
                        )
                            )),



                        Expanded(flex: 7, child: SizedBox(height: 300,),),




                        Flexible(
                          flex: 2,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          Dashboard()));
                            },
                            child: Container(
                                height: heightScreen * 0.45,
                                width: widthScreen,
                                color: Colors.blue,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: heightScreen * 0.073,
                                      width: widthScreen * 0.85,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, left: 8, right: 8),
                                          child: Text('Back',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'EBGaramond',
                                                  fontSize: 21)),
                                        ),
                                      ),

                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ));
            }));
  }

  nextButton() async {


   //okay

  }
}
