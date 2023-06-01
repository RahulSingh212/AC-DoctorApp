// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctor/models/token_info.dart';
import 'package:doctor/providers/doctorUpcomingAppointments_details.dart';
import 'package:doctor/screens/TextMessage_Screens/MessageChatting_Screen.dart';
import 'package:doctor/screens/doctorAppointment_Screens/DoctorNewPrescription_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/doctorUser_details.dart';

class DoctorNotificationsScreen extends StatefulWidget {
  static const routeName = '/doctor-notifications-screen';

  int pageIndex;

  DoctorNotificationsScreen(
    this.pageIndex,
  );

  @override
  State<DoctorNotificationsScreen> createState() =>
      _DoctorNotificationsScreenState();
}

class _DoctorNotificationsScreenState extends State<DoctorNotificationsScreen> {
  bool isLangEnglish = true;
  var currDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<DoctorUpcomingAppointmentDetails>(context)
        .fetchDoctorActiveUpcomingTokens(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenHeight, screenWidth);
    var maxDimension = max(screenHeight, screenWidth);

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 204, 195, 1),
        title: Text(isLangEnglish ? 'Notifications' : "सूचनाएं"),
        centerTitle: true,
      ),
      body:
          Provider.of<DoctorUpcomingAppointmentDetails>(context, listen: false)
                  .items
                  .isEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: screenHeight * 0.85,
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.0125,
                  ),
                  child: Text(
                    isLangEnglish
                        ? "No notifications available..."
                        : "कोई सूचना उपलब्ध नहीं है...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: screenWidth * 0.065,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: Provider.of<DoctorUpcomingAppointmentDetails>(
                              context,
                              listen: false)
                          .getCompleteBookedTokens
                          .length +
                      1,
                  itemBuilder: (ctx, index) {
                    if (index <
                        Provider.of<DoctorUpcomingAppointmentDetails>(context,
                                listen: false)
                            .getCompleteBookedTokens
                            .length) {
                      return Align(
                        child: notificationWidget(
                          ctx,
                          Provider.of<DoctorUpcomingAppointmentDetails>(context,
                                  listen: false)
                              .getCompleteBookedTokens[index],
                        ),
                      );
                    } else {
                      return Container(
                        height: maxDimension * 0.025,
                      );
                    }
                  },
                ),
    );
  }

  Widget notificationWidget(
    BuildContext context,
    BookedTokenSlotInformation tokenInfo,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;
    var minDimension = min(screenHeight, screenWidth);
    var maxDimension = max(screenHeight, screenWidth);

    bool checkIfToday = (currDate.day == tokenInfo.bookedTokenDate.day) &&
        (currDate.month == tokenInfo.bookedTokenDate.month) &&
        (currDate.year == tokenInfo.bookedTokenDate.year);

    return GestureDetector(
      child: Container(
        // height: maxDimension * 0.1,
        width: screenWidth * 0.95,
        padding: EdgeInsets.symmetric(
          vertical: minDimension * 0.01,
          horizontal: minDimension * 0.01,
        ),
        margin: EdgeInsets.only(
          top: minDimension * 0.025,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.5),
          // color: Colors.white70,
          color: Color.fromRGBO(220, 229, 228, 1),
          border: checkIfToday
              ? Border.all(color: Color.fromRGBO(66, 204, 195, 1), width: 2)
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: minDimension * 0.2,
              height: minDimension * 0.2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 233, 218, 218),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: tokenInfo.doctorImageUrl == ""
                      ? Image.asset(
                          'assets/images/healthy.png',
                          fit: BoxFit.fill,
                          width: minDimension * 0.2,
                        )
                      : Image.network(
                          tokenInfo.doctorImageUrl,
                          fit: BoxFit.fill,
                          width: minDimension * 0.2,
                        ),
                ),
              ),
            ),
            SizedBox(
              width: minDimension * 0.025,
            ),
            FittedBox(
              // fit: BoxFit.fitHeight,
              fit: BoxFit.contain,
              child: Container(
                width: screenWidth * 0.685,
                alignment: Alignment.centerLeft,
                child: Text(
                  isLangEnglish
                      ? "Appointment on Day/Date: ${DateFormat.yMMMEd().format(tokenInfo.bookedTokenDate).toString()} on Time: ${tokenInfo.bookedTokenTime.format(context)} with Patient's name: ${tokenInfo.patient_FullName} has been booked. It will be available for a period of '45 minutes' from the scheduled time during which your patient can contact you and then it will be closed."
                      : "अपॉइंटमेंट दिन/दिनांकः:${DateFormat.yMMMEd().format(tokenInfo.bookedTokenDate).toString()} समय: ${tokenInfo.bookedTokenTime.format(context)} को मरीज का नाम: ${tokenInfo.patient_FullName} के द्वारा अपॉइंटमेंट बुक किया गया है| यह निर्धारित किये गए समय से 45 मिनट की अवधि के लिए उपलब्ध है इस दौरान आपके पेशेंट आपसे संपर्क कर सकते हैं और फिर इसे बंद कर दिया जायेगा|",
                  style: TextStyle(
                    fontSize: minDimension * 0.03,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
                // RichText(
                //   textAlign: TextAlign.justify,
                //   text: TextSpan(
                //     children: <TextSpan>[
                //       // TextSpan(
                //       //   text: isLangEnglish ? 'Your appointment has been confirmed for ' : "आपकी नियुक्ति की पुष्टि कर दी गई है ",
                //       //   style: TextStyle(
                //       //     fontSize: minDimension * 0.0325,
                //       //   ),
                //       // ),
                //       // TextSpan(
                //       //   text: "${DateFormat.yMMMEd().format(tokenInfo.bookedTokenDate).toString()} ",
                //       //   style: TextStyle(
                //       //     fontWeight: FontWeight.bold,
                //       //     fontSize: minDimension * 0.0325,
                //       //   ),
                //       // ),
                //       // TextSpan(
                //       //   text: isLangEnglish ? 'at ' : "पर ",
                //       //   style: TextStyle(
                //       //     fontSize: minDimension * 0.0325,
                //       //   ),
                //       // ),
                //       // TextSpan(
                //       //   text: "${tokenInfo.bookedTokenTime.format(context)} ${isLangEnglish ? "for a" : "के लिए"} ",
                //       //   style: TextStyle(
                //       //     fontSize: minDimension * 0.0325,
                //       //     fontWeight: FontWeight.bold,
                //       //   ),
                //       // ),
                //       // TextSpan(
                //       //   // text: isLangEnglish ? '${tokenInfo.isClinicAppointmentType ? "clinic appointment" : "क्लिनिक नियुक्ति"} ' : " ",
                //       //   text: '${tokenInfo.isClinicAppointmentType ? "${isLangEnglish ? "clinic appointment" : "क्लिनिक नियुक्ति"}" : "${isLangEnglish ? "video consultation" : "वीडियो परामर्श"}"}. ',
                //       //   style: TextStyle(
                //       //     fontWeight: FontWeight.bold,
                //       //     fontSize: minDimension * 0.0325,
                //       //   ),
                //       // ),
                //       // TextSpan(
                //       //   text: isLangEnglish ? "Your patient's name is: " : "आपके रोगी का नाम है: ",
                //       //   style: TextStyle(
                //       //     fontSize: minDimension * 0.0325,
                //       //   ),
                //       // ),
                //       // TextSpan(
                //       //   text: "${tokenInfo.doctorFullName}.\n",
                //       //   style: TextStyle(
                //       //     fontWeight: FontWeight.bold,
                //       //     fontSize: minDimension * 0.0325,
                //       //   ),
                //       // ),
                //       // TextSpan(
                //       //   text: isLangEnglish ? 'Your patient will be able to contact you ' : "आपका मरीज आपसे संपर्क कर सकेगा ",
                //       //   style: TextStyle(
                //       //     fontSize: minDimension * 0.0325,
                //       //   ),
                //       // ),
                //       // TextSpan(
                //       //   text: isLangEnglish ? "15-minute " : "15-मिनट ",
                //       //   style: TextStyle(
                //       //     fontWeight: FontWeight.bold,
                //       //     fontSize: minDimension * 0.0325,
                //       //   ),
                //       // ),
                //       // TextSpan(
                //       //   text: isLangEnglish ? 'before your appointed time and will be available for a duration of 45 minutes and then it\'ll be closed. ' : "आपके नियत समय से पहले और 45 मिनट की अवधि के लिए उपलब्ध होगा और फिर इसे बंद कर दिया जाएगा। ",
                //       //   style: TextStyle(
                //       //     fontSize: minDimension * 0.0325,
                //       //   ),
                //       // ),

                //       // TextSpan(
                //       //   text: isLangEnglish
                //       //       ? "Appointment on Day/Date: ${DateFormat.yMMMEd().format(tokenInfo.bookedTokenDate).toString()} on Time: ${tokenInfo.bookedTokenTime.format(context)} with Patient's name: ${tokenInfo.doctorFullName} has been booked. It will be available for a period of '45 minutes' from the scheduled time during which your patient can contact you and then it will be closed."
                //       //       : "अपॉइंटमेंट दिन/दिनांकः:${DateFormat.yMMMEd().format(tokenInfo.bookedTokenDate).toString()} समय: ${tokenInfo.bookedTokenTime.format(context)} को मरीज का नाम: ${tokenInfo.doctorFullName} के द्वारा अपॉइंटमेंट बुक किया गया है| यह निर्धारित किये गए समय से 45 मिनट की अवधि के लिए उपलब्ध है इस दौरान आपके पेशेंट आपसे संपर्क कर सकते हैं और फिर इसे बंद कर दिया जायेगा|",
                //       //   style: TextStyle(
                //       //     fontSize: minDimension * 0.0325,
                //       //   ),
                //       // ),
                //     ],
                //   ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
