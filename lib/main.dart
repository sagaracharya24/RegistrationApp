import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_form_app/screens/registration_page.dart';
import 'package:registration_form_app/validation/registration_validation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegistrationValidation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegistrationPage(),
      ),
    );
  }
}
