// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names, unnecessary_import, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace, avoid_unnecessary_containers, sort_child_properties_last, unused_import, duplicate_import, unused_local_variable, must_be_immutable

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:doctor/providers/doctorPatient_details.dart';
import 'package:doctor/screens/My_Patients_Screen/PreviousPatientDetail_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/docPat_info.dart';
import '../../providers/doctorAuth_details.dart';
import '../../providers/doctorUser_details.dart';

class MyPatients_PatientSectionTab extends StatefulWidget {
  static const routeName = '/doctor-my-patients-patients-section-tab';

  @override
  State<MyPatients_PatientSectionTab> createState() =>
      _MyPatients_PatientSectionTabState();
}

class _MyPatients_PatientSectionTabState
    extends State<MyPatients_PatientSectionTab> {
  bool isLangEnglish = true;

  String name3 = "Ankita Sharma";
  String ailment = "Dust Allergy ,Mirago 50mg..";
  int number = 2;
  int number1 = 1;
  String search = "lololl";

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
    var useableHeight =
        max(screenHeight, screenWidth) - topInsets - bottomInsets;
    double width = (MediaQuery.of(context).size.width);
    double height = (MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: const Color(0xFFf2f3f4),
      body: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       suffixIcon: Container(
          //         padding: const EdgeInsets.only(
          //           top: 5,
          //           left: 20,
          //           right: 20,
          //         ),
          //         height: 39,
          //         width: min(screenHeight, screenWidth) * 0.25,
          //         child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(10.0),
          //               ),
          //               primary: const Color(0xff42ccc3),
          //             ),
          //             onPressed: () {},
          //             child: const Icon(
          //               Icons.search,
          //               color: Colors.white,
          //               size: 35,
          //             )),
          //       ),
          //       filled: true,
          //       fillColor: Colors.white,
          //       border: OutlineInputBorder(
          //         borderSide: BorderSide.none,
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       labelText: isLangEnglish ? 'Search' : "खोज",
          //       hintText: isLangEnglish
          //           ? 'Type the name you want to Search '
          //           : "वह नाम टाइप करें जिसे आप खोजना चाहते हैं",
          //     ),
          //     onChanged: (text) {
          //       search = text;
          //     },
          //   ),
          // ),
          // SizedBox(
          //   height: screenHeight * 0.01,
          // ),
          Provider.of<DoctorPatientDetails>(context, listen: false)
                  .items
                  .isEmpty
              ? Container(
                  margin: EdgeInsets.only(
                    top: screenHeight * 0.025,
                  ),
                  child: Align(
                    child: Card(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.6,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.075,
                          vertical: screenHeight * 0.025,
                        ),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(25),
                        //   color: Colors.white70,
                        // ),
                        child: Text(
                          isLangEnglish
                              ? "\"No record of the patients available\""
                              : "\"मरीजों का कोई रिकॉर्ड उपलब्ध नहीं\"",
                          style: TextStyle(
                            color: Color.fromRGBO(196, 207, 238, 1),
                            fontSize: min(screenHeight, screenWidth) * 0.065,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              : Align(
                  child: Container(
                    // height: useableHeight * 0.635,
                    height: useableHeight * 0.75,
                    width: screenWidth * 0.95,
                    child: ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: Provider.of<DoctorPatientDetails>(context,
                              listen: false)
                          .items
                          .length,
                      itemBuilder: (ctx, index) {
                        return previousPatientWidget(
                          context,
                          Provider.of<DoctorPatientDetails>(context,
                                  listen: false)
                              .items[index],
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget previousPatientWidget(
    BuildContext context,
    DoctorPreviousPatientInformation prevPatientInfo,
  ) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PreviousPatientDetailScreen(
              0,
              prevPatientInfo,
            ),
          ),
        );
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => PatientAppointmentInformationScreen(
        //       0,
        //       tokenInfo,
        //     ),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.only(
          top: screenHeight * 0.01,
        ),
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
              horizontal: screenWidth * 0.025,
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                  margin: EdgeInsets.only(
                    right: min(screenWidth, screenHeight) * 0.02,
                  ),
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
                      child: prevPatientInfo.patient_ImageUrl == ""
                          ? Image.asset(
                              'assets/images/healthy.png',
                              fit: BoxFit.fill,
                              width: screenWidth * 0.2,
                            )
                          : Image.network(
                              prevPatientInfo.patient_ImageUrl,
                              fit: BoxFit.fill,
                              width: screenWidth * 0.2,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.03,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // // Name of the Paitent
                      Container(
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              TextSpan(
                                text: '${prevPatientInfo.patient_FullName}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      min(screenWidth, screenHeight) * 0.0525,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Text(
                        //   '${prevPatientInfo.patient_FullName}',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: screenWidth * 0.0525,
                        //     color: Colors.black,
                        //   ),
                        //   softWrap: false,
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      // // // Last Booked Appointment Date
                      Container(
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: isLangEnglish
                                    ? 'Last Appointment booked on:\n'
                                    : "अंतिम अपॉइंटमेंट बुक किया गया था:\n",
                                style: TextStyle(
                                  fontSize:
                                      min(screenWidth, screenHeight) * 0.03,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: isLangEnglish ? 'Date:  ' : "दिनांक:  ",
                                style: TextStyle(
                                  fontSize:
                                      min(screenWidth, screenHeight) * 0.035,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${DateFormat.yMMMd().format(prevPatientInfo.patient_LastBookedAppointmentDate).toString()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(114, 114, 114, 1),
                                  fontSize:
                                      min(screenWidth, screenHeight) * 0.0475,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextSpan(
                                text: isLangEnglish ? '\nTime:  ' : "\nसमय:  ",
                                style: TextStyle(
                                  fontSize:
                                      min(screenWidth, screenHeight) * 0.035,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${prevPatientInfo.patient_LastBookedAppointmentTime.format(context)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(114, 114, 114, 1),
                                  fontSize:
                                      min(screenWidth, screenHeight) * 0.0475,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // child: Text(
                        //   '${DateFormat.MMMd().format(prevPatientInfo.patient_LastBookedAppointmentDate).toString()}',
                        //   style: TextStyle(
                        //     fontSize: screenWidth * 0.0475,
                        //     fontWeight: FontWeight.w500,
                        //     color: Color.fromRGBO(114, 114, 114, 1),
                        //   ),
                        //   softWrap: false,
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.0001,
                ),
                // Container(
                //   child: Expanded(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: <Widget>[
                //         InkWell(
                //           onTap: () {
                //             _dateShowerInCalendar(
                //               context,
                //               tokenInfo.bookedTokenDate,
                //             );
                //           },
                //           child: Container(
                //             alignment: Alignment.topCenter,
                //             padding: EdgeInsets.symmetric(
                //               vertical: screenHeight * 0.0065,
                //             ),
                //             height: screenHeight * 0.05,
                //             width: screenHeight * 0.040,
                //             decoration: BoxDecoration(
                //                 // color: Color.fromRGBO(66, 204, 195, 1),
                //                 ),
                //             child: Image(
                //               fit: BoxFit.fill,
                //               image: AssetImage(
                //                 "assets/images/Calendar.png",
                //               ),
                //               color: Color.fromRGBO(108, 117, 125, 1),
                //             ),
                //           ),
                //         ),
                //         Container(
                //           width: screenWidth * 0.19,
                //           padding: EdgeInsets.symmetric(
                //             horizontal: screenWidth * 0.02,
                //             vertical: screenWidth * 0.01,
                //           ),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(6.5),
                //             color: Color.fromRGBO(66, 204, 195, 1),
                //           ),
                //           child: Text(
                //             "${DateFormat.MMMd().format(tokenInfo.bookedTokenDate).toString()}",
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontWeight: FontWeight.bold,
                //             ),
                //             softWrap: false,
                //             maxLines: 1,
                //             overflow: TextOverflow.ellipsis,
                //             textAlign: TextAlign.center,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
