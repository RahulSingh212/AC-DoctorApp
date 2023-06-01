// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:doctor/providers/doctorPatient_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/doctorAuth_details.dart';
import '../../providers/doctorUser_details.dart';
import '../../providers/doctorCalendar_details.dart';

import './Patient_Section.dart';
import './Recent_Section.dart';

class MyPatientsScreenDoctor extends StatefulWidget {
  static const routeName = '/doctor-my-patients-screen';

  @override
  State<MyPatientsScreenDoctor> createState() => _MyPatientsScreenDoctorState();
}

class _MyPatientsScreenDoctorState extends State<MyPatientsScreenDoctor> {
  bool isLangEnglish = true;

  @override
  void initState() {
    super.initState();

    isLangEnglish = Provider.of<DoctorUserDetails>(context, listen: false)
        .isReadingLangEnglish;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<DoctorPatientDetails>(context)
        .fetchDoctorPreviousPatients(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(
              isLangEnglish ? "My Patients" : "मेरे मरीज़",
              // time,

              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 24),
            ),
            bottom: TabBar(
              indicatorColor: Color(0xff42ccc3),
              tabs: [
                Tab(
                  child: Text(
                    isLangEnglish ? "Patients" : "हाल ही का",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    isLangEnglish ? "Recent" : "हालिया",
                    // time,
                    // textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              MyPatients_PatientSectionTab(),
              MyPatients_RecentSectionTab(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget patientAppointmentWidget(
  //   BuildContext context,
  // ) {
  //   var screenHeight = MediaQuery.of(context).size.height;
  //   var screenWidth = MediaQuery.of(context).size.width;
  //   var topInsets = MediaQuery.of(context).viewInsets.top;
  //   var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
  //   var useableHeight = screenHeight - topInsets - bottomInsets;

  //   return InkWell(
  //     onTap: () {
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(
  //       //     builder: (context) => PatientAppointmentDescriptionScreen(
  //       //       0,
  //       //       tokenInfo,
  //       //     ),
  //       //   ),
  //       // );
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(
  //       //     builder: (context) => PatientAppointmentInformationScreen(
  //       //       0,
  //       //       tokenInfo,
  //       //     ),
  //       //   ),
  //       // );
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(
  //         top: screenHeight * 0.01,
  //       ),
  //       child: Card(
  //         elevation: 2,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //           side: BorderSide(
  //             color: Color.fromRGBO(242, 242, 242, 1),
  //           ),
  //         ),
  //         child: Container(
  //           alignment: Alignment.center,
  //           padding: EdgeInsets.symmetric(
  //             vertical: screenHeight * 0.01125,
  //             horizontal: screenWidth * 0.025,
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Container(
  //                 width: screenWidth * 0.2,
  //                 height: screenWidth * 0.2,
  //                 decoration: BoxDecoration(
  //                   // border: Border.all(
  //                   //   color: Color.fromARGB(255, 233, 218, 218),
  //                   //   width: 1,
  //                   // ),
  //                   borderRadius: BorderRadius.circular(5),
  //                 ),
  //                 child: Center(
  //                   child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(10),
  //                       child: Image.asset(
  //                         'assets/images/uProfile.png',
  //                         fit: BoxFit.fill,
  //                         width: screenWidth * 0.2,
  //                       )
  //                       // (tokenInfo.patient_ImageUrl == "" ||
  //                       //         tokenInfo.patient_ImageUrl.toString() == 'null')
  //                       //     ? Image.asset(
  //                       //         'assets/images/uProfile.png',
  //                       //         fit: BoxFit.fill,
  //                       //         width: screenWidth * 0.2,
  //                       //       )
  //                       //     : Image.network(
  //                       //         tokenInfo.patient_ImageUrl,
  //                       //         fit: BoxFit.fill,
  //                       //         width: screenWidth * 0.2,
  //                       //       ),
  //                       ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: screenWidth * 0.03,
  //               ),
  //               Container(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     // Name of the Paitent
  //                     // Container(
  //                     //   child: Text(
  //                     //     '${tokenInfo.patient_FullName}',
  //                     //     style: TextStyle(
  //                     //       fontWeight: FontWeight.bold,
  //                     //       fontSize: screenWidth * 0.0525,
  //                     //       color: Colors.black,
  //                     //     ),
  //                     //     softWrap: false,
  //                     //     maxLines: 1,
  //                     //     overflow: TextOverflow.ellipsis,
  //                     //   ),
  //                     // ),
  //                     SizedBox(
  //                       height: screenHeight * 0.005,
  //                     ),
  //                     // // // Last Booked Appointment Time
  //                     // Container(
  //                     //   child: Text(
  //                     //     '${tokenInfo.bookedTokenTime.format(context)}',
  //                     //     style: TextStyle(
  //                     //       fontSize: screenWidth * 0.0475,
  //                     //       fontWeight: FontWeight.w500,
  //                     //       color: Color.fromRGBO(114, 114, 114, 1),
  //                     //     ),
  //                     //     softWrap: false,
  //                     //     maxLines: 1,
  //                     //     overflow: TextOverflow.ellipsis,
  //                     //   ),
  //                     // ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: screenWidth * 0.0001,
  //               ),
  //               // Container(
  //               //   child: Expanded(
  //               //     child: Column(
  //               //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               //       crossAxisAlignment: CrossAxisAlignment.end,
  //               //       children: <Widget>[
  //               //         InkWell(
  //               //           onTap: () {
  //               //             _dateShowerInCalendar(
  //               //               context,
  //               //               tokenInfo.bookedTokenDate,
  //               //             );
  //               //           },
  //               //           child: Container(
  //               //             alignment: Alignment.topCenter,
  //               //             padding: EdgeInsets.symmetric(
  //               //               vertical: screenHeight * 0.0065,
  //               //             ),
  //               //             height: screenHeight * 0.05,
  //               //             width: screenHeight * 0.040,
  //               //             decoration: BoxDecoration(
  //               //                 // color: Color.fromRGBO(66, 204, 195, 1),
  //               //                 ),
  //               //             child: Image(
  //               //               fit: BoxFit.fill,
  //               //               image: AssetImage(
  //               //                 "assets/images/Calendar.png",
  //               //               ),
  //               //               color: Color.fromRGBO(108, 117, 125, 1),
  //               //             ),
  //               //           ),
  //               //         ),
  //               //         Container(
  //               //           width: screenWidth * 0.19,
  //               //           padding: EdgeInsets.symmetric(
  //               //             horizontal: screenWidth * 0.02,
  //               //             vertical: screenWidth * 0.01,
  //               //           ),
  //               //           decoration: BoxDecoration(
  //               //             borderRadius: BorderRadius.circular(6.5),
  //               //             color: Color.fromRGBO(66, 204, 195, 1),
  //               //           ),
  //               //           child: Text(
  //               //             "${DateFormat.MMMd().format(tokenInfo.bookedTokenDate).toString()}",
  //               //             style: TextStyle(
  //               //               color: Colors.white,
  //               //               fontWeight: FontWeight.bold,
  //               //             ),
  //               //             softWrap: false,
  //               //             maxLines: 1,
  //               //             overflow: TextOverflow.ellipsis,
  //               //             textAlign: TextAlign.center,
  //               //           ),
  //               //         ),
  //               //       ],
  //               //     ),
  //               //   ),
  //               // ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
