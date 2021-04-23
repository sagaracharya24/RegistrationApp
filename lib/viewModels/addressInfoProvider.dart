import 'package:flutter/material.dart';
import 'package:registration_form_app/models/profile.dart';

class AddressInfoProvider with ChangeNotifier {
  // Address Info variables

  ValidationItem _address = ValidationItem(null, null);

  ValidationItem _landmark = ValidationItem(null, null);

  ValidationItem _city = ValidationItem(null, null);

  ValidationItem _state = ValidationItem(null, null);

  ValidationItem _pinCode = ValidationItem(null, null);

  final List<String> _statesList = [
    "Maharashtra",
    "Gujarat",
    "Karnataka",
    "Madhya Pradesh",
    "Delhi",
    "Others"
  ];

  // Address Info Getters

  ValidationItem get address => _address;
  ValidationItem get landmark => _landmark;
  ValidationItem get city => _city;
  ValidationItem get state => _state;
  ValidationItem get pinCode => _pinCode;
  List<String> get states => _statesList;

  // Address Into setters

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
}
