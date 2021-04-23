import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:registration_form_app/models/profile.dart';

class BasicInfoProvider with ChangeNotifier {
  bool _passwordVisible = false;
  ValidationItem _firstName = ValidationItem(null, null);
  ValidationItem _lastName = ValidationItem(null, null);
  ValidationItem _phoneNumber = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _gender = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  ValidationItem _confirmPassword = ValidationItem(null, null);
  ImageItem _image = ImageItem(null, null);

  // Basic Info
  ValidationItem get firstName => _firstName;
  ValidationItem get lastName => _lastName;
  ValidationItem get phoneNumber => _phoneNumber;
  ValidationItem get email => _email;
  ValidationItem get gender => _gender;
  ValidationItem get password => _password;
  ValidationItem get confirmPassword => _confirmPassword;
  ImageItem get image => _image;
  bool get passwordVisible => _passwordVisible;

  //Validation for characters
  final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');

  bool get isBasicInfoValid {
    if (_firstName.value != null &&
        _lastName.value != null &&
        _phoneNumber.value != null &&
        _email.value != null &&
        _password.value != null &&
        _confirmPassword.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void toggleVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  void validateFirstName(String value) {
    if (value.length >= 3) {
      _firstName = ValidationItem(value, null);
      if (validCharacters.hasMatch(value)) {
        _firstName = ValidationItem(value, null);
      } else {
        _firstName = ValidationItem(null, "Only characters accepted");
      }
    } else {
      _firstName = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void validateLastName(String value) {
    if (value.length >= 3) {
      _lastName = ValidationItem(value, null);
      if (validCharacters.hasMatch(value)) {
        _lastName = ValidationItem(value, null);
      } else {
        _lastName = ValidationItem(null, "Only characters accepted");
      }
    } else {
      _lastName = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void validatePhoneNumer(String value) {
    if (value.length == 10) {
      _phoneNumber = ValidationItem(value, null);
    } else {
      _phoneNumber = ValidationItem(null, "Minimum 10 numbers required");
    }
    notifyListeners();
  }

  void validateEmail(String value) {
    if (value.isNotEmpty) {
      if (EmailValidator.validate(value)) {
        _email = ValidationItem(value, null);
      } else {
        _email = ValidationItem(null, "Invalid Email");
      }
    } else {
      _email = ValidationItem(null, "Email required");
    }

    notifyListeners();
  }

  void changePassword(String value) {
    if (value.isNotEmpty) {
      print(isPasswordCompliant(value));
      if (isPasswordCompliant(value)) {
        _password = ValidationItem(value, null);
      } else {
        _password =
            ValidationItem(null, "Weak Password (Minumum combination of 8)");
      }
    } else {
      _password = ValidationItem(null, "Password required");
    }

    notifyListeners();
  }

  void changeConfirmPassword(String value) {
    if (value.isNotEmpty) {
      print(_password.value);
      print(value);
      if (_password.value == value) {
        _confirmPassword = ValidationItem(value, null);
      } else {
        _confirmPassword = ValidationItem(null, "Password does not match");
      }
    } else {
      _confirmPassword = ValidationItem(null, "Password required");
    }

    notifyListeners();
  }

  void changeGender(String value) {
    print(value);
    _gender = ValidationItem(value, null);
    notifyListeners();
  }

  bool isPasswordCompliant(String password, [int minLength = 8]) {
    if (password == null || password.length < minLength) {
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    if (hasUppercase) {
      bool hasDigits = password.contains(RegExp(r'[0-9]'));
      if (hasDigits) {
        bool hasLowercase = password.contains(RegExp(r'[a-z]'));
        if (hasLowercase) {
          bool hasSpecialCharacters =
              password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
          return hasSpecialCharacters;
        }
      }
    }

    return false;
  }

  void setImage(File imageFile) {
    _image = ImageItem(imageFile, null);
    notifyListeners();
  }
}
