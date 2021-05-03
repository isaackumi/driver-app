import 'dart:async';
import 'package:driver_app/Bloc/validator.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators implements BaseBloc {
  //Creating streamControllers for your field inputs
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _forgotController = BehaviorSubject<String>();
  final _otpCodeController = BehaviorSubject<String>();
  final _oldPasswordController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _deviceNameController = BehaviorSubject<String>();
  final _serialController = BehaviorSubject<String>();
  final _tempPasswordController = BehaviorSubject<String>();

  //defining a map to controller value
  userDetails() {
    Map<String, String> user = new Map();
    user.putIfAbsent("email", () => _emailController.value);
    user.putIfAbsent("name", () => _nameController.value);
    user.putIfAbsent("password", () => _passwordController.value);
    user.putIfAbsent("forgot", () => _forgotController.value);
    user.putIfAbsent("otpCode", () => _otpCodeController.value);
    user.putIfAbsent("oldPassword", () => _oldPasswordController.value);
    user.putIfAbsent("phone", () => _phoneController.value);
    user.putIfAbsent("deviceName", () => _deviceNameController.value);
    user.putIfAbsent("serial", () => _serialController.value);
    user.putIfAbsent("tempPassword", () => _tempPasswordController.value);
    return user;
  }

  //Stream sinks for changing email, password, forgot password and otp
  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get nameChanged => _nameController.sink.add;
  Function(String) get phoneChanged => _phoneController.sink.add;
  Function(String) get forgotChanged => _forgotController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;
  Function(String) get otpCodeChanged => _otpCodeController.sink.add;
  Function(String) get oldPasswordChanged => _oldPasswordController.sink.add;
  Function(String) get deviceNameChanged => _deviceNameController.sink.add;
  Function(String) get serialChanged => _serialController.sink.add;
  Function(String) get tempPasswordChanged => _tempPasswordController.sink.add;



  //Creating stream to handle inputs and validation
  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get name => _nameController.stream.transform(nameValidator);

  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<String> get forgot =>
      _forgotController.stream.transform(emailValidator);

  Stream<String> get otpCode =>
      _otpCodeController.stream.transform(otpCodeValidator);

  Stream<String> get phone =>
      _otpCodeController.stream.transform(emailValidator);

  Stream<String> get oldPassword =>
      _oldPasswordController.stream.transform(oldPasswordValidator);

  Stream<String> get deviceName =>
      _deviceNameController.stream.transform(deviceValidator);

  Stream<String> get serial =>
      _serialController.stream.transform(deviceValidator);

  Stream<String> get tempPassword =>
      _serialController.stream.transform(passwordValidator);



//outcome of validation

  //Creating a boolean stream to enable submit button
  Stream<bool> get submit =>
      Observable.combineLatest2(email, password, (e, p) => true);

  Stream<bool> get setPassword =>
      Observable.combineLatest3(tempPassword, oldPassword,  password, (t, o, p) => true);

  //Creating a boolean stream to enable submit button
  Stream<bool> get addNew =>
      Observable.combineLatest2(deviceName, serial, (d, s) => true);

  //Creating a boolean stream to enable submit button
  Stream<bool> get signUp =>
      Observable.combineLatest4(email, password, name, phone, (e, p, n, t) => true);

  //Creating boolean stream to enable forgot button
  Observable<bool> get submitForgot => forgot.map((forgot) => true);

  //Creating boolean stream to enable register button
  Observable<bool> get otpCodeRegister => otpCode.map((otpCode) => true);

  //Creating a boolean stream to enable submit button on changePassword Page
  Stream<bool> get submitNewPassword =>
      Observable.combineLatest2(oldPassword, password,  (o, p) => true);

  //Closing the streamControllers
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController?.close();
    _passwordController?.close();
    _forgotController?.close();
    _otpCodeController?.close();
    _oldPasswordController?.close();
    _phoneController?.close();
    _deviceNameController?.close();
    _serialController?.close();
    _tempPasswordController?.close();
    _nameController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
