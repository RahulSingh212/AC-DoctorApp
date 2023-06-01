// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, deprecated_member_use, unused_local_variable, unused_element

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/models/token_info.dart';
import 'package:doctor/providers/doctorCalendar_details.dart';
import 'package:doctor/providers/doctorUpcomingAppointments_details.dart';
import 'package:doctor/screens/TextMessage_Screens/MessageChatting_Screen.dart';
import 'package:doctor/screens/doctorAppointment_Screens/DoctorNewPrescription_Screen.dart';
import 'package:doctor/screens/doctorAppointment_Screens/PatientAppointmentDescription_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../providers/doctorAuth_details.dart';
import '../../providers/doctorUser_details.dart';
import '../Tabs_Screen.dart';

class PatientAppointmentInformationScreen extends StatefulWidget {
  static const routeName = '/doctor-patient-appointment-information-screen';

  int pageIndex;
  BookedTokenSlotInformation tokenInfo;

  PatientAppointmentInformationScreen(
    this.pageIndex,
    this.tokenInfo,
  );

  @override
  State<PatientAppointmentInformationScreen> createState() =>
      _PatientAppointmentInformationScreenState();
}

class _PatientAppointmentInformationScreenState
    extends State<PatientAppointmentInformationScreen> {
  bool isLangEnglish = true;
  String doctorCancellationReason = "";

  List<String> WeekListEnglish = [
    "Mon",
    "Tues",
    "Wed",
    "Thr",
    "Fri",
    "Sat",
    "Sun"
  ];
  List<String> YearListEnglish = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void initState() {
    super.initState();
    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  void getPatientMobileToken(String patientUserId) async {
    String patientMobileToken = "";

    var response = await FirebaseFirestore.instance
        .collection('PatientUsersPersonalInformation')
        .doc(patientUserId)
        .get()
        .then(
      (DocumentSnapshot ds) {
        patientMobileToken =
            ds.get('patient_MobileMessagingTokenId').toString();

        if (patientMobileToken != "") {
          String doctorName =
              Provider.of<DoctorUserDetails>(context, listen: false)
                  .mp["doctor_FullName"]
                  .toString();
          String notificationTitle = "Appointment Cancelled!";
          if (doctorCancellationReason == "") {
            doctorCancellationReason = "Doctor didn't mention any reason for appointment cancellation.\nPlease contact Customer care for detailed information.";
          }
          String notificationBody = "Doctor: $doctorName,\nTime: ${widget.tokenInfo.bookedTokenTime.format(context).toString()}\nDate: ${DateFormat.yMMMMd('en_US').format(widget.tokenInfo.bookedTokenDate)},\nReason:\n$doctorCancellationReason";

          sendPushMessage(
            patientMobileToken,
            notificationBody,
            notificationTitle,
          );
        }
      },
    );
  }

  void sendPushMessage(
    String token,
    String body,
    String title,
  ) async {
    try {
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAJf9Zzxw:APA91bG2byLOz03IcaNF5kfF9jeEj9hudr-VbWCNfBBuGdi6GYToR_rutgKIynxNfeNjKzSBC2JFMZ1xX_e6wVBgL-5yihEtdxcMWMshW8fggjQRxyBuR5QabafIUBpC3iAA9gpHxzSG',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              'title': title,
              "body": body,
              "android_channel_id": "aurigaCare",
            },
            "to": token,
          },
        ),
      );
    } catch (errorVal) {}
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        title: Text('${widget.tokenInfo.patient_FullName}'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              alignment: Alignment.centerLeft,
              child: Text(
                isLangEnglish
                    ? "${widget.tokenInfo.patient_FullName} has booked an appointment on:"
                    : "${widget.tokenInfo.patient_FullName} ने अपॉइंटमेंट बुक किया है:",
                style: TextStyle(
                  color: Color.fromRGBO(
                    150,
                    150,
                    150,
                    1,
                  ),
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.015,
                vertical: screenWidth * 0.045,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Color.fromRGBO(205, 205, 205, 1),
                ),
                borderRadius: BorderRadius.circular(12.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.4,
                    child: Text(
                      "${widget.tokenInfo.bookedTokenTime.format(context)}",
                      style: TextStyle(
                        color: Color.fromRGBO(66, 204, 195, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.075,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.4,
                    child: Text(
                      "${DateFormat.MMMd().format(widget.tokenInfo.bookedTokenDate).toString()}",
                      style: TextStyle(
                        color: Color.fromRGBO(66, 204, 195, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.075,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.035,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              alignment: Alignment.centerLeft,
              child: Text(
                isLangEnglish
                    ? "How is ${widget.tokenInfo.patient_FullName} Feeling?"
                    : "कैसा है ${widget.tokenInfo.patient_FullName} कि अनुभति?",
                style: TextStyle(
                  color: Color.fromRGBO(
                    150,
                    150,
                    150,
                    1,
                  ),
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.015,
          ),
          Align(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: screenWidth * 0.9,
              alignment: Alignment.centerLeft,
              child: Text(
                widget.tokenInfo.patientAilmentDescription == ""
                    ? isLangEnglish
                        ? "\"${widget.tokenInfo.patient_FullName} has not mentioned anything in the alignment.\""
                        : "\"${widget.tokenInfo.patient_FullName} संरेखण में कुछ भी उल्लेख नहीं किया है।\""
                    : widget.tokenInfo.patientAilmentDescription,
                style: TextStyle(
                  color: Color.fromRGBO(
                    150,
                    150,
                    150,
                    1,
                  ),
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.1,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PatientAppointmentDescriptionScreen(
                        3,
                        widget.tokenInfo,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.details_rounded,
                  // size: screenWidth * 0.075,
                ),
                label: Text(
                  isLangEnglish ? "VIEW PATIENT DETAILS" : "रोगी विवरण देखें",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(66, 204, 195, 1),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.075,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Align(
            child: Container(
              width: screenWidth * 0.9,
              child: ElevatedButton.icon(
                onPressed: () {
                  _doctorAppointmentCancellationShowBox(context);
                  // String titleText = isLangEnglish
                  //     ? "Cancel Appointment"
                  //     : "अपॉइंटमेंट रद्द करें";
                  // String contextText = isLangEnglish
                  //     ? "Are you sure you want to cancel the appointment?"
                  //     : "क्या आप वाकई अपॉइंटमेंट रद्द करना चाहते हैं?";
                  // _checkForErrorForCancellingAppointment(
                  //   context,
                  //   titleText,
                  //   contextText,
                  //   widget.tokenInfo,
                  // );
                },
                icon: Icon(
                  Icons.cancel_rounded,
                  // size: screenWidth * 0.075,
                ),
                label: Text(
                  isLangEnglish ? "Cancel Appointment" : "अपॉइंटमेंट रद्द करें",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(247, 118, 115, 1),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02,
                    horizontal: screenWidth * 0.075,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _doctorAppointmentCancellationShowBox(
    BuildContext context,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: max(screenHeight, screenWidth) * 0.5,
            width: min(screenHeight, screenWidth) * 0.925,
            padding: EdgeInsets.symmetric(
              horizontal: min(screenHeight, screenWidth) * 0.04,
              vertical: min(screenHeight, screenWidth) * 0.06,
            ),
            child: ListView(
              physics: ScrollPhysics(),
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.325,
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: isLangEnglish ? 'Date\n' : "दिनांक\n",
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: Color.fromRGBO(137, 134, 137, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${WeekListEnglish[widget.tokenInfo.bookedTokenDate.weekday - 1]}, ${widget.tokenInfo.bookedTokenDate.day} ${YearListEnglish[widget.tokenInfo.bookedTokenDate.month - 1]}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.325,
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: isLangEnglish ? 'Time\n' : "समय\n",
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: Color.fromRGBO(137, 134, 137, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${widget.tokenInfo.bookedTokenTime.format(context).toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Container(
                  child: Text(
                    isLangEnglish
                        ? 'Write a brief description about appointment cacellation:'
                        : "नियुक्ति निरस्तीकरण के बारे में संक्षिप्त विवरण लिखें:",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Color.fromRGBO(205, 205, 205, 1),
                    ),
                  ),
                  child: TextField(
                    onChanged: ((value) {
                      doctorCancellationReason = value;
                    }),
                    decoration: InputDecoration(
                      hintText: isLangEnglish
                          ? 'Enter your reason...'
                          : "अपना कारण दर्ज करें",
                      focusedBorder: InputBorder.none,
                    ),
                    autocorrect: true,
                    minLines: 4,
                    maxLines: 4,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.035,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(ctx);
                    String titleText = isLangEnglish
                        ? "Cancel Appointment"
                        : "अपॉइंटमेंट रद्द करें";
                    String contextText = isLangEnglish
                        ? "Are you sure you want to cancel the appointment?"
                        : "क्या आप वाकई अपॉइंटमेंट रद्द करना चाहते हैं?";
                    _checkForErrorForCancellingAppointment(
                      context,
                      titleText,
                      contextText,
                      widget.tokenInfo,
                    );
                    setState(() {});
                  },
                  child: Container(
                    width: screenWidth * 0.65,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025,
                      horizontal: screenWidth * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff42CCC3),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        isLangEnglish ? "Next" : "अगला",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _checkForErrorForCancellingAppointment(
      BuildContext context,
      String titleText,
      String contextText,
      BookedTokenSlotInformation tokenInfo,
      {bool popVal = false}) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${titleText}'),
        content: Text('${contextText}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.dangerous_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Color.fromRGBO(121, 85, 72, 1),
            onPressed: () {
              Navigator.pop(ctx);
            },
            tooltip: "NO",
          ),
          IconButton(
            icon: Icon(
              Icons.check_circle_rounded,
              color: Color(0xff42ccc3),
            ),
            iconSize: 50,
            color: Colors.brown,
            onPressed: () {
              setState(
                () {
                  Provider.of<DoctorUpcomingAppointmentDetails>(context,
                          listen: false)
                      .cancelBookedAppointment(
                    context,
                    tokenInfo,
                  )
                      .then(
                    (value) {
                      Navigator.pop(ctx);
                      getPatientMobileToken(widget
                          .tokenInfo.patient_personalUniqueIdentificationId);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          TabsScreenDoctor.routeName, (route) => false);
                    },
                  );
                },
              );
            },
            tooltip: "YES",
          ),
        ],
      ),
    );
  }
}
