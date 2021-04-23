import 'package:flutter/material.dart';
import 'package:registration_form_app/views/basic_info_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedSwitcher(
          transitionBuilder: (widget, animation) => FadeTransition(
            opacity: _animation,
            child: widget,
          ),
          duration: Duration(seconds: 1),
          child: BasicInfoPage(),
        ),
      ),
    );
  }
}
