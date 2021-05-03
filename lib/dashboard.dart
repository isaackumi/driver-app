import 'package:driver_app/qr_code_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Login.dart';
import 'barcode.dart';


double widthScreen, heightScreen;
String name, email;



class Dashboard extends StatefulWidget {
  Dashboard({Key key,}) : super(key: key);


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(
                child: Text(
                  "Driver App",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: Theme.of(context).textTheme.headline4,
                )),
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.more_vert),
                  color: Colors.white,
                  onPressed: () {
                    var route = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new LoginPage());
                    Navigator.of(context).push(route);
                    //showLogOutDialog(context);
                  })
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            widthScreen = MediaQuery.of(context).size.width;
            heightScreen = MediaQuery.of(context).size.height;
            return new Container(
              height: heightScreen,
              width: widthScreen,
              color: Color(0xffffdf9),
              child: new SingleChildScrollView(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: new Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text("Welcome, Kumi",style: TextStyle(color: Colors.white),)
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              )),
                          height: heightScreen * 0.22,
                          width: widthScreen,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.lightBlue])
                            //color: Color.fromRGBO(35, 60, 103, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                           //nothing
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                                color: Colors.white,
                                height: heightScreen * 0.120,
                                width: widthScreen,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18.0),
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                Color(0xff88e1f2),
                                                BlendMode.modulate),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: SvgPicture.asset(
                                                  "assets/reg.svg",
                                                  fit: BoxFit.cover,
                                                  height: heightScreen * 0.070,
                                                  width: widthScreen * 0.140),
                                            )),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: widthScreen * 0.165),
                                          child: Text(
                                            "Register",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: widthScreen * 0.165),
                                          child: Text(
                                            "New User",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: heightScreen * 0.140,
                                      width: 10,
                                      child: Container(
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        BarcodeScan()));
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                                color: Colors.white,
                                height: heightScreen * 0.120,
                                width: widthScreen,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18.0),
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                Color(0xffF8EFBA),
                                                BlendMode.modulate),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: SvgPicture.asset(
                                                  "assets/scan.svg",
                                                  fit: BoxFit.cover,
                                                  height: heightScreen * 0.070,
                                                  width: widthScreen * 0.140),
                                            )),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: widthScreen * 0.165),
                                          child: Text(
                                            "Qr_Code",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: widthScreen * 0.165),
                                          child: Text(
                                            "Generate Qr_Code",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: heightScreen * 0.140,
                                      width: 10,
                                      child: Container(
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            //nothing
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        BarcodePage()));
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                                color: Colors.white,
                                height: heightScreen * 0.120,
                                width: widthScreen,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18.0),
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                Color(0xffF8EFBA),
                                                BlendMode.modulate),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: SvgPicture.asset(
                                                  "assets/document.svg",
                                                  fit: BoxFit.cover,
                                                  height: heightScreen * 0.070,
                                                  width: widthScreen * 0.140),
                                            )),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: widthScreen * 0.165),
                                          child: Text(
                                            "Verify Qr Code",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: widthScreen * 0.165),
                                          child: Text(
                                            "Previous registry",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: heightScreen * 0.140,
                                      width: 10,
                                      child: Container(
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                           //
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                                color: Colors.white,
                                height: heightScreen * 0.120,
                                width: widthScreen,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(18.0),
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                Color(0xffF8EFBA),
                                                BlendMode.modulate),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: SvgPicture.asset(
                                                  "assets/businessman.svg",
                                                  fit: BoxFit.cover,
                                                  height: heightScreen * 0.070,
                                                  width: widthScreen * 0.140),
                                            )),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: widthScreen * 0.165),
                                          child: Text(
                                            "Test",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: widthScreen * 0.165),
                                          child: Text(
                                            "Driver Test Performance",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: heightScreen * 0.140,
                                      width: 10,
                                      child: Container(
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),

      ),
    );
  }


}
