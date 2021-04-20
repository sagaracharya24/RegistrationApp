import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:provider/provider.dart';
import 'package:registration_form_app/validation/registration_validation.dart';
import 'package:registration_form_app/widgets/custom_image_picker.dart';
import 'package:registration_form_app/widgets/custom_widgets.dart';

class BasicInfoPage extends StatefulWidget {
  @override
  _BasicInfoPageState createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final FocusNode _phoneNumberNode = FocusNode();

  @override
  void initState() {
    super.initState();

    final registrationService =
        Provider.of<RegistrationValidation>(context, listen: false);

    initialAssigns(registrationService);
  }

  initialAssigns(RegistrationValidation registrationService) {
    _firstName.text = registrationService.firstName.value;
    _lastName.text = registrationService.lastName.value;
    _phoneNumber.text = registrationService.phoneNumber.value;
    _email.text = registrationService.email.value;
    _password.text = registrationService.password.value;
    _confirmPassword.text = registrationService.confirmPassword.value;
  }
  KeyboardActionsConfig buildConfig(BuildContext context) {
  return KeyboardActionsConfig(
    keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
    keyboardBarColor: Colors.grey[200],
    nextFocus: true,
    actions: [
      KeyboardActionsItem(
        focusNode: _phoneNumberNode,
        toolbarButtons: [
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          },
        ],
      ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    final registrationService = Provider.of<RegistrationValidation>(context);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: KeyboardActions(
        config: buildConfig(context),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        var file = await mImagePickerOptions(context);
                        
                        if (file != null) {
                          registrationService.setImage(File(file.path));
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: registrationService.image.file != null
                                  ? Image.file(
                                      registrationService.image.file,
                                      fit: BoxFit.cover,
                                    )
                                  : SvgPicture.asset("Assets/user.svg"),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 25,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Icon(
                                Icons.edit,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                showTextField(
                  controller: _firstName,
                  textFieldHeading: 'FirstName*',
                  hintText: 'Enter your first name here',
                  errorText: registrationService.firstName.error,
                  icon: Icons.person,
                  onSubmitted: (value) {
                    registrationService.validateFirstName(_firstName.text);
                  },
                ),
                showTextField(
                  controller: _lastName,
                  textFieldHeading: 'LastName*',
                  hintText: 'Enter your last name here',
                  errorText: registrationService.lastName.error,
                  icon: Icons.person,
                  onSubmitted: (value) {
                    registrationService.validateLastName(value);
                  },
                ),
                showTextField(
                    focusNode: _phoneNumberNode,
                    controller: _phoneNumber,
                    textFieldHeading: 'Phone Number*',
                    hintText: 'Enter your 10 digit phone number',
                    errorText: registrationService.phoneNumber.error,
                    icon: Icons.phone,
                    onSubmitted: (value) {
                      registrationService.validatePhoneNumer(value);
                    },
                    textInputType: TextInputType.number,
                    maxLength: 10),
                showTextField(
                  controller: _email,
                  textFieldHeading: 'Email*',
                  hintText: 'Your email goes here',
                  errorText: registrationService.email.error,
                  icon: Icons.email,
                  onSubmitted: (value) {
                    registrationService.validateEmail(value);
                  },
                ),
                showRadioGroup(
                  onChanged: (value) {
                    registrationService.changeGender(value);
                  },
                  value: registrationService.gender.value,
                ),
                showTextField(
                    controller: _password,
                    textFieldHeading: 'Password*',
                    hintText: 'Password',
                    errorText: registrationService.password.error,
                    icon: Icons.lock,
                    onSubmitted: (value) {
                      registrationService.changePassword(value);
                    },
                    textInputType: TextInputType.text,
                    isPasswordField: true,
                    isVisible: registrationService.passwordVisible,
                    onSuffixIconPressed: () {
                      registrationService.toggleVisibility();
                    }),
                showTextField(
                  controller: _confirmPassword,
                  textFieldHeading: 'Confirm Password*',
                  hintText: 'Password',
                  errorText: registrationService.confirmPassword.error,
                  icon: Icons.lock,
                  onSubmitted: (value) {
                    registrationService.changeConfirmPassword(value);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        !registrationService.isBasicInfoValid
                            ? "Please fill the required details with * symbol"
                            : "",
                        style: TextStyle(color: Colors.red, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                if (!registrationService.isBasicInfoValid)
                  SizedBox(
                    height: 15,
                  ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.indigo[800],
                                ),
                              ),
                              onPressed: () {
                                if (registrationService.isBasicInfoValid) {
                                  registrationService
                                      .changePage(Pages.PerofessionalInfo);
                                }
                              },
                              child: Text("Next")),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
