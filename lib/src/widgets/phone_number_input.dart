import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spagreen/src/bloc/phone_auth/phone_auth_bloc.dart';
import 'package:spagreen/src/bloc/phone_auth/phone_auth_event.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';
import 'package:spagreen/src/utils/edit_text_utils.dart';
import '../button_widget.dart';

class NumberInput extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _phoneTextController = TextEditingController();
  String _selectedCountryCode = AppContent.selectedCountryCode;

  @override
  Widget build(BuildContext context) {
    double screnWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding:
      const EdgeInsets.only(top: 60, bottom: 16.0, left: 16.0, right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(AppContent.EnterMobileNumber,
            style: CustomTheme.screenTitle,
          ),
          SizedBox(height: 50.0),
          Form(
            key: _formKey,
            child: EditTextUtils().getCustomEditTextField(
                hintValue: AppContent.phonAuthHintValue,
                controller: _phoneTextController,
                prefixWidget: countryCde(),
                style: CustomTheme.textFieldTitlePrimaryColored,
                keyboardType: TextInputType.number,
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    /*print(_selectedCountryCode);*/
                    BlocProvider.of<PhoneAuthBloc>(context).add(SendOtpEvent(
                        phoNo: _selectedCountryCode + _phoneTextController.value.text));
                  }
                },
                child: HelpMe().submitButton(screnWidth, AppContent.continueText)),
          ),
          Text(AppContent.byTappingContinue,style: CustomTheme.subTitleTextColored,
          )
        ],
      ),
    );
  }

  Widget countryCde(){
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: CountryCodePicker(
        textStyle: CustomTheme.textFieldTitle,
        onChanged: (value){
          _selectedCountryCode = value.dialCode;
        },
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: AppContent.initialCountrySelection,
        favorite: AppContent.favouriteCountryCode,
        // optional. Shows only country name and flag
        showCountryOnly: false,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: false,
        // optional. aligns the flag and the Text left
        alignLeft: false,
      ),
    );
  }
}