import 'package:fillproject/components/MyText.dart';

class MyValidation {
  int snackCounter = 0;

  RegExp regexPassword = new RegExp(r'^(?=.*?[A-Z])(?=.*[0-9])(?=.{8,})');
  RegExp regexSpace = new RegExp(r'\s');
  RegExp regexEmail = new RegExp(r'^(\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$)');

  String validatePhone(String phone, bool brPostoji) {
    if (phone == '') {
      return MyText().regPhoneSnack;
    } 
    else if (brPostoji) {
      return MyText().numberExists;
    }
    
    return null;
  }

  String validateUsername(String username, bool usernamePostoji) {
    if (username == '') {
      return MyText().regUserSnack;
    } else if (regexSpace.hasMatch(username) == true) {
      return MyText().validateSpaceUsername;
    } else if (usernamePostoji) {
      return MyText().usernameExist;
    }
    return null;
  }

  String validatePassword(String password) {
    if (password == '') {
      return MyText().regPassSnack;
    } else if (password.length < 8) {
      return MyText().regPassLengthSnack;
    } else if (regexPassword.hasMatch(password) == false) {
      return MyText().regexPasswordSnack;
    } else if (regexSpace.hasMatch(password) == true) {
      return MyText().validateSpacePassword;
    }
    return null;
  }

  String validateEmail(String input, int counter) {
    if (input == '') {
      counter = 0;
      return MyText().regEmailSnack;
    } else if(regexEmail.hasMatch(input) == false) {
      counter =0 ;
            return MyText().validEmail;
    }
    return null;
  }
}
