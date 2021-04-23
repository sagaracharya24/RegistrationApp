import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:provider/provider.dart';
import 'package:registration_form_app/viewModels/addressInfoProvider.dart';
import 'package:registration_form_app/views/review_page.dart';
import 'package:registration_form_app/widgets/custom_textfield.dart';
import 'package:registration_form_app/widgets/custom_ui_pickerview.dart';
import 'package:registration_form_app/widgets/custom_widgets.dart';
import 'package:registration_form_app/widgets/cutom_appbar.dart';

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

  @override
  void initState() {
    super.initState();

    final addressInfoProvider =
        Provider.of<AddressInfoProvider>(context, listen: false);

    initialAssigns(addressInfoProvider);
  }

  initialAssigns(AddressInfoProvider addressInfoProvider) {
    _addressController.text = addressInfoProvider.address.value;
    _landmarkController.text = addressInfoProvider.landmark.value;
    _cityController.text = addressInfoProvider.city.value;
    _pinCodeController.text = addressInfoProvider.pinCode.value;
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
    final addressInfoProvider = Provider.of<AddressInfoProvider>(context);

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
                  CustomAppBar(
                      title: "Your Address",
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      }),
                  Column(
                    children: [
                      CustomTextField(
                        controller: _addressController,
                        textFieldHeading: null,
                        hintText: 'Address*',
                        errorText: addressInfoProvider.address.error,
                        icon: Icons.apartment_outlined,
                        onSubmitted: (value) {
                          addressInfoProvider.validateAddress(value);
                        },
                      ),
                      CustomTextField(
                        controller: _landmarkController,
                        textFieldHeading: null,
                        hintText: 'Landmark*',
                        errorText: addressInfoProvider.landmark.error,
                        icon: Icons.apartment_outlined,
                        onSubmitted: (value) {
                          addressInfoProvider.validateLandmark(value);
                        },
                      ),
                      CustomTextField(
                        controller: _cityController,
                        textFieldHeading: null,
                        hintText: 'City',
                        errorText: addressInfoProvider.city.error,
                        icon: Icons.apartment_outlined,
                        onSubmitted: (value) {
                          addressInfoProvider.setCity(value);
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      CustomPickerFiled(
                          headingMessage: null,
                          value: addressInfoProvider.state.value ??
                              "Select Your State*",
                          height: 50,
                          onTap: () {
                            showPicker(
                                context: context,
                                items: addressInfoProvider.states,
                                onConfirm: (controller) {
                                  String item = addressInfoProvider.states[
                                      controller.selectedRowAt(section: 0)];
                                  addressInfoProvider.validateState(item);
                                },
                                pickerHeading: "State",
                                onCancel: () {
                                  addressInfoProvider.deselectState();
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
                      CustomTextField(
                          focusNode: _pincodeNode,
                          controller: _pinCodeController,
                          textFieldHeading: null,
                          hintText: 'Pin Code',
                          errorText: addressInfoProvider.pinCode.error,
                          icon: Icons.apartment_outlined,
                          onSubmitted: (value) {
                            addressInfoProvider.setPincode(value);
                          },
                          textInputType: TextInputType.numberWithOptions()),
                      if (!addressInfoProvider.isAddressInfoValid)
                        SizedBox(
                          height: 10,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              !addressInfoProvider.isAddressInfoValid
                                  ? "Please fill the required details with * symbol"
                                  : "",
                              style: TextStyle(color: Colors.red, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      if (!addressInfoProvider.isAddressInfoValid)
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
                                      if (addressInfoProvider
                                          .isAddressInfoValid) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Registration Sucessfull'),
                                          ),
                                        );

                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewPage()));
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
