import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

const colorRed = Color(0xFFFF0000);
const colorGreen = Color(0xFF00CC00);
const colorBlue = Color(0xFF4d94ff);
const colorOrange = Color(0xFFFF6600);
const colorBlack = Color(0xFF262626);
const colorGrey = Color(0xFDA3B3B3);
const colorLightGrey = Color(0xFDD0D6D6);
const colorWhite = Color(0xFFffffff);

PinTheme appOTPStyle() {
  return PinTheme(
    inactiveColor: colorBlue,
    inactiveFillColor: colorWhite,
    selectedColor: colorBlue,
    activeColor: colorWhite,
    selectedFillColor: colorBlue,
    shape: PinCodeFieldShape.box,
    borderRadius: BorderRadius.circular(8),
    fieldHeight: 50,
    fieldWidth: 50,
    borderWidth: 0.5,
    activeFillColor: colorWhite,
  );
}

TextStyle head1Text(textColor) {
  return TextStyle(
    color: textColor,
    fontSize: 28,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w700,
  );
}

TextStyle head6Text(textColor) {
  return TextStyle(
    color: textColor,
    fontSize: 16,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w400,
  );
}

InputDecoration appInputDecoration(label) {
  return InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorBlue, width: 1),
      ),
      fillColor: colorWhite,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(16, 10, 10, 16),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      border: const OutlineInputBorder(),
      floatingLabelStyle: head6Text(colorBlack),
      labelText: label,
      labelStyle: buttonTextStyle());
}

SvgPicture screenBackground(context) {
  return SvgPicture.asset(
    'assets/images/background.svg',
    alignment: Alignment.center,
    width: MediaQuery.sizeOf(context).width,
    height: MediaQuery.sizeOf(context).height,
    fit: BoxFit.cover,
  );
}

SvgPicture splashScreenLogo(context) {
  return SvgPicture.asset(
    'assets/images/task logo.svg',
  );
}

ButtonStyle appButtonStyle() {
  return ElevatedButton.styleFrom(
    elevation: 1,
    padding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    foregroundColor: colorWhite,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}

TextStyle buttonTextStyle() {
  return const TextStyle(
    fontSize: 14,
    fontFamily: 'poppins',
    fontWeight: FontWeight.w400,
  );
}

Ink successButtonChild(String buttonText) {
  return Ink(
    decoration: BoxDecoration(
      color: colorBlue,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Container(
      height: 45,
      alignment: Alignment.center,
      child: Text(
        buttonText,
        style: buttonTextStyle(),
      ),
    ),
  );
}

void successToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: colorGreen,
    textColor: colorWhite,
    fontSize: 16,
  );
}

void errorToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: colorRed,
    textColor: colorWhite,
    fontSize: 16,
  );
}
