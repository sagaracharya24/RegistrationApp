import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:provider/provider.dart';
import 'package:registration_form_app/viewModels/basicInfoProvider.dart';
import 'package:registration_form_app/views/personal_info_page.dart';
import 'package:registration_form_app/widgets/custom_image_picker.dart';
import 'package:registration_form_app/widgets/custom_radioButton.dart';
import 'package:registration_form_app/widgets/custom_textfield.dart';

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
        Provider.of<BasicInfoProvider>(context, listen: false);

    initialAssigns(registrationService);
  }

  initialAssigns(BasicInfoProvider basicInfoProvider) {
    _firstName.text = basicInfoProvider.firstName.value;
    _lastName.text = basicInfoProvider.lastName.value;
    _phoneNumber.text = basicInfoProvider.phoneNumber.value;
    _email.text = basicInfoProvider.email.value;
    _password.text = basicInfoProvider.password.value;
    _confirmPassword.text = basicInfoProvider.confirmPassword.value;
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
    final basicInfoProvider = Provider.of<BasicInfoProvider>(context);

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
                          basicInfoProvider.setImage(File(file.path));
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
                              child: basicInfoProvider.image.file != null
                                  ? Image.file(
                                      basicInfoProvider.image.file,
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
                CustomTextField(
                  controller: _firstName,
                  textFieldHeading: 'FirstName*',
                  hintText: 'Enter your first name here',
                  errorText: basicInfoProvider.firstName.error,
                  icon: Icons.person,
                  onSubmitted: (value) {
                    basicInfoProvider.validateFirstName(_firstName.text);
                  },
                ),
                CustomTextField(
                  controller: _lastName,
                  textFieldHeading: 'LastName*',
                  hintText: 'Enter your last name here',
                  errorText: basicInfoProvider.lastName.error,
                  icon: Icons.person,
                  onSubmitted: (value) {
                    basicInfoProvider.validateLastName(value);
                  },
                ),
                CustomTextField(
                    focusNode: _phoneNumberNode,
                    controller: _phoneNumber,
                    textFieldHeading: 'Phone Number*',
                    hintText: 'Enter your 10 digit phone number',
                    errorText: basicInfoProvider.phoneNumber.error,
                    icon: Icons.phone,
                    onSubmitted: (value) {
                      basicInfoProvider.validatePhoneNumer(value);
                    },
                    textInputType: TextInputType.number,
                    maxLength: 10),
                CustomTextField(
                  controller: _email,
                  textFieldHeading: 'Email*',
                  hintText: 'Your email goes here',
                  errorText: basicInfoProvider.email.error,
                  icon: Icons.email,
                  onSubmitted: (value) {
                    basicInfoProvider.validateEmail(value);
                  },
                ),
                CustomRadioButton(
                  onChanged: (value) {
                    basicInfoProvider.changeGender(value);
                  },
                  value: basicInfoProvider.gender.value,
                ),
                CustomTextField(
                    controller: _password,
                    textFieldHeading: 'Password*',
                    hintText: 'Password',
                    errorText: basicInfoProvider.password.error,
                    icon: Icons.lock,
                    onSubmitted: (value) {
                      basicInfoProvider.changePassword(value);
                    },
                    textInputType: TextInputType.text,
                    isPasswordField: true,
                    isVisible: basicInfoProvider.passwordVisible,
                    onSuffixIconPressed: () {
                      basicInfoProvider.toggleVisibility();
                    }),
                CustomTextField(
                  controller: _confirmPassword,
                  textFieldHeading: 'Confirm Password*',
                  hintText: 'Password',
                  errorText: basicInfoProvider.confirmPassword.error,
                  icon: Icons.lock,
                  onSubmitted: (value) {
                    basicInfoProvider.changeConfirmPassword(value);
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
                        !basicInfoProvider.isBasicInfoValid
                            ? "Please fill the required details with * symbol"
                            : "",
                        style: TextStyle(color: Colors.red, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                if (!basicInfoProvider.isBasicInfoValid)
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
                              onPressed: () async {
                                if (basicInfoProvider.isBasicInfoValid) {
                                  var value = await Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PersonalInfoPage()));
                                  if (value) {
                                    initialAssigns(basicInfoProvider);
                                  }
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
