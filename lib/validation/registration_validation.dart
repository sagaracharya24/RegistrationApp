import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:registration_form_app/validation/validation_item.dart';

enum Pages {
  BasicInfo,
  PerofessionalInfo,
  Address,
}

class RegistrationValidation with ChangeNotifier {
  Pages _page = Pages.BasicInfo;

  //Basic Info Variables
  bool _passwordVisible = false;
  ValidationItem _firstName = ValidationItem(null, null);
  ValidationItem _lastName = ValidationItem(null, null);
  ValidationItem _phoneNumber = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _gender = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  ValidationItem _confirmPassword = ValidationItem(null, null);
  ImageItem _image = ImageItem(null, null);

  //Personal Info variables.
  ValidationItem _qualification = ValidationItem(null, null);

  ValidationItem _yearOfPassing = ValidationItem(null, null);

  ValidationItem _grade = ValidationItem(null, null);

  ValidationItem _experience = ValidationItem(null, null);

  ValidationItem _designation = ValidationItem(null, null);

  ValidationItem _domain = ValidationItem(null, null);

  // Address Info variables

  ValidationItem _address = ValidationItem(null, null);

  ValidationItem _landmark = ValidationItem(null, null);

  ValidationItem _city = ValidationItem(null, null);

  ValidationItem _state = ValidationItem(null, null);

  ValidationItem _pinCode = ValidationItem(null, null);

  //Validation for characters
  final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  //Validation for password
  final validPassword = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  // Getters

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

  // Personal Info
  ValidationItem get qualification => _qualification;
  ValidationItem get yearOfPassing => _yearOfPassing;
  ValidationItem get grade => _grade;
  ValidationItem get experience => _experience;
  ValidationItem get designation => _designation;
  ValidationItem get domain => _domain;

  // Address Info

  ValidationItem get address => _address;
  ValidationItem get landmark => _landmark;
  ValidationItem get city => _city;
  ValidationItem get state => _state;
  ValidationItem get pinCode => _pinCode;

  // Page route Getter.
  Pages get page => _page;

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

  //Setters

  // Basic Info
  void changePage(Pages selctedPage) {
    print(selctedPage);
    _page = selctedPage;
    notifyListeners();
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
        _password = ValidationItem(null, "Weak Password (Minumum combination of 8)");
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

  // Personal Info

  setQualification(String value) {
    _qualification = ValidationItem(value, null);
    notifyListeners();
  }

  deSelectQualification() {
    _qualification = ValidationItem(null, null);
    notifyListeners();
  }

  validateYearOfPassing(String value) {
    if (value.isNotEmpty) {
      _yearOfPassing = ValidationItem(value, null);
      notifyListeners();
    } else {
      _yearOfPassing = ValidationItem(null, "Year of passing required");
      notifyListeners();
    }
  }

  validateGrade(String value) {
    if (value.isNotEmpty) {
      _grade = ValidationItem(value, null);
      notifyListeners();
    } else {
      _grade = ValidationItem(null, "Grade required");
      notifyListeners();
    }
  }

  validateExperience(String value) {
    if (value.isNotEmpty) {
      _experience = ValidationItem(value, null);
      notifyListeners();
    } else {
      _experience = ValidationItem(null, "Experience required");
      notifyListeners();
    }
  }

  validateDesignation(String value) {
    if (value.isNotEmpty) {
      _designation = ValidationItem(value, null);
      notifyListeners();
    } else {
      _designation = ValidationItem(null, "Designation required");
      notifyListeners();
    }
  }

  void setDomain(String value) {
    _domain = ValidationItem(value, null);
    notifyListeners();
  }

  void validateAddress(String value) {
    if (value.isNotEmpty) {
      if (value.length < 3) {
        _address = ValidationItem(null, "Minimum 3 characteers");
      } else {
        _address = ValidationItem(value, null);
      }
    } else {
      _address = ValidationItem(null, "Address Required");
    }
    notifyListeners();
  }

  void validateLandmark(String value) {
    if (value.isNotEmpty) {
      if (value.length < 3) {
        _landmark = ValidationItem(null, "Minimum 3 characteers");
      } else {
        _landmark = ValidationItem(value, null);
      }
    } else {
      _landmark = ValidationItem(null, "Landmark Required");
    }
    notifyListeners();
  }

  void setCity(String value) {
    if (value.isNotEmpty) {
      _city = ValidationItem(value, null);
      notifyListeners();
    }
  }

  void validateState(String value) {
    if (value.isNotEmpty) {
      _state = ValidationItem(value, null);
    } else {
      _state = ValidationItem(null, "State Reqiired");
    }
    notifyListeners();
  }

  void deselectState() {
    _state = ValidationItem(null, null);
    notifyListeners();
  }

  void setPincode(String value) {
    if (value.isNotEmpty) {
      _pinCode = ValidationItem(value, null);
      notifyListeners();
    }
  }

  bool get isAddressInfoValid {
    if (_address.value != null &&
        _landmark.value != null &&
        _state.value != null) {
      return true;
    } else {
      return false;
    }
  }

  bool get isPersonalInfoValid {
    if (_qualification.value != null &&
        _yearOfPassing.value != null &&
        _grade.value != null &&
        _experience.value != null &&
        _designation.value != null) {
      return true;
    } else {
      return false;
    }
  }
}
