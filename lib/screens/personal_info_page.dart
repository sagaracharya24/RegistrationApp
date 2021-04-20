import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:registration_form_app/validation/registration_validation.dart';
import 'package:registration_form_app/widgets/custom_widgets.dart';

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
  List<String> eduationList = [
    "Post Graduate",
    "Graduate",
    "HSC/Diploma",
    "SSC"
  ];

  @override
  void initState() {
    super.initState();

    final validationService =
        Provider.of<RegistrationValidation>(context, listen: false);

    initialAssigns(validationService);
  }

  initialAssigns(RegistrationValidation validationService) {
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
    var validationService = Provider.of<RegistrationValidation>(context);
    return WillPopScope(
      onWillPop: () async {
        validationService.changePage(Pages.BasicInfo);
        return false;
      },
      child: Scaffold(
        body: KeyboardActions(
          config: buildConfig(context),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  customAppBar(
                    title: "Your Info",
                    onPressed: () =>
                        validationService.changePage(Pages.BasicInfo),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  customPickerField(
                      headingMessage: "Education*",
                      value: validationService.qualification.value,
                      onTap: () {
                        showPicker(
                            context: context,
                            items: eduationList,
                            onConfirm: (controller) {
                              String item = eduationList[
                                  controller.selectedRowAt(section: 0)];
                              validationService.setQualification(item);
                            },
                            pickerHeading: "Education",
                            onCancel: () {
                              validationService.deSelectQualification();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Qualification reset'),
                                ),
                              );
                            });
                      }),
                  customTextField(
                      focusNode: _passingYearNode,
                      controller: _passingYearcontroller,
                      headingMessage: "Year of Passing*",
                      hintMessage: "Enter year of passing",
                      onSubmitted: (String value) {
                        validationService.validateYearOfPassing(value);
                      },
                      errorText: validationService.yearOfPassing.error,
                      textInputType: TextInputType.number,
                      isIconVisible: true),
                  customTextField(
                    controller: _gradeController,
                    headingMessage: "Grade*",
                    hintMessage: "Enter your grade/percentage",
                    onSubmitted: (String value) {
                      validationService.validateGrade(value);
                    },
                    errorText: validationService.grade.error,
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
                  customTextField(
                    focusNode: _experienceNode,
                    controller: _experienceController,
                    headingMessage: "Experience*",
                    hintMessage: "Enter the years of experience",
                    onSubmitted: (String value) {
                      validationService.validateExperience(value);
                    },
                    errorText: validationService.experience.error,
                    textInputType: TextInputType.number,
                  ),
                  customTextField(
                      controller: _designationController,
                      headingMessage: "Designation*",
                      hintMessage: "Select Designation",
                      onSubmitted: (String value) {
                        validationService.validateDesignation(value);
                      },
                      errorText: validationService.designation.error,
                      textInputType: TextInputType.text,
                      isIconVisible: true),
                  customTextField(
                      controller: _domainController,
                      headingMessage: "Domain",
                      hintMessage: "Select your Domain",
                      onSubmitted: (String value) {
                        validationService.setDomain(value);
                      },
                      errorText: validationService.yearOfPassing.error,
                      textInputType: TextInputType.text,
                      isIconVisible: true),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          !validationService.isPersonalInfoValid
                              ? "Please fill the required details with * symbol"
                              : "",
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                        if (!validationService.isPersonalInfoValid)
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
                                  validationService.changePage(Pages.BasicInfo);
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
                                onPressed: () {
                                  if (validationService.isPersonalInfoValid) {
                                    validationService.changePage(Pages.Address);
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
