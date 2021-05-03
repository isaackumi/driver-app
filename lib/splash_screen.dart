import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter_svg/svg.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    animation = Tween(
      begin: 0.0,
      end: 4.0,
    ).animate(controller);
    controller.forward();
  }



  Future<Timer> loading() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    _moveToLogin(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:90.0),
              child: Center(child:  Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    child: SvgPicture.asset(
                        "assets/car.svg",
                        fit: BoxFit.cover,
                        height: 70,
                        width: 80),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Driver App...", style: TextStyle(fontSize: 18),),
                  )
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation(Color(0xff795548))),
                ],
              ),
            ),
          ],
        ));
  }

  _moveToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }
}
