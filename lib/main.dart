import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_form_app/viewModels/addressInfoProvider.dart';
import 'package:registration_form_app/viewModels/basicInfoProvider.dart';
import 'package:registration_form_app/viewModels/personalInfoProvider.dart';
import 'package:registration_form_app/views/registration_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BasicInfoProvider>(create: (_) => BasicInfoProvider()),
        ChangeNotifierProvider<PersonalInfoProvider>(create: (_) => PersonalInfoProvider()),
        ChangeNotifierProvider<AddressInfoProvider>(create: (_) => AddressInfoProvider()), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegistrationPage(),
      ),
    );
  }
}
