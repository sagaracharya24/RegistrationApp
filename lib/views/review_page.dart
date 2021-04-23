import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:registration_form_app/viewModels/addressInfoProvider.dart';
import 'package:registration_form_app/viewModels/basicInfoProvider.dart';
import 'package:registration_form_app/viewModels/personalInfoProvider.dart';
import 'package:registration_form_app/widgets/customText.dart';
import 'package:registration_form_app/widgets/cutom_headingField.dart';

class ReviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var basicInfoProvider = Provider.of<BasicInfoProvider>(context);
    var personalInfoProvider = Provider.of<PersonalInfoProvider>(context);
    var addressInfoProvider = Provider.of<AddressInfoProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                textHeading: "First Name",
                text: basicInfoProvider.firstName.value,
              ),
              CustomText(
                textHeading: "Last Name",
                text: basicInfoProvider.lastName.value,
              ),
              CustomText(
                textHeading: "Phone Number",
                text: basicInfoProvider.phoneNumber.value,
              ),
              CustomText(
                textHeading: "Email",
                text: basicInfoProvider.email.value,
              ),
              CustomText(
                textHeading: "Gender",
                text: basicInfoProvider.gender.value,
              ),
              CustomHeadinField(
                heading: "Education Info",
              ),
              CustomText(
                textHeading: "Qualification",
                text: personalInfoProvider.qualification.value,
              ),
              CustomText(
                textHeading: "Year of Passing",
                text: personalInfoProvider.yearOfPassing.value,
              ),
              CustomText(
                textHeading: "Grade",
                text: personalInfoProvider.grade.value,
              ),
              CustomHeadinField(
                heading: "Personal Info",
              ),
              CustomText(
                textHeading: "Experience",
                text: personalInfoProvider.experience.value,
              ),
              CustomText(
                textHeading: "Designation",
                text: personalInfoProvider.designation.value,
              ),
              CustomText(
                textHeading: "Domain",
                text: personalInfoProvider.experience?.value ??
                    "No Domain Specified",
              ),

              CustomHeadinField(
                heading: "Address",
              ),

            
              CustomText(
                  textHeading: "Address",
                  text: addressInfoProvider.address.value),
              CustomText(
                  textHeading: "LandMark",
                  text: addressInfoProvider.landmark.value),
              CustomText(
                  textHeading: "City",
                  text: addressInfoProvider.city?.value ?? "No City Specified"),
              CustomText(
                  textHeading: "State", text: addressInfoProvider.state.value),
              CustomText(
                  textHeading: "Pincode",
                  text: addressInfoProvider.pinCode?.value ??
                      "No Pincode Specified"),
            ],
          ),
        ),
      ),
    );
  }
}
