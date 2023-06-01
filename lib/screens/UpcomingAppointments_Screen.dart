// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_unnecessary_containers, unused_import, unused_local_variable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:doctor/models/token_info.dart';
import 'package:doctor/providers/doctorUpcomingAppointments_details.dart';
import 'package:doctor/screens/doctorAppointment_Screens/PatientAppointmentDescription_Screen.dart';
import 'package:doctor/screens/doctorAppointment_Screens/PatientAppointmentInformation_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/doctorAuth_details.dart';
import '../providers/doctorUser_details.dart';

class UpcomingAppointmentsScreenDoctor extends StatefulWidget {
  static const routeName = '/doctor-upcoming-appointments-screen';

  @override
  State<UpcomingAppointmentsScreenDoctor> createState() =>
      _UpcomingAppointmentsScreenDoctorState();
}

class _UpcomingAppointmentsScreenDoctorState
    extends State<UpcomingAppointmentsScreenDoctor> {
  bool isLangEnglish = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<DoctorUpcomingAppointmentDetails>(context)
        .fetchDoctorActiveUpcomingTokens(context);
  }

  @override
  void initState() {
    super.initState();

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
      backgroundColor: Color(0xFFf2f3f4),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          height * 0.1,
        ),
        child: AppBar(
          elevation: 2,
          centerTitle: false,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: Column(
            children: [
              SizedBox(
                height: height * 0.0425,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: height * 0.0001,
                  bottom: height * 0.0001,
                  left: width * 0.045,
                  right: width * 0.005,
                ),
                padding: EdgeInsets.only(
                  top: height * 0.005,
                  bottom: height * 0.005,
                ),
                child: Text(
                  isLangEnglish ? "Upcoming Appointments" : "आगामी नियुक्तियां",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: width * 0.045,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  isLangEnglish ? "Connect with your patients online" : "अपने मरीजों से ऑनलाइन जुड़ें",
                  style: TextStyle(
                    color: Color.fromRGBO(66, 204, 195, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 15.22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Provider.of<DoctorUpcomingAppointmentDetails>(context,
                    listen: false)
                .items
                .isEmpty
            ? Align(
                child: Container(
                  width: screenWidth * 0.9,
                  margin: EdgeInsets.only(
                    bottom: screenHeight * 0.02,
                  ),
                  child: Container(
                    // fit: BoxFit.fitWidth,
                    child: Text(
                      "No upcoming appointment",
                      style: TextStyle(
                        color: Color.fromRGBO(66, 204, 195, 1),
                        fontSize: screenWidth * 0.1,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: Provider.of<DoctorUpcomingAppointmentDetails>(
                        context,
                        listen: false)
                    .items
                    .length,
                itemBuilder: (ctx, index) {
                  return patientAppointmentWidget(
                    context,
                    Provider.of<DoctorUpcomingAppointmentDetails>(context,
                            listen: false)
                        .items[index],
                  );
                },
              ),
      ),
    );
  }

  Widget patientAppointmentWidget(
    BuildContext context,
    BookedTokenSlotInformation tokenInfo,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Align(
      child: InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => PatientAppointmentDescriptionScreen(
          //       3,
          //       tokenInfo,
          //     ),
          //   ),
          // );
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PatientAppointmentInformationScreen(
                3,
                tokenInfo,
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(
            top: screenHeight * 0.001,
          ),
          child: Container(
            width: screenWidth * 0.975,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Color.fromRGBO(242, 242, 242, 1),
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01125,
                  horizontal: screenWidth * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: Color.fromARGB(255, 233, 218, 218),
                        //   width: 1,
                        // ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: (tokenInfo.patient_ImageUrl == "" ||
                                  tokenInfo.patient_ImageUrl.toString() ==
                                      'null')
                              ? Image.asset(
                                  'assets/images/healthy.png',
                                  fit: BoxFit.fill,
                                  width: screenWidth * 0.2,
                                )
                              : Image.asset(
                                  'assets/images/healthy.png',
                                  fit: BoxFit.fill,
                                  width: screenWidth * 0.2,
                                ),
                              // : Image.network(
                              //     tokenInfo.patient_ImageUrl,
                              //     fit: BoxFit.fill,
                              //     width: screenWidth * 0.2,
                              //   ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.015,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              '${tokenInfo.patient_FullName}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.0525,
                                color: Colors.black,
                              ),
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.005,
                          ),
                          Container(
                            child: Text(
                              '${tokenInfo.bookedTokenTime.format(context)}',
                              style: TextStyle(
                                fontSize: screenWidth * 0.0475,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(114, 114, 114, 1),
                              ),
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * 0.0001,
                    ),
                    Container(
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                _dateShowerInCalendar(
                                  context,
                                  tokenInfo.bookedTokenDate,
                                );
                              },
                              child: Container(
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.0065,
                                ),
                                height: screenHeight * 0.05,
                                width: screenHeight * 0.040,
                                decoration: BoxDecoration(
                                    // color: Color.fromRGBO(66, 204, 195, 1),
                                    ),
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "assets/images/Calendar.png",
                                  ),
                                  color: Color.fromRGBO(108, 117, 125, 1),
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.19,
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.02,
                                vertical: screenWidth * 0.01,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.5),
                                color: Color.fromRGBO(66, 204, 195, 1),
                              ),
                              child: Text(
                                "${DateFormat.MMMd().format(tokenInfo.bookedTokenDate).toString()}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dateShowerInCalendar(BuildContext context, DateTime givenTime) {
    showDatePicker(
      context: context,
      firstDate: givenTime,
      initialDate: givenTime,
      lastDate: givenTime,
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        } else {}
      },
    );
  }
}
