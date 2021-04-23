import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:spagreen/src/bloc/phone_auth/phone_auth_bloc.dart';
import 'package:spagreen/src/bloc/phone_auth/phone_auth_event.dart';
import '../button_widget.dart';
import '../strings.dart';

class OtpInput extends StatelessWidget {
  String inputPin;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ConstrainedBox(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 48.0, bottom: 16.0, left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppContent.enterTheCodeSent,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            PinEntryTextField(
                fields: 6,
                onSubmit: (String pin) {
                  inputPin = pin;
                }),
            SizedBox(height: 30.0),
            GestureDetector(
                onTap: () {
                  BlocProvider.of<PhoneAuthBloc>(context).add(VerifyOtpEvent(otp: inputPin));},
                child: HelpMe().submitButton(142, AppContent.submit)),
          ],
        ),
      ),
      constraints: BoxConstraints.tight(Size.fromHeight(250)),
    );
  }
}