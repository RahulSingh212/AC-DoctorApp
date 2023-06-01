// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable, unused_element

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:doctor/screens/signup_Screens/EnterPhoneNumber_Screen.dart';
import 'package:doctor/screens/signup_Screens/SelectLanguage_Screen.dart';
import 'package:doctor/screens/signup_Screens/SelectQualification_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../HelperStuff/circle_painter.dart';
import '../../HelperStuff/rounded_rectangle.dart';
import '../../StarterScreens/qualifications.dart';

import '../../providers/doctorAuth_details.dart';
import '../../providers/doctorUser_details.dart';

class SelectSignInSignUpScreenDoctor extends StatefulWidget {
  static const routeName = '/doctor-select-signup-signin-screen';

  @override
  State<SelectSignInSignUpScreenDoctor> createState() =>
      _SelectSignInSignUpScreenDoctorState();
}

class _SelectSignInSignUpScreenDoctorState
    extends State<SelectSignInSignUpScreenDoctor> {
  bool ispressed_eng = false;
  bool ispressed_hindi = false;
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();
    Provider.of<DoctorAuthDetails>(context, listen: false)
        .getExistingDoctorsUserPhoneNumbers(context);
    Provider.of<DoctorUserDetails>(context, listen: false)
        .clearStateOfLoggedInUser(context);

    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: Color(0xFFfbfcff),
      body: Container(
        // width: screenWidth,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(screenWidth, screenHeight),
              painter: CirclePainter(),
            ),
            Container(
              width: screenWidth,
              padding: EdgeInsets.only(top: 0.09 * screenHeight),
              child: Text(
                isLangEnglish ? "AURIGA CARE DOCTOR" : "औराईगा केयर डॉक्टर",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                  // height: ,
                ),
              ),
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(top: 0.159846 * height),
              child: Text(
                isLangEnglish
                    ? '24/7 Video Consultations,\nexclusively on app'
                    : "24/7 वीडियो परामर्श,\nविशेष रूप से ऐप पर",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFfbfcff),
                  // height: ,
                ),
              ),
            ),
            CustomPaint(
              size: Size(
                0.785 * width,
                0.485 * height,
              ),
              painter: RoundedRectangle(),
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(top: 0.36828 * height),
              child: Text(
                isLangEnglish
                    ? "Select Entry Type"
                    : "प्रवेश प्रकार का चयन करें",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff2c2c2c),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.45 * height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  Provider.of<DoctorAuthDetails>(context, listen: false)
                      .setEntryType(true);
                  Navigator.of(context)
                      .pushNamed(EnterPhoneNumberScreen.routeName);
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      ispressed_eng ? Color(0xff42ccc3) : Color(0xFFfbfcff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(27.5),
                    ),
                  ),
                  side: BorderSide(
                    color: Color(0xffebebeb),
                    width: 1,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    0.208333 * width,
                    0.016624 * height,
                    0.205555 * width,
                    0.016624 * height,
                  ),
                  minimumSize: Size(221, 55),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center,
                ),
                child: Text(
                  isLangEnglish ? "Sign In" : "साइन इन",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color:
                        ispressed_eng ? Color(0xFFfbfcff) : Color(0xff2c2c2c),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.56393 * height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  Provider.of<DoctorAuthDetails>(context, listen: false)
                      .setEntryType(false);
                  // Navigator.of(context)
                  //     .pushNamed(SelectLanguageScreenDoctor.routeName);
                  Navigator.of(context)
                      .pushNamed(SelectQualificationScreenDoctor.routeName);
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      ispressed_hindi ? Color(0xff42ccc3) : Color(0xFFfbfcff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(27.5),
                    ),
                  ),
                  side: BorderSide(
                    color: Color(0xffebebeb),
                    width: 1,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    0.208333 * width,
                    0.016624 * height,
                    0.205555 * width,
                    0.016624 * height,
                  ),
                  minimumSize: Size(221, 55),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center,
                ),
                child: Text(
                  isLangEnglish ? "Sign Up" : "साइन अप",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color:
                        ispressed_hindi ? Color(0xFFfbfcff) : Color(0xff2c2c2c),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.65 * height),
              alignment: Alignment.topCenter,
              child: Align(
                child: Container(
                  height: screenHeight * 0.175,
                  width: screenWidth * 0.35,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: screenWidth,
                    child: CircleAvatar(
                      radius: screenWidth * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.2,
                        ),
                        child: ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              "assets/images/agLogo.png",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkForError(
      BuildContext context, String titleText, String contextText,
      {bool popVal = false}) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(() {
                if (popVal == false) {
                  Navigator.pop(ctx);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
