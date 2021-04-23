import 'package:flutter/material.dart';
import 'package:spagreen/src/style/theme.dart';
class EditTextUtils {
  TextFormField getCustomEditTextField(
      {String hintValue = "",
        TextEditingController controller,
        EdgeInsetsGeometry contentPadding =const EdgeInsets.symmetric(vertical: 5),
            Widget prefixWidget,
        Widget suffixWidget ,
        TextStyle style,
        Function validator,
        bool obscureValue = false,
        int maxLines = 1,
      TextInputType keyboardType}) {
    return  TextFormField(
      maxLines: maxLines,
      keyboardType:keyboardType,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixWidget,
        suffixIcon: suffixWidget,
        contentPadding:contentPadding,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: CustomTheme.lightColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: CustomTheme.lightColor),
        ),
        hintText: hintValue,
        hintStyle: style,
      ),
      style: style,
      validator: validator,
      obscureText: obscureValue,

    );
  }
}
