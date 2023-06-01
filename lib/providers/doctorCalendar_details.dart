// ignore_for_file: use_build_context_synchronously, unnecessary_this, unnecessary_new, prefer_const_constructors, unnecessary_brace_in_string_interps, unused_import, unused_local_variable

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
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './doctorFirebaseLinks_details.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/slot_info.dart';
import './doctorFirebaseLinks_details.dart';

class DoctorCalendarDetails with ChangeNotifier {
  List<DoctorSlotInformation> _items = [];

  List<DoctorSlotInformation> get items {
    return [..._items];
  }

  Future<void> clearDoctorAvailableSlotDetails(BuildContext context) async {
    this._items = [];
  }

  Future<void> addNewAppointmentSlot(
    BuildContext context,
    DoctorSlotInformation slotInfo,
  ) 
  async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("DoctorUsersPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLink = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/DoctorAvailableSlots/${loggedInUserId}.json');

    try {
      String repeatDay = "";
      for (var i = 0; i < 7; i++) {
        if (slotInfo.repeatWeekDaysList[i] == true) {
          repeatDay += "1";
        } else {
          repeatDay += "0";
        }
      }
      final responseForPartialClassDetails = await http
          .post(
        urlLink,
        body: json.encode(
          {
            'slotUniqueId': slotInfo.slotUniqueId.toString(),
            'isClinicAvailable': slotInfo.isClinic.toString(),
            'isVideoAvailable': slotInfo.isVideo.toString(),
            'slotRegistrationDate': slotInfo.registeredDate.toString(),
            'slotExpiryDate': slotInfo.expiredDate.toString(),
            'slotStartTime': slotInfo.startTime.toString(),
            'slotEndTime': slotInfo.endTime.toString(),
            'isSlotRepeated': slotInfo.isRepeat.toString(),
            'repeatDaysOfTheWeek': repeatDay.toString(),
            'isDoctorSlotActive': slotInfo.isSlotActive.toString(),
            'patientSlotDuration': slotInfo.patientSlotIntervalDuration.toString(),
            'maximumNumberOfSlots': slotInfo.maximumNumberOfSlots.toString(),
            'appointFeePerPatient': slotInfo.appointmentFeesPerPatient.toString(),
          },
        ),
      )
          .then((savedResponse) async {
        Uri urlLinkForUpdate = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/DoctorAvailableSlots/${loggedInUserId}/${json.decode(savedResponse.body)["name"]}.json');
        
        final responseUpdateSlotDetails = await http.patch(
          urlLinkForUpdate,
          body: json.encode(
            {
              'slotUniqueId': json.decode(savedResponse.body)["name"].toString(),
            },
          ),
        );
        
      });

      // _items.add(classInfo);
      notifyListeners();
      Navigator.of(context).pushNamedAndRemoveUntil(
          TabsScreenDoctor.routeName, (route) => false);
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> fetchDoctorAvailableSlots(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLink = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/DoctorAvailableSlots/${loggedInUserId}.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass = json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass != Null && extractedClass.toString() != null) {
        final List<DoctorSlotInformation> loadedAvailableDoctorSlots = [];

        extractedClass.forEach(
          (slotId, slotInfo) async {
            DoctorSlotInformation availableSlot = new DoctorSlotInformation(
              slotUniqueId: slotId,
              isClinic: slotInfo['isClinicAvailable'].toString().toLowerCase() == 'true',
              isVideo: slotInfo['isVideoAvailable'].toString().toLowerCase() == 'true',
              registeredDate: DateTime.parse(slotInfo['slotRegistrationDate']),
              expiredDate: DateTime.parse(slotInfo['slotExpiryDate']),
              startTime: convertStringToTimeOfDay(slotInfo['slotStartTime']),
              endTime: convertStringToTimeOfDay(slotInfo['slotEndTime']),
              isRepeat: slotInfo['isSlotRepeated'].toString().toLowerCase() == 'true',
              repeatWeekDaysList: convertStringToListOfBoolWeekDays(slotInfo['repeatDaysOfTheWeek']),
              isSlotActive: slotInfo['isDoctorSlotActive'].toString().toLowerCase() == 'true',
              patientSlotIntervalDuration: Duration(
                  hours:
                      int.parse(slotInfo['patientSlotDuration'].split(":")[0]),
                  minutes:
                      int.parse(slotInfo['patientSlotDuration'].split(":")[1])),
              maximumNumberOfSlots: int.parse(slotInfo['maximumNumberOfSlots']),
              appointmentFeesPerPatient:
                  double.parse(slotInfo['appointFeePerPatient']),
            );

            if (slotInfo['isSlotRepeated'].toString().toLowerCase() == 'true' ||
                checkAppointmentSlotValidity(availableSlot.expiredDate)) {
              loadedAvailableDoctorSlots.add(availableSlot);
            }
          },
        );

        loadedAvailableDoctorSlots.sort((a, b) {
          return b.registeredDate.compareTo(a.registeredDate);
        });
        _items = loadedAvailableDoctorSlots;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<void> upDateAppointmentSlot(
    BuildContext context,
    DoctorSlotInformation slotInfo,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("DoctorAvailableSlots");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLink = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/DoctorAvailableSlots/${loggedInUserId}/${slotInfo.slotUniqueId}.json');

    try {
      String repeatDay = "";
      for (var i = 0; i < 7; i++) {
        if (slotInfo.repeatWeekDaysList[i] == true) {
          repeatDay += "1";
        } else {
          repeatDay += "0";
        }
      }

      final slotIdx = _items.indexWhere(
          (slotDetails) => slotDetails.slotUniqueId == slotInfo.slotUniqueId);
      var previousSlotDetails = _items[slotIdx];
      _items[slotIdx] = slotInfo;

      final responseUpdateSlotDetails = await http
          .patch(
        urlLink,
        body: json.encode(
          {
            'slotUniqueId': slotInfo.slotUniqueId.toString(),
            'isClinicAvailable': slotInfo.isClinic.toString(),
            'isVideoAvailable': slotInfo.isVideo.toString(),
            'slotRegistrationDate': slotInfo.registeredDate.toString(),
            'slotExpiryDate': slotInfo.expiredDate.toString(),
            'slotStartTime': slotInfo.startTime.toString(),
            'slotEndTime': slotInfo.endTime.toString(),
            'isSlotRepeated': slotInfo.isRepeat.toString(),
            'repeatDaysOfTheWeek': repeatDay.toString(),
            'isDoctorSlotActive': slotInfo.isSlotActive.toString(),
            'patientSlotDuration': slotInfo.patientSlotIntervalDuration.toString(),
            'maximumNumberOfSlots': slotInfo.maximumNumberOfSlots.toString(),
            'appointFeePerPatient': slotInfo.appointmentFeesPerPatient.toString(),
          },
        ),
      )
          .then((_) {
        previousSlotDetails = Null as DoctorSlotInformation;
      }).catchError((_) {
        _items[slotIdx] = previousSlotDetails;
      });

      notifyListeners();
      Navigator.of(context).pushNamedAndRemoveUntil(
          TabsScreenDoctor.routeName, (route) => false);
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> deleteAppointmentSlot(
    BuildContext context,
    String slotId,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("DoctorAvailableSlots");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLink = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/DoctorAvailableSlots/${loggedInUserId}/${slotId}.json');

    try {
      final slotIdx = _items
          .indexWhere((slotDetails) => slotDetails.slotUniqueId == slotId);
      DoctorSlotInformation deletedSlotDetails = _items[slotIdx];
      _items.removeAt(slotIdx);

      final responseDeleteSlotDetails = await http.delete(urlLink).then((_) {
        // deletedSlotDetails = Null as DoctorSlotInformation;
      }).catchError((_) {
        _items.insert(slotIdx, deletedSlotDetails);
      });

      notifyListeners();
      Navigator.of(context).pushNamedAndRemoveUntil(
          TabsScreenDoctor.routeName, (route) => false);
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> removeExpiredAppointmentsSlots(BuildContext context) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("userPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLink = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/DoctorAvailableSlots/${loggedInUserId}.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedClass =
          json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedClass != Null) {
        extractedClass.forEach(
          (slotId, slotInfo) async {
            // DoctorSlotInformation availableSlot = new DoctorSlotInformation(

            if (slotInfo['isSlotRepeated'].toString().toLowerCase() ==
                    'false' &&
                DateTime.now().isAfter(DateTime.parse(slotInfo['slotExpiryDate']))) {
              Uri expiredAppointmentSlotLink = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/DoctorAvailableSlots/${loggedInUserId}/${slotId}.json');

              final responseDeleteSlotDetails = await http.delete(expiredAppointmentSlotLink);
            }
          },
        );
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }

    // final responseDeleteSlotDetails = await http.delete(urlLink);
  }

  bool checkAppointmentSlotValidity(DateTime expiredDateTime) {
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

  List<bool> convertStringToListOfBoolWeekDays(String bitVal) {
    List<bool> weekDaySelected = List.filled(7, false);

    for (var i = 0; i < 7; i++) {
      if (bitVal[i] == '1') {
        weekDaySelected[i] = true;
      }
    }

    return weekDaySelected;
  }

  TimeOfDay convertStringToTimeOfDay(String givenTime) {
    int hrVal = int.parse(givenTime.split(":")[0].substring(10));
    int minVal = int.parse(givenTime.split(":")[1].substring(0, 2));
    TimeOfDay time = TimeOfDay(hour: hrVal, minute: minVal);

    return time;
  }
}
