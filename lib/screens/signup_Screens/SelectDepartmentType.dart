// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:doctor/providers/doctorQualification_details.dart';
import 'package:doctor/screens/signup_Screens/EnterPersonalDetailsScreen.dart';
import 'package:doctor/screens/signup_Screens/EnterPhoneNumber_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../HelperStuff/circle_painter.dart';
import '../../HelperStuff/rounded_rectangle.dart';
import '../../StarterScreens/qualifications.dart';

import '../../providers/doctorAuth_details.dart';
import '../../providers/doctorUser_details.dart';

class SelectDepartmentTypeScreen extends StatefulWidget {
  static const routeName = '/doctor-select-department-type-screen';

  @override
  State<SelectDepartmentTypeScreen> createState() =>
      _SelectDepartmentTypeScreenState();
}

class _SelectDepartmentTypeScreenState
    extends State<SelectDepartmentTypeScreen> {
  TextEditingController _doctorDepartmentType = TextEditingController();
  bool isLangEnglish = true;
  String dropdownvalue = 'Select the Department';
  List<String> items = [];

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
    List<String> list =
        Provider.of<DoctorQualificationDetails>(context, listen: false)
            .getDepartmentList(
                Provider.of<DoctorUserDetails>(context, listen: false)
                    .getDoctorMedicineType()
                    .text
                    .toString());
    items = list;
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

    // dropdownvalue =
    //     isLangEnglish ? "Select the Department" : "विभाग का चयन करें";

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
                isLangEnglish ? "Department" : "विभाग",
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
              padding: EdgeInsets.only(top: 0.41125 * height),
              child: Text(
                isLangEnglish
                    ? "Select Department of Expertise"
                    : "विशेषज्ञता विभाग का चयन करें",
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
              padding: EdgeInsets.only(top: 0.435 * height),
              // color: Colors.white,
              alignment: Alignment.topCenter,
              child: Container(
                width: screenWidth * 0.7125,
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: Colors.grey,
                //     width: 1,
                //   ),
                // ),
                child: DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
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
                      _doctorDepartmentType.text = dropdownvalue;
                    });
                  },
                ),
              ),
            ),
            // Container(
            //   width: screenWidth * 0.65,
            //   padding: EdgeInsets.only(top: 0.44 * height),
            //   alignment: Alignment.topCenter,
            //   child: Container(
            //     child: DropdownButton<String>(
            //       value: dropdownvalue,
            //       items: items.map(buildMenuItem).toList(),
            //       onChanged: (value) => setState(
            //         () {
            //           _doctorDepartmentType.text = value.toString();
            //           dropdownvalue = value.toString();
            //         },
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.only(top: 0.44 * height),
            //   alignment: Alignment.topCenter,
            //   child: Container(
            //     width: screenWidth * 0.65,
            //     child: DropdownButton(
            //       dropdownColor: Colors.white,

            //       // Initial Value
            //       value: dropdownvalue,
            //       // Down Arrow Icon
            //       icon: Icon(Icons.keyboard_arrow_down),

            //       // Array list of items
            //       items: items.map((String items) {
            //         return DropdownMenuItem(
            //           value: items,
            //           child: Text(items),
            //         );
            //       }).toList(),
            //       // After selecting the desired option,it will
            //       // change button value to selected value
            //       onChanged: (String? newValue) {
            //         setState(() {
            //           dropdownvalue = newValue!;
            //           _doctorDepartmentType.text = dropdownvalue;
            //         });
            //       },
            //     ),
            //   ),
            // ),

            Container(
              padding: EdgeInsets.only(top: 0.525 * height),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () {
                  if (_doctorDepartmentType.text == 'Select the Department' ||
                      _doctorDepartmentType.text == "विभाग का चयन करें" ||
                      _doctorDepartmentType.text.isEmpty) {
                    String titleText =
                        isLangEnglish ? "InValid Department!" : "अमान्य विभाग!";
                    String contextText = isLangEnglish
                        ? "Please select a valid Department..."
                        : "कृपया एक वैध विभाग चुनें...";
                    _checkForError(context, titleText, contextText);
                  } else {
                    Provider.of<DoctorUserDetails>(context, listen: false)
                        .setDoctorDepartmentOfExpertise(_doctorDepartmentType);
                    Navigator.of(context)
                        .pushNamed(EnterUserPersonalDetailsScreen.routeName);
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xff42ccc3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(27.5),
                      ),
                    ),
                    side: BorderSide(color: Color(0xffebebeb), width: 1),
                    padding: EdgeInsets.fromLTRB(
                      0.208333 * width,
                      0.016624 * height,
                      0.205555 * width,
                      0.016624 * height,
                    ),
                    minimumSize: Size(221, 55),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center),
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );

  // Widget dropDownMenu(
  //   BuildContext context,
  //   List<String> dropDownList,
  //   TextEditingController _textCtr,
  //   String hintText,
  // ) {
  //   var screenHeight = MediaQuery.of(context).size.height;
  //   var screenWidth = MediaQuery.of(context).size.width;
  //   var topInsets = MediaQuery.of(context).viewInsets.top;
  //   var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
  //   var useableHeight = screenHeight - topInsets - bottomInsets;

  //   return Container(
  //     // alignment: Alignment.center,
  //     // width: screenWidth * 0.5,
  //     // height: screenHeight * 0.05,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8),
  //       color: Colors.grey.shade100,
  //     ),
  //     margin: EdgeInsets.symmetric(
  //       horizontal: screenWidth * 0.0025,
  //     ),
  //     padding: EdgeInsets.symmetric(
  //       vertical: screenHeight * 0.0025,
  //       horizontal: screenWidth * 0.001,
  //     ),
  //     child: Container(
  //       width: screenWidth * 0.5,
  //       child: DropdownButtonHideUnderline(
  //         child: DropdownButton<String>(
  //           hint: Align(
  //             alignment: Alignment.centerLeft,
  //             child: _textCtr.text.length == 0
  //                 ? Text("${hintText}")
  //                 : Text(
  //                     "${_textCtr.text}",
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //           ),
  //           isDense: true,
  //           isExpanded: true,
  //           iconSize: 30,
  //           icon: Icon(
  //             Icons.arrow_drop_down,
  //             color: Colors.black,
  //           ),
  //           onTap: () {},
  //           items: dropDownList.map(buildMenuItem).toList(),
  //           onChanged: (value) => setState(() {
  //             _textCtr.text = value!;
  //           }),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
  //       value: item,
  //       child: Text(
  //         item,
  //         style: TextStyle(
  //           fontWeight: FontWeight.normal,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     );

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
