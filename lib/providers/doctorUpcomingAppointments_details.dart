// ignore_for_file: use_build_context_synchronously, unnecessary_this, unnecessary_new, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unused_local_variable, avoid_print, unused_import, prefer_if_null_operators

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:doctor/models/token_info.dart';
import 'package:doctor/screens/My_Calendar_Screen/MyCalendar_Screen.dart';
import 'package:doctor/screens/Tabs_Screen.dart';
import 'package:doctor/screens/signup_Screens/SelectSignInSignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import './doctorFirebaseLinks_details.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/slot_info.dart';

class DoctorUpcomingAppointmentDetails with ChangeNotifier {
  List<BookedTokenSlotInformation> _items = [];
  List<BookedTokenSlotInformation> _itemsExpiredTokens = [];
  List<BookedTokenSlotInformation> _itemsCompleteTokens = [];
  late Future<ListResult> futureFiles;

  List<BookedTokenSlotInformation> get items {
    return [..._items];
  }

  List<BookedTokenSlotInformation> get getExpiredBookedTokens {
    return [..._itemsExpiredTokens];
  }

  List<BookedTokenSlotInformation> get getCompleteBookedTokens {
    return [..._itemsCompleteTokens];
  }

  Future<ListResult>? get previousPrescriptions {
    return futureFiles;
  }

  Future<void> fetchDoctorActiveUpcomingTokens(BuildContext context) async {
    // FirebaseFirestore db = FirebaseFirestore.instance;
    // CollectionReference usersRef =
    //     db.collection("PatientUsersPersonalInformation");

    // await FirebaseFirestore.instance
    //       .collection('DoctorUsersPersonalInformation')
    //       .doc(loggedInUserId)
    //       .get()
    //       .then(
    //     (DocumentSnapshot ds) {
    //       String doctor_ProfilePicUrl = "";
    //       doctor_ProfilePicUrl = ds.get('doctor_ProfilePicUrl').toString();
    //     },
    //   );

    var currLoggedInUser = FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLink1 = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/DoctorBookedAppointList/${loggedInUserId}.json');

    try {
      final dataBaseResponse1 = await http.get(urlLink1);
      final extractedClass1 = json.decode(dataBaseResponse1.body) as Map<String, dynamic>;

      if (extractedClass1.toString() != "null" && extractedClass1.isNotEmpty) {
        final List<BookedTokenSlotInformation> loadedPatientBookedTokens = [];
        final List<BookedTokenSlotInformation>
            loadedPatientExpiredBookedTokens = [];
        final List<BookedTokenSlotInformation>
            loadedPatientCompleteBookedTokens = [];

        extractedClass1.forEach(
          (tokenId1, tokenInfo1) async {
            BookedTokenSlotInformation availableToken = new BookedTokenSlotInformation(
              bookedTokenDate: DateTime.parse(tokenInfo1['appointmentDate']),
              bookedTokenTime: convertStringToTimeOfDay(tokenInfo1['appointmentTime']),
              doctor_AppointmentUniqueId: tokenInfo1['doctor_AppointmentUniqueId'],
              doctor_personalUniqueIdentificationId: tokenInfo1['doctor_personalUniqueIdentificationId'],
              isClinicAppointmentType: tokenInfo1['isClinicAppointmentType'] == "true",
              isVideoAppointmentType: tokenInfo1['isVideoAppointmentType'] == "true",
              isTokenActive: tokenInfo1['isTokenActive'] == "true",
              prescriptionUrl: tokenInfo1['prescriptionUrl'],
              registeredTokenId: tokenInfo1['registeredTokenId'],
              slotType: tokenInfo1['slotType'],
              registrationTiming: DateTime.parse(tokenInfo1['registrationTiming']),
              doctorFullName: tokenInfo1['doctorFullName'],
              doctorSpeciality: tokenInfo1['doctorSpeciality'],
              doctorImageUrl: tokenInfo1['doctorImageUrl'],
              patient_FullName: tokenInfo1['patientFullName'],
              patient_personalUniqueIdentificationId: tokenInfo1['patient_personalUniqueIdentificationId'],
              patient_ImageUrl: tokenInfo1['patientImageUrl'] == null
                  ? ""
                  : tokenInfo1['patientImageUrl'],
              patient_Allergies: tokenInfo1['patient_Allergies'],
              patient_BloodGroup: tokenInfo1['patient_BloodGroup'],
              patient_Gender: tokenInfo1['patient_Gender'],
              patient_Injuries: tokenInfo1['patient_Injuries'],
              patient_Medication: tokenInfo1['patient_Medication'],
              patient_Surgeries: tokenInfo1['patient_Surgeries'],
              patient_PhoneNumber: tokenInfo1['patient_PhoneNumber'],
              patientAilmentDescription: tokenInfo1['patientAilmentDescription'],
              patient_Age: checkIfInteger(tokenInfo1['patient_Age'].toString()),
              patient_Height: checkIfDouble(tokenInfo1['patient_Height'].toString()),
              patient_Weight: checkIfDouble(tokenInfo1['patient_Weight'].toString()),
              doctorTotalRatings: checkIfInteger(tokenInfo1['doctorTotalRatings'].toString()),
              testType: tokenInfo1['testType'],
              aurigaCareTestCenter: tokenInfo1['aurigaCareTestCenter'],
              testReportUrl: tokenInfo1['testReportUrl'],
              tokenFees: checkIfDouble(tokenInfo1['tokenFees'].toString()),
              givenPatientExperienceRating: checkIfDouble(tokenInfo1["givenPatientExperienceRating"].toString()),
            );

            // print(tokenInfo1['doctorTotalRatings'].toString());

            DateTime today = DateTime.now();
            if (availableToken.isTokenActive &&
                availableToken.bookedTokenDate
                        .add(Duration(days: 1))
                        .isBefore(today) ==
                    false) {
              if (availableToken.bookedTokenDate.day == today.day &&
                  availableToken.bookedTokenDate.month == today.month &&
                  availableToken.bookedTokenDate.year == today.year) {
                if (checkTokenSlotTimeValidity(
                    availableToken.bookedTokenTime)) {
                  loadedPatientBookedTokens.add(availableToken);
                } else {
                  loadedPatientExpiredBookedTokens.add(availableToken);
                }
              } else {
                loadedPatientBookedTokens.add(availableToken);
              }
            } else {
              loadedPatientExpiredBookedTokens.add(availableToken);
            }

            loadedPatientCompleteBookedTokens.add(availableToken);
          },
        );

        loadedPatientBookedTokens.sort(
          (a, b) {
            if (a.bookedTokenDate == b.bookedTokenDate) {
              int t1 = a.bookedTokenTime.hour * 60 + a.bookedTokenTime.minute;
              int t2 = b.bookedTokenTime.hour * 60 + b.bookedTokenTime.minute;
              return t1.compareTo(t2);
            } else {
              return a.bookedTokenDate.compareTo(b.bookedTokenDate);
            }
          },
        );

        loadedPatientExpiredBookedTokens.sort(
          (b, a) {
            if (a.bookedTokenDate == b.bookedTokenDate) {
              int t1 = a.bookedTokenTime.hour * 60 + a.bookedTokenTime.minute;
              int t2 = b.bookedTokenTime.hour * 60 + b.bookedTokenTime.minute;
              return t1.compareTo(t2);
            } else {
              return a.bookedTokenDate.compareTo(b.bookedTokenDate);
            }
          },
        );

        loadedPatientCompleteBookedTokens.sort(
          (b, a) {
            if (a.bookedTokenDate == b.bookedTokenDate) {
              int t1 = a.bookedTokenTime.hour * 60 + a.bookedTokenTime.minute;
              int t2 = b.bookedTokenTime.hour * 60 + b.bookedTokenTime.minute;
              return t1.compareTo(t2);
            } else {
              return a.bookedTokenDate.compareTo(b.bookedTokenDate);
            }
          },
        );

        _items = loadedPatientBookedTokens;
        _itemsCompleteTokens = loadedPatientCompleteBookedTokens;
        _itemsExpiredTokens = loadedPatientExpiredBookedTokens;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<void> cancelBookedAppointment(
    BuildContext context,
    BookedTokenSlotInformation tokenInfo,
  ) async {
    var currLoggedInUser = FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    // String patientSideUrl = "PatientBookedAppointList/${tokenInfo.patient_personalUniqueIdentificationId}/${tokenInfo.registeredTokenId}";
    // String doctorSideUrl = "DoctorBookedAppointList/${tokenInfo.doctor_personalUniqueIdentificationId}/${tokenInfo.registeredTokenId}";

    String patientSideUrl =
        "PatientBookedAppointList/${tokenInfo.patient_personalUniqueIdentificationId}/${tokenInfo.registeredTokenId}";
    String doctorSideUrl =
        "DoctorBookedAppointList/${tokenInfo.doctor_personalUniqueIdentificationId}/${tokenInfo.registeredTokenId}";

    Uri patientUrlLink = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/${patientSideUrl}.json');

    Uri doctorUrlLink = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/${doctorSideUrl}.json');

    String aptDate =
        "${tokenInfo.bookedTokenDate.day}-${tokenInfo.bookedTokenDate.month}-${tokenInfo.bookedTokenDate.year}";
    String statusUrl =
        "AppointmentStatusDetails/${tokenInfo.doctor_AppointmentUniqueId}/${aptDate}/${tokenInfo.bookedTokenTime.toString()}";

    // // used in creating our own value of the "key"
    DatabaseReference mDatabase = FirebaseDatabase.instance.ref();

    try {
      mDatabase
          .child("AppointmentStatusDetails")
          .child("${tokenInfo.doctor_AppointmentUniqueId}")
          .child("${aptDate}")
          .child("${tokenInfo.bookedTokenTime.toString()}")
          .remove();

      mDatabase
          .child("DoctorBookedAppointList")
          .child("${tokenInfo.doctor_personalUniqueIdentificationId}")
          .child("${tokenInfo.registeredTokenId}")
          .update({"isTokenActive": "false"})
          .then(
        (value) {
          mDatabase
              .child("PatientBookedAppointList")
              .child("${tokenInfo.patient_personalUniqueIdentificationId}")
              .child("${tokenInfo.registeredTokenId}")
              .update({"isTokenActive": "false"})
              .then(
            (value) {
              mDatabase
                  .child("AppointmentStatusDetails")
                  .child("${tokenInfo.doctor_AppointmentUniqueId}")
                  .child("${aptDate}")
                  .child("${tokenInfo.bookedTokenTime.toString()}")
                  .remove()
                  .then((value) {
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     TabsScreenDoctor.routeName, (route) => false);
                notifyListeners();
              });
            },
          );
        },
      );
    } catch (errorVal) {
      print("Error while deleting the status of appointment");
      print(errorVal);
    }
  }

  Future<void> uploadDoctorPrescriptionForPatient(
    BuildContext context,
    BookedTokenSlotInformation tokenInfo,
    String documentType,
    File documentPdfFile,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef =
        db.collection("DoctorUsersPersonalInformation");

    var currLoggedInUser = FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    String aptDate = "${tokenInfo.bookedTokenDate.day}-${tokenInfo.bookedTokenDate.month}-${tokenInfo.bookedTokenDate.year}";
    String aptTime = tokenInfo.bookedTokenTime.toString();
    String refLink = "PatientReportsAndPrescriptionsDetails/${tokenInfo.patient_personalUniqueIdentificationId}/${tokenInfo.doctor_personalUniqueIdentificationId}/${tokenInfo.doctor_AppointmentUniqueId}/${aptDate}/${aptTime}/DoctorPrescription";

    Uri urlLinkForPatientRepAndPres = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/PatientReportsAndPrescriptionsDetails/${tokenInfo.patient_personalUniqueIdentificationId}/${tokenInfo.doctor_personalUniqueIdentificationId}/${tokenInfo.doctor_AppointmentUniqueId}/${aptDate}/${aptTime}/DoctorPrescription.json');

    String documentFileName = "${aptDate}_${aptTime}_${documentType}.pdf";
    final documentFile = FirebaseStorage.instance
        .ref()
        .child('${refLink}')
        .child(documentFileName);
  }

  bool checkTokenExpiryDate(
    DateTime expiredDateTime,
    TimeOfDay bookedTimeSlot,
  ) {
    var currTime = DateTime.now();
    if (expiredDateTime.day == currTime.day &&
        expiredDateTime.month == currTime.month &&
        expiredDateTime.year == currTime.year) {
      int currMin = DateTime.now().hour * 60 + DateTime.now().minute;
      int slotMin = bookedTimeSlot.hour * 60 + bookedTimeSlot.minute + 10;

      if (currMin <= slotMin) {
        return true;
      } else {
        return false;
      }
    } else {
      DateTime presentDateTime = DateTime.utc(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);

      bool chk =
          presentDateTime.isBefore(expiredDateTime.add(Duration(days: 1)));

      if (chk) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool checkTokenSlotTimeValidity(TimeOfDay bookedTimeSlot) {
    int currMin = DateTime.now().hour * 60 + DateTime.now().minute;
    int slotMin = bookedTimeSlot.hour * 60 + bookedTimeSlot.minute + 45;

    if (currMin <= slotMin) {
      return true;
    } else {
      return false;
    }
  }

  bool checkTokenSlotDateValidity(DateTime expiredDateTime) {
    DateTime presentDateTime = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);

    bool chk =
        presentDateTime.isBefore(expiredDateTime.add(new Duration(days: 1)));

    if (chk) {
      return true;
    } else {
      return false;
    }
  }

  TimeOfDay convertStringToTimeOfDay(String givenTime) {
    int hrVal = int.parse(givenTime.split(":")[0].substring(10));
    int minVal = int.parse(givenTime.split(":")[1].substring(0, 2));
    TimeOfDay time = TimeOfDay(hour: hrVal, minute: minVal);

    return time;
  }

  String convertTimeOfDayToStringTime(TimeOfDay slotTime) {
    String givenTime = slotTime.toString();
    String ans = givenTime.split("(")[1].substring(10, givenTime.length - 1);
    String ansFmt = "${ans.split(":")[0]}-${ans.split(":")[1]}";

    return ansFmt;
  }

  int checkIfInteger(String val) {
    if (val == 'null' || val == '' || int.tryParse(val).toString() == 'null') {
      return 0;
    } else {
      return int.parse(val);
    }
  }

  double checkIfDouble(String val) {
    if (double.tryParse(val).toString() != 'null') {
      return double.parse(val);
    } else if (val == 'null' ||
        val == '' ||
        int.tryParse(val).toString() == 'null' ||
        double.tryParse(val).toString() == 'null') {
      return 0.0;
    } else {
      return double.parse(val);
    }
  }
}
