// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable, unnecessary_cast

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:doctor/models/slot_info.dart';
import 'package:doctor/screens/MyCalender_ClinicSlots.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:duration_picker/duration_picker.dart';

import '../../providers/doctorAuth_details.dart';
import '../../providers/doctorUser_details.dart';
import '../../providers/doctorCalendar_details.dart';

class DoctorAppointmentSlot extends StatefulWidget {
  static const routeName = '/doctor-appointment-slot-screen';

  @override
  State<DoctorAppointmentSlot> createState() => _DoctorAppointmentSlotState();
}

class _DoctorAppointmentSlotState extends State<DoctorAppointmentSlot> {
  bool isLangEnglish = true;
  bool isSaveBtnPressed = false;

  @override
  void initState() {
    super.initState();
    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;

    appointmentFees.text = "0.0";
    numberOfSlots.text = "0";
  }

  bool isCheckBoxClicked = true;
  bool isClinicCheckBoxClicked = true;
  bool isVideoCheckBoxClicked = false;
  bool isRepeatCheckBoxClicked = false;
  bool isWeekWidgetVissible = false;

  Duration _slotDuration = Duration(hours: 0, minutes: 0);
  bool isSlotDurationSet = false;
  var _currDateTime = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var _expiryDateTime = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var _timechosen1 = TimeOfDay.now();
  var _timechosen2 = TimeOfDay.now();
  TextEditingController appointmentFees = TextEditingController();
  TextEditingController numberOfSlots = TextEditingController();

  List<bool> weekDaySelected = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    var currLoggedInUser = FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            height: screenHeight * 0.055,
            width: screenWidth * 0.9,
            padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: screenHeight * 0.0025,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(66, 204, 195, 1),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 35,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
              top: screenHeight * 0.005,
              // bottom: screenHeight * 0.01,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(66, 204, 195, 1),
            ),
            height: screenHeight * 0.11,
            width: screenWidth,
            child: Text(
              isLangEnglish
                  ? "Create your Available \nAppointment Details..."
                  : "अपना उपलब्ध \nअपॉइंटमेंट विवरण बनाएं...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.065,
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Container(
            height: screenHeight * 0.05,
            width: screenWidth * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Material(
                  color: Colors.white,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Color.fromRGBO(120, 158, 156, 1),
                    ),
                    child: Checkbox(
                      activeColor: Color.fromRGBO(120, 158, 156, 1),
                      checkColor: Colors.white,
                      value: isClinicCheckBoxClicked,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null) {
                            isClinicCheckBoxClicked = !isClinicCheckBoxClicked;
                            isVideoCheckBoxClicked = !isVideoCheckBoxClicked;
                          }
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.025,
                ),
                Text(isLangEnglish ? 'Clinic' : "क्लिनिक"),
                SizedBox(
                  width: screenWidth * 0.04,
                ),
                Material(
                  color: Colors.white,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Color.fromRGBO(120, 158, 156, 1),
                    ),
                    child: Checkbox(
                      activeColor: Color.fromRGBO(120, 158, 156, 1),
                      checkColor: Colors.white,
                      value: isVideoCheckBoxClicked,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null) {
                            isClinicCheckBoxClicked = !isClinicCheckBoxClicked;
                            isVideoCheckBoxClicked = !isVideoCheckBoxClicked;
                          }
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.025,
                ),
                Text(isLangEnglish ? 'Video' : "वीडियो"),
                SizedBox(
                  width: screenWidth * 0.275,
                ),
                InkWell(
                  onTap: () {
                    _presentDatePicker(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.0025,
                    ),
                    height: screenHeight * 0.04,
                    width: screenHeight * 0.04,
                    decoration: BoxDecoration(
                        // color: Color.fromRGBO(66, 204, 195, 1),
                        ),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/Calendar.png",
                      ),
                      // color: Color.fromRGBO(66, 204, 195, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.9,
              child: Text(
                isLangEnglish
                    ? "Available Time Interval:"
                    : "उपलब्ध समय अंतराल:",
                style: TextStyle(
                  fontWeight: ui.FontWeight.bold,
                  fontSize: screenWidth * 0.06,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.0125,
            ),
            height: screenHeight * 0.125,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: screenHeight * 0.1,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _presentTimePicker(context, 0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.325,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: Color(0xffCDCDCD),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.025,
                            horizontal: screenWidth * 0.05,
                          ),
                          child: Text(
                            "${_timechosen1.format(context)}",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.004,
                      ),
                      Container(
                        child: Text(isLangEnglish ? 'Start' : "शुरू"),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffCDCDCD),
                      width: 1.5,
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.1,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _presentTimePicker(context, 1);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.325,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 2,
                              color: Color(0xffCDCDCD),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenWidth * 0.025,
                            horizontal: screenWidth * 0.05,
                          ),
                          child: Text(
                            "${_timechosen2.format(context)}",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.004,
                      ),
                      Container(
                        child: Text(isLangEnglish ? 'End' : "समाप्त"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.symmetric(
                // vertical: screenHeight * 0.0125,
                horizontal: screenWidth * 0.01,
              ),
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: isLangEnglish
                          ? 'Activation Date: '
                          : "सक्रियण तिथि:   ",
                      style: TextStyle(
                        color: Color.fromRGBO(108, 117, 125, 1),
                      ),
                    ),
                    TextSpan(
                      text:
                          '${DateFormat.yMMMMd('en_US').format(_currDateTime as DateTime)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(108, 117, 125, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.symmetric(
                // vertical: screenHeight * 0.0125,
                horizontal: screenWidth * 0.01,
              ),
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: isLangEnglish
                          ? 'Expiry Date:         '
                          : "समाप्ति तिथि:    ",
                      style: TextStyle(
                        color: Color.fromRGBO(108, 117, 125, 1),
                      ),
                    ),
                    TextSpan(
                      text: !isRepeatCheckBoxClicked
                          ? '${DateFormat.yMMMMd('en_US').format(_expiryDateTime as DateTime)}'
                          : isLangEnglish
                              ? 'Repeated Weakly...'
                              : "बार-बार कमजोर...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(108, 117, 125, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Material(
            child: Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Color.fromRGBO(120, 158, 156, 1),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  // width: screenWidth * 0.9,
                  child: CheckboxListTile(
                    title: Text(isLangEnglish ? "Repeat" : "दोहराना"),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Color.fromRGBO(120, 158, 156, 1),
                    checkColor: Colors.white,
                    value: isRepeatCheckBoxClicked,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null) {
                          isRepeatCheckBoxClicked = !isRepeatCheckBoxClicked;
                          isWeekWidgetVissible = !isWeekWidgetVissible;

                          if (!isRepeatCheckBoxClicked) {
                            weekDaySelected = List.filled(7, false);
                          }
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          !isWeekWidgetVissible
              ? SizedBox(height: screenHeight * 0.025)
              : weekDaySelectorWidget(context),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: screenHeight * 0.075,
              width: screenWidth * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(
                // horizontal: screenWidth * 0.03,
                vertical: screenHeight * 0.001,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      isLangEnglish
                          ? "Average Slot Duration: "
                          : "औसत स्लॉट अवधि: ",
                      style: TextStyle(
                        fontWeight: ui.FontWeight.bold,
                        fontSize: screenWidth * 0.06,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var pickedDuration = await showDurationPicker(
                        context: context,
                        initialTime: _slotDuration,
                      );

                      if (pickedDuration == null) {
                        return;
                      }

                      // int numSlots = (((_timechosen2.hour * 60 + _timechosen2.minute) - (_timechosen1.hour * 60 + _timechosen1.minute))/pickedDuration.inMinutes).ceil();
                      int numSlots =
                          (((_timechosen2.hour * 60 + _timechosen2.minute) -
                                      (_timechosen1.hour * 60 +
                                          _timechosen1.minute)) /
                                  15)
                              .ceil();
                      if (pickedDuration.inMinutes > 120) {
                        String titleText = isLangEnglish
                            ? "In-Valid slot duration!"
                            : "इन-वैध स्लॉट अवधि!";
                        String contextText = isLangEnglish
                            ? "Slot duration cannot be greater than 2 hours."
                            : "स्लॉट की अवधि 2 घंटे से अधिक नहीं हो सकती।";

                        _checkForError(context, titleText, contextText);
                        return;
                      } else if (numSlots < 1) {
                        String titleText = isLangEnglish
                            ? "In-Valid number of slots!"
                            : "स्लॉट की वैध संख्या!";
                        String contextText = isLangEnglish
                            ? "Slots count should be greater than 1."
                            : "स्लॉट की संख्या 1 से अधिक होनी चाहिए।";

                        _checkForError(context, titleText, contextText);
                        return;
                      }

                      // numberOfSlots.text = numSlots as String;

                      setState(() {
                        if (pickedDuration == Duration(hours: 0, minutes: 0)) {
                          isSlotDurationSet = false;
                        } else {
                          isSlotDurationSet = true;
                        }
                        _slotDuration = pickedDuration;
                        numberOfSlots.text = numSlots.toString();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenHeight * 0.0125,
                        vertical: screenWidth * 0.00135,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            // color: Colors.black,
                            ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Text(
                        "${_slotDuration.inHours.remainder(60)}:${_slotDuration.inMinutes.remainder(60)}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     width: screenWidth * 0.95,
          //     // padding: EdgeInsets.symmetric(
          //     //   horizontal: screenHeight * 0.00125,
          //     //   vertical: screenWidth * 0.0005,
          //     // ),
          //     // margin: EdgeInsets.symmetric(
          //     //   vertical: screenHeight * 0.01,
          //     // ),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5),
          //       color: Colors.white,
          //     ),
          //     child: TextButton(
          //       child: Text(
          //         'Select Duration',
          //         style: TextStyle(
          //           fontSize: screenWidth * 0.05,
          //         ),
          //       ),
          //       onPressed: () async {
          //         var pickedDuration = await showDurationPicker(
          //           context: context,
          //           initialTime: _slotDuration,
          //         );

          //         if (pickedDuration == null) {
          //           return;
          //         }

          //         setState(() {
          //           if (pickedDuration == Duration(hours: 0, minutes: 0)) {
          //             isSlotDurationSet = false;
          //           }
          //           else {
          //             isSlotDurationSet = true;
          //           }
          //           _slotDuration = pickedDuration;
          //         });
          //       },
          //     ),
          //   ),
          // ),
          SizedBox(
            height: screenHeight * 0.00125,
          ),
          // TextFieldContainer(
          //   context,
          //   isLangEnglish ? "Maximum Number of Slots" : "स्लॉट की अधिकतम संख्या",
          //   numberOfSlots,
          //   TextInputType.number,
          // ),
          TextShowingFieldContainer(
            context,
            isLangEnglish
                ? "Maximum Number of Slots"
                : "स्लॉट की अधिकतम संख्या",
            numberOfSlots,
          ),
          TextFieldContainer(
            context,
            isLangEnglish
                ? "Appointment Fees per Person"
                : "प्रति व्यक्ति नियुक्ति शुल्क",
            appointmentFees,
            TextInputType.number,
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Container(
            child: isSaveBtnPressed ? CircularProgressIndicator() : TextButton(
              onPressed: () {
                String bitVal = "";
                for (var i = 0; i < 7; i++) {
                  if (weekDaySelected[i]) {
                    bitVal += "1";
                  } else {
                    bitVal += "0";
                  }
                }

                if (isRepeatCheckBoxClicked && bitVal == "0000000") {
                  String titleText = isLangEnglish
                      ? "Invalid Repeat Day"
                      : "अमान्य दोहराव दिवस";
                  String contextText = isLangEnglish
                      ? "Please Select a valid Repeat Day of the Week..."
                      : "कृपया सप्ताह का एक मान्य दोहराव दिन चुनें...";
                  _checkForError(context, titleText, contextText);
                } else if (_slotDuration == Duration(hours: 0, minutes: 0)) {
                  String titleText = isLangEnglish
                      ? "Invalid Slot Duration"
                      : "अमान्य स्लॉट अवधि";
                  String contextText = isLangEnglish
                      ? "Please Select a valid Slot Duration..."
                      : "कृपया एक मान्य स्लॉट अवधि चुनें...";
                  _checkForError(context, titleText, contextText);
                } else if (int.tryParse(numberOfSlots.text) == null) {
                  String titleText = isLangEnglish
                      ? "Invalid Slot Duration"
                      : "अमान्य स्लॉट अवधि";
                  String contextText = isLangEnglish
                      ? "Please Select a valid Slot Duration..."
                      : "कृपया एक मान्य स्लॉट अवधि चुनें...";
                  _checkForError(context, titleText, contextText);
                } else if (int.parse(numberOfSlots.text) <= 0) {
                  String titleText = isLangEnglish
                      ? "Invalid Slots Number"
                      : "अमान्य स्लॉट संख्या";
                  String contextText = isLangEnglish
                      ? "Please Select Valid Count of Slots..."
                      : "कृपया स्लॉट की मान्य संख्या चुनें...";
                  _checkForError(context, titleText, contextText);
                } else if (double.tryParse(appointmentFees.text) == null) {
                  String titleText = isLangEnglish
                      ? "Invalid Appointment Fee Amount"
                      : "कृपया 0 से बड़े स्लॉट चुनें...";
                  String contextText = isLangEnglish
                      ? "Please Select Valid Amount of Fees to be Charged..."
                      : "कृपया शुल्क की जाने वाली मान्य राशि का चयन करें...";
                  _checkForError(context, titleText, contextText);
                } else if (double.parse(appointmentFees.text) < 0) {
                  String titleText = isLangEnglish
                      ? "Invalid Appointment Fee Amount"
                      : "कृपया 0 से बड़े स्लॉट चुनें...";
                  String contextText = isLangEnglish
                      ? "Appointment Fees cannot be negative..."
                      : "नियुक्ति शुल्क नकारात्मक नहीं हो सकता...";
                  _checkForError(context, titleText, contextText);
                } else {
                  DoctorSlotInformation slotInfo = new DoctorSlotInformation(
                    slotUniqueId: "${loggedInUserId}-${DateTime.now()}",
                    isClinic: isClinicCheckBoxClicked,
                    isVideo: isVideoCheckBoxClicked,
                    registeredDate: _currDateTime,
                    expiredDate: _expiryDateTime,
                    startTime: _timechosen1,
                    endTime: _timechosen2,
                    isRepeat: isRepeatCheckBoxClicked,
                    repeatWeekDaysList: weekDaySelected,
                    isSlotActive: true,
                    patientSlotIntervalDuration: _slotDuration,
                    maximumNumberOfSlots: int.parse(numberOfSlots.text),
                    appointmentFeesPerPatient:
                        double.parse(appointmentFees.text),
                  );
                  setState(() {
                    isSaveBtnPressed = true;
                  });
                  Provider.of<DoctorCalendarDetails>(context, listen: false)
                      .addNewAppointmentSlot(context, slotInfo);
                }
              },
              child: Container(
                width: screenWidth * 0.95,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.025,
                  horizontal: screenWidth * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff42CCC3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    isLangEnglish ? "Save" : "सेव",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.001,
          ),
        ],
      ),
    );
  }

  Widget TextFieldContainer(
    BuildContext context,
    String labelText,
    TextEditingController ansText,
    TextInputType keyBoardType,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    ansText.selection =
        TextSelection.fromPosition(TextPosition(offset: ansText.text.length));

    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          // color: Color.fromRGBO(66, 204, 195, 1),
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.005,
          // horizontal: screenWidth * 0.00125,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.01,
        ),
        height: screenHeight * 0.1,
        width: screenWidth * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: screenWidth * 0.8,
              child: TextFormField(
                autocorrect: true,
                // autofocus: true,
                enabled: true,
                controller: ansText,
                keyboardType: keyBoardType,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: labelText,
                ),
              ),
            ),
            // ClipOval(
            //   child: Material(
            //     color: Color.fromRGBO(220, 229, 228, 1), // Button color
            //     child: InkWell(
            //       splashColor: Color.fromRGBO(120, 158, 156, 1), // Splash color
            //       onTap: () {
            //         setState(() {

            //         });
            //       },
            //       child: Padding(
            //         padding: EdgeInsets.all(2),
            //         child: SizedBox(
            //           width: screenWidth * 0.075,
            //           height: screenWidth * 0.075,
            //           child: Icon(
            //             editBtnMapping[contentText] == false
            //                 ? Icons.edit_rounded
            //                 : Icons.save_rounded,
            //             size: 21,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget TextShowingFieldContainer(
    BuildContext context,
    String labelText,
    TextEditingController showingTextCtr,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white70,
          // color: Color.fromRGBO(66, 204, 195, 1),
        ),
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.0015,
          // horizontal: screenWidth * 0.00125,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.01,
        ),
        height: screenHeight * 0.1,
        width: screenWidth * 0.95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth * 0.775,
              child: TextFormField(
                autocorrect: true,
                autofocus: true,
                enabled: false,
                controller: showingTextCtr,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: labelText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeDurationPicker(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Align(
      alignment: Alignment.center,
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.75,
        child: DurationPicker(
          onChange: (pickerDuration) {
            setState(() {
              _slotDuration = pickerDuration;
            });
          },
          duration: _slotDuration,
        ),
      ),
    );
  }

  Widget weekDaySelectorWidget(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Align(
      alignment: Alignment.center,
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.035,
          horizontal: screenWidth * 0.01,
        ),
        margin: EdgeInsets.only(
          bottom: screenHeight * 0.025,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: WeekdaySelector(
          color: Color.fromRGBO(120, 158, 156, 1),
          selectedColor: Color.fromRGBO(120, 158, 156, 1),
          elevation: 3,
          fillColor: Colors.white,
          selectedFillColor: Color.fromRGBO(220, 229, 228, 1),
          onChanged: (int day) {
            setState(() {
              int index = day % 7;
              weekDaySelected[index] = !weekDaySelected[index];
            });
          },
          values: weekDaySelected,
        ),
      ),
    );
  }

  void _presentTimePicker(BuildContext context, int bitVal) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    TimeOfDay timechosen = TimeOfDay.now();
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: timechosen,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(primaryColor: Color(0xff42CCC3)),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
            child: Directionality(
              textDirection: ui.TextDirection.ltr,
              child: child!,
            ),
          ),
        );
      },
    );
    if (time != null) {
      setState(() {
        timechosen = time;
        if (bitVal == 0) {
          _timechosen1 = timechosen;
          _timechosen2 = timechosen;
        } else if (bitVal == 1) {
          int t1 = _timechosen1.hour * 60 + _timechosen1.minute;
          int t2 = timechosen.hour * 60 + timechosen.minute;

          if (t1 <= t2) {
            _timechosen2 = timechosen;
          } else {
            String titleText = isLangEnglish
                ? "In-Valid Time Interval!"
                : "इन-वैध समय अंतराल!";
            String contextText = isLangEnglish
                ? "Ending time cannot be before the starging time..."
                : "समाप्ति समय प्रारंभिक समय से पहले नहीं हो सकता...";
            _checkForError(context, titleText, contextText);
          }
        }
      });
    }
  }

  void _presentDatePicker(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    DateTime lastPickingDate = DateTime.now().add(new Duration(days: 14));

    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: lastPickingDate,
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _currDateTime =
              DateTime.utc(pickedDate.year, pickedDate.month, pickedDate.day);
          _expiryDateTime = DateTime.utc(
              _currDateTime.year, _currDateTime.month, _currDateTime.day);
        });
      }
    });
  }

  void setExpiryDateOfSlot(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    var currYear = _currDateTime.year;
    var currMonth = _currDateTime.month;
    var currDay = _currDateTime.day;

    var dayLimit = 0;
    var monthLimit = 0;
    var yearLimit = 0;

    if ((currDay + 7) > 30) {
      if ((currDay + 7) % 30 == 0) {
        dayLimit = 1;
      } else {
        dayLimit = (currDay + 7) % 30;
      }

      monthLimit = currMonth + 1;
      if (monthLimit >= 12) {
        monthLimit = 1;
        yearLimit = currYear + 1;
      } else {
        yearLimit = currYear;
      }
    } else {
      dayLimit = currDay + 7;
      monthLimit = currMonth;
      yearLimit = currYear;
    }

    setState(() {
      _expiryDateTime = DateTime.utc(yearLimit, monthLimit, dayLimit);
    });
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
