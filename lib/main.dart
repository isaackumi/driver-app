
import 'package:driver_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:native_state/native_state.dart';

import 'dashboard.dart';
import 'log_in.dart';

void main() async {
  runApp(SavedState(child: HomePage()));

  //Setting the orientation
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //Changing the color of the status bar and icons
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff182C61), //top bar color
    statusBarIconBrightness: Brightness.light, //top bar icons
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        //primaryColor: Color(0xff00ABE2),
        accentColor: Color(0xffced6e0),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //fontFamily: 'Roboto',

        //Modifying the appearance of texts in the app
        textTheme: TextTheme(
          subtitle1: TextStyle(
            //in-use
              fontSize: 20.0,
              fontFamily: 'EBGaramond',
              color: Color(0xff303952),
              fontWeight: FontWeight.normal),
          headline3: TextStyle(
            //in-use
              fontSize: 28.0,
              fontFamily: 'EBGaramond',
              color: Colors.black54,
              fontWeight: FontWeight.bold),
          headline5: TextStyle(
            //in-use
              fontSize: 25.0,
              fontFamily: 'EBGaramond',
              color: Colors.black54,
              fontWeight: FontWeight.bold),
          overline: TextStyle(
            //in-use
              fontSize: 10.0,
              fontFamily: 'Lato',
              color: Colors
                  .blueGrey[900], //Color(0xff1B2A53), //Colors.lightBlue[900],
              fontWeight: FontWeight.normal),
          headline6: TextStyle(
            //in-use
              fontSize: 22.0,
              fontFamily: 'EBGaramond',
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
          subtitle2: TextStyle(
            //in-use
              fontSize: 15.0,
              fontFamily: 'EBGaramond',
              color: Color(0xff5d4037),
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal),
          headline2: TextStyle(
            //in-use
              fontSize: 15.0,
              fontFamily: 'Roboto',
              color: Colors.blue[600],
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
          headline4: TextStyle(
            fontSize: 21.0,
            fontFamily: 'EBGaramond',
            color: Color(0xff795548),
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
          bodyText1: TextStyle(
            fontSize: 21.0, //in-use
            fontFamily: 'Roboto',
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          bodyText2: TextStyle(
            fontSize: 14.0,
            fontFamily: 'EBGaramond',
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      // initialRoute: SavedStateRouteObserver.restoreRoute(savedState) ?? "/",
      home: new SplashScreen(),
      routes: routes,
    );
  }
}

//Routes for the different pages in the app
var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => SplashScreen(),
  "/login": (BuildContext context) => Login(),
  "/dashboard": (BuildContext context) => Dashboard(),
};
