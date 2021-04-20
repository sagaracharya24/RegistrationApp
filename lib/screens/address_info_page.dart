import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:provider/provider.dart';
import 'package:registration_form_app/validation/registration_validation.dart';
import 'package:registration_form_app/widgets/custom_widgets.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  final FocusNode _pincodeNode = FocusNode();
  List<String> statesList = [
    "Maharashtra",
    "Gujarat",
    "Karnataka",
    "Madhya Pradesh",
    "Delhi",
    "Others"
  ];

  @override
  void initState() {
    super.initState();

    final registrationService =
        Provider.of<RegistrationValidation>(context, listen: false);

    initialAssigns(registrationService);
  }

  initialAssigns(RegistrationValidation registrationService) {
    _addressController.text = registrationService.address.value;
    _landmarkController.text = registrationService.landmark.value;
    _cityController.text = registrationService.city.value;
    _pinCodeController.text = registrationService.pinCode.value;
  }

  KeyboardActionsConfig buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _pincodeNode,
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
    final validationService = Provider.of<RegistrationValidation>(context);

    return Scaffold(
      body: KeyboardActions(
        config: buildConfig(context),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.97,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customAppBar(
                    title: "Your Address",
                    onPressed: () =>
                        validationService.changePage(Pages.PerofessionalInfo),
                  ),
                  Column(
                    children: [
                      showTextField(
                        controller: _addressController,
                        textFieldHeading: null,
                        hintText: 'Address*',
                        errorText: validationService.address.error,
                        icon: Icons.apartment_outlined,
                        onSubmitted: (value) {
                          validationService.validateAddress(value);
                        },
                      ),
                      showTextField(
                        controller: _landmarkController,
                        textFieldHeading: null,
                        hintText: 'Landmark*',
                        errorText: validationService.landmark.error,
                        icon: Icons.apartment_outlined,
                        onSubmitted: (value) {
                          validationService.validateLandmark(value);
                        },
                      ),
                      showTextField(
                        controller: _cityController,
                        textFieldHeading: null,
                        hintText: 'City',
                        errorText: validationService.city.error,
                        icon: Icons.apartment_outlined,
                        onSubmitted: (value) {
                          validationService.setCity(value);
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      customPickerField(
                          headingMessage: null,
                          value: validationService.state.value ??
                              "Select Your State*",
                          height: 50,
                          onTap: () {
                            showPicker(
                                context: context,
                                items: statesList,
                                onConfirm: (controller) {
                                  String item = statesList[
                                      controller.selectedRowAt(section: 0)];
                                  validationService.validateState(item);
                                },
                                pickerHeading: "State",
                                onCancel: () {
                                  validationService.deselectState();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('State field cleared'),
                                    ),
                                  );
                                });
                          }),
                      SizedBox(
                        height: 7,
                      ),
                      showTextField(
                          focusNode: _pincodeNode,
                          controller: _pinCodeController,
                          textFieldHeading: null,
                          hintText: 'Pin Code',
                          errorText: validationService.pinCode.error,
                          icon: Icons.apartment_outlined,
                          onSubmitted: (value) {
                            validationService.setPincode(value);
                          },
                          textInputType: TextInputType.numberWithOptions()),
                      if (!validationService.isAddressInfoValid)
                        SizedBox(
                          height: 10,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              !validationService.isAddressInfoValid
                                  ? "Please fill the required details with * symbol"
                                  : "",
                              style: TextStyle(color: Colors.red, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      if (!validationService.isAddressInfoValid)
                        SizedBox(
                          height: 10,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.indigo[800])),
                                    onPressed: () {
                                      if (validationService
                                          .isAddressInfoValid) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Registration Sucessfull'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text("Submit")))
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Text(""),
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
