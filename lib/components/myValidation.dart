
import 'package:email_validator/email_validator.dart';
import 'package:fillproject/components/MyText.dart';


class MyValidation {
  int snackCounter = 0;

  RegExp regexPassword = new RegExp(r'^(?=.*?[A-Z])(?=.*[0-9])(?=.{8,})');
  RegExp regexSpace = new RegExp(r' /^\S*$/');


  String validatePhone(String phone) {
    if (phone == '') {
      return MyText().regPhoneSnack;
    } 
      return null;
  }

  String validateUsername(String username) {
    if (username == '') {
      return MyText().regUserSnack;
     }
    //  else if(regexSpace.hasMatch(username) == true) {
    //   return 'Space';
    // }
    return null;
  }

  String validatePassword(String password) {
    if (password == '') {
      return MyText().regPassSnack;
    } else if (password.length < 8) {
      return MyText().regPassLengthSnack;
    } else if (regexPassword.hasMatch(password) == false) {
      return MyText().regexPasswordSnack;
    }
    return null;
  }

  String validateEmail(String input, int counter) {
    if (input == '') {
      counter = 0;
      return MyText().regEmailSnack;
    } else if (!EmailValidator.validate(input, true)) {
      counter = 0;
      return MyText().validEmail;
    }
    return null;
  }
}
