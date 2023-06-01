// ignore_for_file: use_build_context_synchronously, unnecessary_this, unnecessary_new, prefer_const_constructors, unnecessary_brace_in_string_interps, unused_local_variable, unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/screens/My_Calendar_Screen/MyCalendar_Screen.dart';
import 'package:doctor/screens/Tabs_Screen.dart';
import 'package:doctor/screens/signup_Screens/SelectSignInSignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import './doctorFirebaseLinks_details.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/slot_info.dart';
import '../models/docPat_info.dart';

class DoctorPatientDetails with ChangeNotifier {
  Set<String> prevPatientSet = {};
  Set<String> activePatientSet = {};
  List<DoctorPreviousPatientInformation> _itemsPreviousPatients = [];
  List<DoctorPreviousPatientInformation> _itemsActiveAppointmentPatients = [];

  List<DoctorPreviousPatientInformation> get items {
    return [..._itemsPreviousPatients];
  }

  List<DoctorPreviousPatientInformation> get itemsActivePatients {
    return [..._itemsActiveAppointmentPatients];
  }

  Future<void> fetchDoctorPreviousPatients(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLink = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl("/DoctorPatientDetails/${loggedInUserId}.json");

    bool isAdded = false;
    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedPatientInfo =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      final List<DoctorPreviousPatientInformation> loadedPreviousPatientList =
          [];
      final List<DoctorPreviousPatientInformation> loadedActivePatientList = [];

      if (extractedPatientInfo.toString() != 'null' &&
          extractedPatientInfo.isNotEmpty) {
        // final List<DoctorPreviousPatientInformation> loadedPreviousPatientList = [];
        // final List<DoctorPreviousPatientInformation> loadedActivePatientList = [];

        // DoctorPreviousPatientInformation prevPatient;

        var res = extractedPatientInfo
            .forEach((patientUniqueId, pattientMapping) async {
          DateTime lastBookedDate = DateTime.parse(
              pattientMapping['patient_LastBookedAppointmentDate']);
          TimeOfDay lastBookedTime = convertStringToTimeOfDay(
              pattientMapping['patient_LastBookedAppointmentTime']);

          FirebaseFirestore db = FirebaseFirestore.instance;
          CollectionReference usersRef =
              db.collection("PatientUsersPersonalInformation");

          // DoctorPreviousPatientInformation prevPatient;
          var response = await FirebaseFirestore.instance
              .collection('PatientUsersPersonalInformation')
              .doc(patientUniqueId)
              .get()
              .then((DocumentSnapshot ds) {
            DoctorPreviousPatientInformation prevPatient =
                new DoctorPreviousPatientInformation(
              patient_LastBookedAppointmentDate: lastBookedDate,
              patient_LastBookedAppointmentTime: lastBookedTime,
              patient_personalUniqueIdentificationId: patientUniqueId,
              patient_FullName: ds.get('patient_FullName').toString(),
              patient_ImageUrl: ds.get('patient_ProfilePicUrl'),
              patient_Allergies: ds.get('patient_Allergies').toString(),
              patient_BloodGroup: ds.get('patient_BloodGroup').toString(),
              patient_Gender: ds.get('patient_Gender').toString(),
              patient_Injuries: ds.get('patient_Allergies').toString(),
              patient_Medication: ds.get('patient_Medication').toString(),
              patient_Surgeries: ds.get('patient_Surgeries').toString(),
              patient_PhoneNumber: ds.get('patient_PhoneNumber').toString(),
              patient_Age: checkIfInteger(ds.get('patient_Age').toString()),
              patient_Height:
                  checkIfDouble(ds.get('patient_Height').toString()),
              patient_Weight:
                  checkIfDouble(ds.get('patient_Weight').toString()),
            );
            loadedPreviousPatientList.add(prevPatient);

            if (prevPatientSet.contains(
                    prevPatient.patient_personalUniqueIdentificationId) ==
                false) {
              prevPatientSet
                  .add(prevPatient.patient_personalUniqueIdentificationId);
              this._itemsPreviousPatients.add(prevPatient);
              notifyListeners();
            }

            DateTime today = DateTime.now();
            if (prevPatient.patient_LastBookedAppointmentDate
                    .add(Duration(days: 1))
                    .isBefore(today) ==
                false) {
              if (prevPatient.patient_LastBookedAppointmentDate.day ==
                      today.day &&
                  prevPatient.patient_LastBookedAppointmentDate.month ==
                      today.month &&
                  prevPatient.patient_LastBookedAppointmentDate.year ==
                      today.year) {
                if (activePatientSet.contains(prevPatient
                            .patient_personalUniqueIdentificationId) ==
                        false &&
                    checkTokenSlotTimeValidity(
                        prevPatient.patient_LastBookedAppointmentTime)) {
                  // Replace with patient on application button when added checking of active patient on the app
                  activePatientSet
                      .add(prevPatient.patient_personalUniqueIdentificationId);
                  this._itemsActiveAppointmentPatients.add(prevPatient);
                  notifyListeners();
                }
              } else if (activePatientSet.contains(
                      prevPatient.patient_personalUniqueIdentificationId) ==
                  false) {
                // Replace with patient on application button when added checking of active patient on the app
                activePatientSet
                    .add(prevPatient.patient_personalUniqueIdentificationId);
                this._itemsActiveAppointmentPatients.add(prevPatient);
                notifyListeners();
              }
            }
          });
        });
      }

      // print(this._itemsActiveAppointmentPatients.length);
      // print(this._itemsPreviousPatients.length);
    } catch (errorVal) {
      print(errorVal);
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

  TimeOfDay convertStringToTimeOfDay(String givenTime) {
    int hrVal = int.parse(givenTime.split(":")[0].substring(10));
    int minVal = int.parse(givenTime.split(":")[1].substring(0, 2));
    TimeOfDay time = TimeOfDay(hour: hrVal, minute: minVal);

    return time;
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
