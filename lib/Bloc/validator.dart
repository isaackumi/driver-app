import 'dart:async';

mixin Validators {
  //email or phone validator for login page and forgot password page
  final emailValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    String pattern =
        r'(^(?:[+0]9)?[0-9]{10,12}$)'; //Phone number regulation expression
    //Email regular expression
    String patternEmail =
        r'^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)\.([A-Za-z]{2,})$)';
    RegExp regex = new RegExp(pattern);
    RegExp regexEmail = new RegExp(patternEmail);
    if ((regexEmail.hasMatch(email)) ||
        ((regex.hasMatch(email)) && email.length == 10)) {
      sink.add(email);
    }
    else
      sink.addError("Email is invalid");
  });




  //password validator for login page
  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        //Minimum eight characters, at least one letter and one number
        //String passwordPattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
        //RegExp regexPassword = new RegExp(passwordPattern);
        //if (regexPassword.hasMatch(password)) {

        if (password.length >= 6) {
          sink.add(password);
          ///sink.add(password);
        } else if (password.length < 6) {
          sink.addError("Password must be more than 6s chars.");
        }

        else {
          sink.addError("Password must be correct.");
        }
      });




  //password validator
  final oldPasswordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length >= 6) {
          sink.add(password);
        } else {
          sink.addError("Password require more than 6 characters.");
        }
      });

  final nameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (name, sink) {
        if (name.length >= 8) {
          sink.add(name);
        } else {
          sink.addError("Name require more than 8 characters.");
        }
      });




  //qrCode validator for register property page
  final otpCodeValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (otpCode, sink) {
        if (otpCode.length == 4) {
          sink.add(otpCode);
        } else {
          sink.addError("Invalid OTP Code.");
        }
      });




  //password validator
  final deviceValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (device, sink) {
        if (device.length >= 8) {
          sink.add(device);
        } else {
          sink.addError("Password require more than 8 characters.");
        }
      });
}
