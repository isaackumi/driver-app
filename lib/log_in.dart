import 'dart:convert';
import 'package:driver_app/securestorage.dart';
import 'package:driver_app/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Bloc/api_provider.dart';
import 'Bloc/bloc.dart';
import 'common.dart';
import 'dashboard.dart';
import 'endpoints.dart';
import 'internet.dart';

final internet = Internet();
final secured = SecureStorage();
final bloc = Bloc();
final apiProvider = UserApiProvider();
bool load = false;
var userLogin;
double heightScreen, widthScreen;
String name, email, phone;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  bool _obscureText = true;

  AnimationController controller;
  Animation<double> animation;

  final FocusNode _emailPhone = FocusNode();
  final FocusNode _password = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    animation = Tween(
      begin: 0.0,
      end: 4.0,
    ).animate(controller);
    controller.forward();
    load = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  final String assetName = 'assets/car.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: animation,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            widthScreen = MediaQuery.of(context).size.width;
            heightScreen = MediaQuery.of(context).size.height;
            return new Container(
              height: heightScreen,
              width: widthScreen,
              color: Color(0xffFFFFFF),
              child: new SingleChildScrollView(
                child: new Container(
                  margin: new EdgeInsets.all(20.0),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                      child: new Form(
                        child: _formUI(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //form details for email/phone, password, forgot password and register
  _formUI() {
    return Column(
      children: <Widget>[
        SizedBox(
          child: SvgPicture.asset(assetName),
          height: 120,
          width: 120,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 15, 0.0, 0.0),
          child: Text(
            "Driver App",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),

        emailPhone(), //Email input box
        password(), //Password Input box
        loginButton(),
        forgotPassword(),
        Utility.loader(load, 0xff05b400), //Login button
        register()
      ],
    );
  }

  emailPhone() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 50, 8, 20),
      child: StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) =>

            TextFormField(
          style: Theme.of(context).textTheme.subtitle2,
          onFieldSubmitted: (data) {
            _fieldFocusChange(context, _emailPhone, _password);
          },
          focusNode: _emailPhone,
          textInputAction: TextInputAction.next,
          onChanged: bloc.emailChanged,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            errorText: snapshot.error,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffd2dae2), width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffd2dae2), width: 2),
            ),
            hintText: 'Email',
            hintStyle: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.normal,
                color: Colors.black54),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(),
          ),
          //initialValue:
        ),
      ),
    );
  }

  password() {
    return //Input text for password
        Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
      child: StreamBuilder<String>(
        stream: bloc.password,
        builder: (context, snapshot) => TextFormField(
          style: Theme.of(context).textTheme.subtitle2,
          focusNode: _password,
          textInputAction: TextInputAction.done,
          onChanged: bloc.passwordChanged,
          keyboardType: TextInputType.text,
          obscureText: _obscureText,
          onFieldSubmitted: (snapshot) {
            loginRequest(context, snapshot);
          },
          decoration: InputDecoration(
            errorText: snapshot.error,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffd2dae2), width: 2.0),
            ),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffd2dae2), width: 2),
            ),
            hintText: 'Password',
            hintStyle: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.normal,
                color: Colors.black54),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.black54,
                semanticLabel: _obscureText ? 'show password' : 'hide password',
              ),
            ),
          ),
          //initialValue: "RC1HKCXD",
        ),
      ),
    );
  }

  //Login button for login page
  loginButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
      child: StreamBuilder<bool>(
        stream: bloc.submit,
        builder: (context, snapshot) => RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: snapshot.hasData ? Colors.blueAccent : Colors.blue,

          onPressed: () =>
              snapshot.hasData ? loginRequest(context, snapshot) : doNothing(),
          elevation: 4,
          textColor: Colors.white,
          child: Container(
            height: heightScreen * 0.070,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text('Log In', style: Theme.of(context).textTheme.headline6),
          ),
        ),
      ),
    );
  }

  //for switching to the next formfield using the inputActionType on the keyboardtype
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //Forgot password
  forgotPassword() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.5, 0, 0),
      child: Container(
        alignment: Alignment.center,
        child: new TextButton(
          child: Text(
            'Forgot Password?',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          onPressed: () {
            //future works
//            Navigator.push(
//                context, CupertinoPageRoute(builder: (context) => Login()));
          },
        ),
      ),
    );
  }

  //Sign up

  register() {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: new TextButton(
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                  child: Container(
                    child: Align(
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: Theme.of(context).textTheme.subtitle1,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sign Up',
                                style: Theme.of(context).textTheme.headline2)
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  //Login Post Request to User Login API
  loginRequest(BuildContext context, snapshot) async {
    var user = bloc.userDetails();
    print(user);
    var result = await internet.checkInternetConnectivity(context);
    setState(() {
      load = result;
    });
    print(result);
    userLogin = await apiProvider.userLogin(context,
        Endpoints.loginUrl(), {
      "email": "${user['email']}",
      "password": "${user['password']}",
    });
    var response = json.decode(userLogin["body"]);
    print("res:");
    print(response);
    print(response['message']);

    var statusCode = int.parse(userLogin['statusCode']);
    print(statusCode);
    statusCode == 200
        ? successActivity(response)
        : failedActivity(response['message']);
  }

  successActivity(param) async {
    secured.getInstance().write(key: "token", value: param['token']);
    secured.getInstance().write(key: "email", value: param['user']['email']);
    secured.getInstance().write(key: "name", value: param['user']['name']);
    secured.getInstance().write(key: "phone", value: param['user']['phone']);
    secured.getInstance().write(key: "userID", value: param['user']['_id']);
    //Navigator.pushReplacementNamed(context, "/dash");
    email = await secured.getInstance().read(key: "email");
    phone = await secured.getInstance().read(key: "phone");
    name = await secured.getInstance().read(key: "name");
    //name = await secured.getInstance().read(key: "userID");

    if (name != null) {
      Utility.removeIt("body");
      Utility.removeIt("statusCode");
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          settings: const RouteSettings(name: '/dash'),
          builder: (context) => new Dashboard()));
      print(await secured.getInstance().read(key: "email"));
    }
  }

  failedActivity(value) {
    Utility.appSnackBar(context, value, "Failed", 0xffff2e63);
    Utility.removeIt("body");
    Utility.removeIt("statusCode");

    setState(() {
      load = false;
    });
  }

  doNothing() {
    print("nothing");
  }
}
