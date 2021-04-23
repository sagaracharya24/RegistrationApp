import 'package:flutter/material.dart';
import 'package:registration_form_app/models/profile.dart';

class PersonalInfoProvider with ChangeNotifier {
  //Personal Info variables.
  ValidationItem _qualification = ValidationItem(null, null);

  ValidationItem _yearOfPassing = ValidationItem(null, null);

  ValidationItem _grade = ValidationItem(null, null);

  ValidationItem _experience = ValidationItem(null, null);

  ValidationItem _designation = ValidationItem(null, null);

  ValidationItem _domain = ValidationItem(null, null);
  final List<String> _eduationList = [
    "Post Graduate",
    "Graduate",
    "HSC/Diploma",
    "SSC"
  ];

  // Personal Info
  ValidationItem get qualification => _qualification;
  ValidationItem get yearOfPassing => _yearOfPassing;
  ValidationItem get grade => _grade;
  ValidationItem get experience => _experience;
  ValidationItem get designation => _designation;
  ValidationItem get domain => _domain;
  List<String> get educationList => _eduationList;

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
