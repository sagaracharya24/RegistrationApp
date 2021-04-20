import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_form_app/screens/address_info_page.dart';
import 'package:registration_form_app/screens/basic_info_page.dart';
import 'package:registration_form_app/screens/personal_info_page.dart';
import 'package:registration_form_app/validation/registration_validation.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
  }

  Widget getPage(Pages page) {
    switch (page) {
      case Pages.BasicInfo:
        return BasicInfoPage();
        break;
      case Pages.PerofessionalInfo:
        return PersonalInfoPage();
        break;
      case Pages.Address:
        return AddressPage();
        break;
      default:
        return BasicInfoPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final registrationService = Provider.of<RegistrationValidation>(context);
    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          transitionBuilder: (widget, animation) => FadeTransition(
            opacity: _animation,
            child: widget,
          ),
          duration: Duration(seconds: 1),
          child: getPage(registrationService.page),
        ),
      ),
    );
  }
}
