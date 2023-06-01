// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:doctor/screens/signup_Screens/SelectMedicineType_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../HelperStuff/circle_painter.dart';
import '../../HelperStuff/rounded_rectangle.dart';
import '../../StarterScreens/qualifications.dart';

import '../../providers/doctorAuth_details.dart';
import '../../providers/doctorUser_details.dart';

class SelectQualificationScreenDoctor extends StatefulWidget {
  static const routeName = '/doctor-select-qualification-screen';

  @override
  State<SelectQualificationScreenDoctor> createState() =>
      _SelectQualificationScreenDoctorState();
}

class _SelectQualificationScreenDoctorState
    extends State<SelectQualificationScreenDoctor> {
  bool isLangEnglish = true;

  String dropdownvalue = 'Select Qualification';
  TextEditingController _doctorQualification = TextEditingController();
  var qualificationSelectionList = [
    'Select Qualification',
    'M.B.B.S',
    'M.D',
    'M.S',
    'B.A.M.S',
    'B.D.S',
    'B.Y.N.S',
    'B.U.M.S',
    'B.V.Sc',
    'AH-',
  ];

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
    // dropdownvalue =
    //     isLangEnglish ? "Select Qualification" : 'योग्यता का चयन करें';
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
        child: Stack(
          children: [
            CustomPaint(
              size: Size(width, height),
              painter: CirclePainter(),
            ),
            Container(
              width: width,
              padding: EdgeInsets.only(top: 0.088235 * height),
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
              padding: EdgeInsets.only(top: 0.15 * height),
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
            Container(
              padding: EdgeInsets.only(top: 0.48 * height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  if (_doctorQualification.text == 'Select Qualification' ||
                      _doctorQualification.text == 'योग्यता का चयन करें' ||
                      _doctorQualification.text.isEmpty) {
                    String titleText = isLangEnglish
                        ? "InValid Qualification!"
                        : "अमान्य योग्यता!";
                    String contextText = isLangEnglish
                        ? "Please select a valid Qualification..."
                        : "कृपया एक मान्य योग्यता चुनें...";
                    _checkForError(context, titleText, contextText);
                  } else {
                    Navigator.of(context)
                        .pushNamed(SelectMedicineTypeScreen.routeName);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff42ccc3),
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
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center,
                ),
                child: Text(
                  isLangEnglish ? "Next" : "अगला",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFFfbfcff),
                  ),
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
                isLangEnglish ? "Qualifications" : "योग्यता",
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
              width: width,
              padding: EdgeInsets.only(top: 0.4 * height),
              child: Text(
                // "Please select \nappropriate Qualification",
                isLangEnglish
                    ? "Select your Qualification"
                    : "अपनी योग्यता का चयन करें",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  color: Color(0xff2c2c2c),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.42 * height),
              // width: screenWidth * 0.75,
              // color: Colors.white,
              alignment: Alignment.topCenter,
              child: Container(
                // width: screenWidth * 0.7125,
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: qualificationSelectionList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                      _doctorQualification.text = dropdownvalue;
                    });
                  },
                ),
              ),
            ),
            // dropDownMenu(
            //   context,
            //   qualificationSelectionList,
            //   _doctorQualification,
            //   "Select Qualification",
            // ),
            Container(
              padding: EdgeInsets.only(top: 0.48 * height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  if (_doctorQualification.text == 'Select Qualification' ||
                      _doctorQualification.text == 'योग्यता का चयन करें' ||
                      _doctorQualification.text.isEmpty) {
                    String titleText = isLangEnglish
                        ? "InValid Qualification!"
                        : "अमान्य योग्यता!";
                    String contextText = isLangEnglish
                        ? "Please select a valid Qualification..."
                        : "कृपया एक मान्य योग्यता चुनें...";
                    _checkForError(context, titleText, contextText);
                  } else {
                    Provider.of<DoctorUserDetails>(context, listen: false)
                        .setDoctorQualification(_doctorQualification);
                    Navigator.of(context)
                        .pushNamed(SelectMedicineTypeScreen.routeName);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff42ccc3),
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
                  isLangEnglish ? "Next" : "अगला",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFFfbfcff),
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

  Widget TextFieldContainer(
    BuildContext context,
    String textLabel,
    int maxLgt,
    TextEditingController _textCtr,
    TextInputType keyBoardType,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.008,
        horizontal: screenWidth * 0.03,
      ),
      child: TextField(
        maxLength: maxLgt,
        decoration: InputDecoration(
            labelText: '${textLabel}: ',
            hintStyle: TextStyle(fontWeight: FontWeight.bold)),
        controller: _textCtr,
        keyboardType: keyBoardType,
        onSubmitted: (_) {},
      ),
    );
  }

  Widget dropDownMenu(
    BuildContext context,
    List<String> dropDownList,
    TextEditingController _textCtr,
    String hintText,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Container(
      // alignment: Alignment.center,
      // width: screenWidth * 0.5,
      // height: screenHeight * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade100,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.0025,
      ),
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.0025,
        horizontal: screenWidth * 0.001,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Align(
            alignment: Alignment.centerLeft,
            child: _textCtr.text.length == 0
                ? Text("${hintText}")
                : Text(
                    "${_textCtr.text}",
                    style: TextStyle(color: Colors.black),
                  ),
          ),
          isDense: true,
          isExpanded: true,
          iconSize: 30,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          onTap: () {},
          items: dropDownList.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() {
            _textCtr.text = value!;
          }),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      );

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
