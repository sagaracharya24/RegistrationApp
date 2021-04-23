import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:registration_form_app/viewModels/personalInfoProvider.dart';
import 'package:registration_form_app/views/address_info_page.dart';
import 'package:registration_form_app/widgets/custom_textField.dart';
import 'package:registration_form_app/widgets/custom_ui_pickerview.dart';
import 'package:registration_form_app/widgets/custom_widgets.dart';
import 'package:registration_form_app/widgets/cutom_appbar.dart';

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  TextEditingController _passingYearcontroller = TextEditingController();
  TextEditingController _gradeController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _domainController = TextEditingController();
  final FocusNode _passingYearNode = FocusNode();
  final FocusNode _experienceNode = FocusNode();

  @override
  void initState() {
    super.initState();

    final personalInfoProvider =
        Provider.of<PersonalInfoProvider>(context, listen: false);

    initialAssigns(personalInfoProvider);
  }

  initialAssigns(PersonalInfoProvider validationService) {
    _passingYearcontroller.text = validationService.yearOfPassing.value;
    _gradeController.text = validationService.grade.value;
    _experienceController.text = validationService.experience.value;
    _designationController.text = validationService.designation.value;
    _domainController.text = validationService.domain.value;
  }

  KeyboardActionsConfig buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _passingYearNode,
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
        KeyboardActionsItem(
          focusNode: _experienceNode,
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
    var personalInfoProvider = Provider.of<PersonalInfoProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        return false;
      },
      child: Scaffold(
        body: KeyboardActions(
          config: buildConfig(context),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                    title: "Your Info",
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomPickerFiled(
                      headingMessage: "Education*",
                      value: personalInfoProvider.qualification.value,
                      onTap: () {
                        showPicker(
                            context: context,
                            items: personalInfoProvider.educationList,
                            onConfirm: (controller) {
                              String item = personalInfoProvider.educationList[
                                  controller.selectedRowAt(section: 0)];
                              personalInfoProvider.setQualification(item);
                            },
                            pickerHeading: "Education",
                            onCancel: () {
                              personalInfoProvider.deSelectQualification();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Qualification reset'),
                                ),
                              );
                            });
                      }),
                  CustomTextField(
                      focusNode: _passingYearNode,
                      controller: _passingYearcontroller,
                      textFieldHeading: "Year of Passing*",
                      hintText: "Enter year of passing",
                      icon: null,
                      onSubmitted: (String value) {
                        personalInfoProvider.validateYearOfPassing(value);
                      },
                      errorText: personalInfoProvider.yearOfPassing.error,
                      textInputType: TextInputType.number,
                      isPasswordField: false,
                      isVisible: false),
                  CustomTextField(
                    controller: _gradeController,
                    textFieldHeading: "Grade*",
                    hintText: "Enter your grade/percentage",
                    onSubmitted: (String value) {
                      personalInfoProvider.validateGrade(value);
                    },
                    errorText: personalInfoProvider.grade.error,
                    textInputType: TextInputType.text,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Personal Info",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  CustomTextField(
                    focusNode: _experienceNode,
                    controller: _experienceController,
                    textFieldHeading: "Experience*",
                    hintText: "Enter the years of experience",
                    onSubmitted: (String value) {
                      personalInfoProvider.validateExperience(value);
                    },
                    errorText: personalInfoProvider.experience.error,
                    textInputType: TextInputType.number,
                  ),
                  CustomTextField(
                    controller: _designationController,
                    textFieldHeading: "Designation*",
                    hintText: "Select Designation",
                    onSubmitted: (String value) {
                      personalInfoProvider.validateDesignation(value);
                    },
                    errorText: personalInfoProvider.designation.error,
                    textInputType: TextInputType.text,
                    isPasswordField: false,
                  ),
                  CustomTextField(
                    controller: _domainController,
                    textFieldHeading: "Domain",
                    hintText: "Select your Domain",
                    onSubmitted: (String value) {
                      personalInfoProvider.setDomain(value);
                    },
                    errorText: personalInfoProvider.yearOfPassing.error,
                    textInputType: TextInputType.text,
                    isPasswordField: false,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          !personalInfoProvider.isPersonalInfoValid
                              ? "Please fill the required details with * symbol"
                              : "",
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                        if (!personalInfoProvider.isPersonalInfoValid)
                          SizedBox(
                            height: 15,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      side:
                                          BorderSide(color: Colors.indigo[800]),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "Previous",
                                    style: TextStyle(color: Colors.indigo[800]),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.indigo[800]),
                                ),
                                onPressed: () async {
                                  if (personalInfoProvider
                                      .isPersonalInfoValid) {
                                    var value = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                AddressPage()));
                                    if (value && value != null) {
                                      initialAssigns(personalInfoProvider);
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    "Next",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
