import 'dart:async';
import 'dart:convert';

import 'package:driver_app/securestorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Bloc/api_provider.dart';
import 'Bloc/bloc.dart';
import 'common.dart';
import 'internet.dart';

final secured = SecureStorage();
final internet = Internet();

final apiProvider = UserApiProvider();

final bloc = Bloc();
bool load = false;
var userSignUp;

double widthScreen, heightScreen;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureText = true;
  final String assetName = 'assets/car.svg';

  final FocusNode _emailPhone = FocusNode();
  final FocusNode _password = FocusNode();
  final FocusNode _phone = FocusNode();
  final FocusNode _name = FocusNode();

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
            color: Color(0xffFFFFFF),
            child: new SingleChildScrollView(
              child: new Container(
                margin: new EdgeInsets.all(20.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
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
    );
  }

  _formUI() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Create Account",
            style: Theme.of(context).textTheme.headline5,
          ),
        ),

        ClipRRect(
          borderRadius: BorderRadius.circular(18.0),
          child: ColorFiltered(
              colorFilter:
                  ColorFilter.mode(Color(0xffF8EFBA), BlendMode.modulate),
              child: SvgPicture.asset("assets/user.svg",
                  fit: BoxFit.cover, height: 120.0, width: 120.0)),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
          child: Text("Sign up to get started! ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff1e90ff),
                  fontSize: 24,
                  fontFamily: 'EBGaramond')),
        ),
        nameField(),
        phoneField(),
        emailField(), //Email input box
        password(), //Password Input box
        signUpButton(),
        Utility.loader(load, 0xff05b400), //Login button
      ],
    );
  }

  //for switching to the next formfield using the inputActionType on the keyboardtype
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  password() {
    return //Input text for password
        Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 0),
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
            signUpRequest(context, snapshot);
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
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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

  nameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 20),
      child: StreamBuilder<String>(
        stream: bloc.name,
        builder: (context, snapshot) => TextFormField(
          style: Theme.of(context).textTheme.subtitle2,
          onFieldSubmitted: (data) {
            _fieldFocusChange(context, _name, _phone);
          },
          focusNode: _name,
          textInputAction: TextInputAction.next,
          onChanged: bloc.nameChanged,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            errorText: snapshot.error,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffd2dae2), width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffd2dae2), width: 2),
            ),
            hintText: 'Name',
            hintStyle: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.normal,
                color: Colors.black54),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(),
          ),
          //initialValue:
        ),
      ),
    );
  }

  phoneField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 20),
      child: StreamBuilder<String>(
        stream: bloc.phone,
        builder: (context, snapshot) => TextFormField(
          style: Theme.of(context).textTheme.subtitle2,
          onFieldSubmitted: (data) {
            _fieldFocusChange(context, _phone, _emailPhone);
          },
          focusNode: _phone,
          textInputAction: TextInputAction.next,
          onChanged: bloc.phoneChanged,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorText: snapshot.error,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffd2dae2), width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffd2dae2), width: 2),
            ),
            hintText: 'Phone',
            hintStyle: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.normal,
                color: Colors.black54),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(),
          ),
          //initialValue:
        ),
      ),
    );
  }

  emailField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 20),
      child: StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) => TextFormField(
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
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border: OutlineInputBorder(),
          ),
          //initialValue:
        ),
      ),
    );
  }

  signUpButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
      child: StreamBuilder<bool>(
        stream: bloc.submit,
        builder: (context, snapshot) => RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: snapshot.hasData ? Colors.blueAccent : Colors.blue,
          onPressed: () =>
              snapshot.hasData ? signUpRequest(context, snapshot) : doNothing,
          elevation: 4,
          textColor: Colors.white,
          child: Container(
            height: heightScreen * 0.070,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child:
                Text('Sign Up', style: Theme.of(context).textTheme.headline6),
          ),
        ),
      ),
    );
  }

  //Login Post Request to User Login API
  signUpRequest(BuildContext context, snapshot) async {
    var user = bloc.userDetails();
    print(user);
    var result = await internet.checkInternetConnectivity(context);
    setState(() {
      load = result;
    });
    print(result);
    userSignUp = await apiProvider.userSignUp(context,
        "https://food-server-verison.herokuapp.com/food-server/api/v1/users", {
      "email": "${user['email']}",
      "password": "${user['password']}",
      "phone": "${user['phone']}",
      "name": "${user['name']}",
      "userType": "User"
    });
    var response = json.decode(userSignUp["up"]);
    print("res:");
    print(response);
    //print(response['message']);
//print(userSignUp['uCode'] is int);
    //var statusCode = int.parse(userSignUp['uCode']);
   // print(statusCode is String);
   int.parse(userSignUp['uCode']) == 200 ? successActivity() : failedActivity();
  }

  successActivity() {
    setState(() {
      load = false;
    });
    Utility.appSnackBar(context, "You have signed successfully.", "User Registration", 0xff0bd181);
    Utility.removeIt("up");
    Utility.removeIt("uCode");
    loading();
  }
  Future<Timer> loading() async {
    return new Timer(Duration(seconds: 2), moveToLogin);
  }

  moveToLogin() {
    Navigator.pushReplacementNamed(context, "/login");
  }

  failedActivity() {
    Utility.appSnackBar(context, "Sign up failed. Try again.", "Failed", 0xffff2e63);
    Utility.removeIt("up");
    Utility.removeIt("uCode");
    setState(() {
      load = false;
    });
    loading();
    //Navigator.pushReplacementNamed(context, "/login");
//    Future<Timer> loading() async {
//      return new Timer(Duration(seconds: 2), moveToLogin);
//    }
  }

  doNothing(){
    print("do nothing");
  }
}
