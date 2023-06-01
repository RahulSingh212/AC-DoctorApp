// ignore_for_file: unnecessary_this, unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './doctorFirebaseLinks_details.dart';


class DoctorAuthDetails with ChangeNotifier {
  // checkEntryType == true, sign-in
  // checkEntryType == false, sign-up
  bool checkEntryType = true;

  setEntryType(bool entryType) {
    this.checkEntryType = entryType;
  }
  bool getEntryType() {
    return this.checkEntryType;
  }



  List<String> existingDoctorsPhoneNumberList = [];

  List<String> get getDoctorPhoneNumberList {
    return [...this.existingDoctorsPhoneNumberList];
  }

  bool get isDoctorsPhoneNumberListEmpty {
    if (this.existingDoctorsPhoneNumberList.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getExistingDoctorsUserPhoneNumbers(BuildContext context) async {

    Uri urlLink = Provider.of<DoctorFirebaseDetails>(context, listen: false).getFirebasePathUrl('/DoctorsUserPhoneNumberList.json');

    try {
      final dataBaseResponse = await http.get(urlLink);
      final extractedUserPhoneNumbers = json.decode(dataBaseResponse.body) as Map<String, dynamic>;

      if (extractedUserPhoneNumbers.toString() != "null" && extractedUserPhoneNumbers.length !=
          this.existingDoctorsPhoneNumberList.length) {
        final List<String> phoneNumberList = [];
        extractedUserPhoneNumbers.forEach(
          (phoneId, phoneData) {
            phoneNumberList.add(phoneData['doctor_PhoneNumber']);
          },
        );

        existingDoctorsPhoneNumberList = phoneNumberList;
        notifyListeners();
      }
    } catch (errorVal) {
      print("Error Value");
      print(errorVal);
    }
  }

  Future<bool> checkIfEnteredNumberExists(
    BuildContext context,
    TextEditingController userPhoneNumber,
  ) async {
    String enteredNumber = userPhoneNumber.text.toString();

    if (this.existingDoctorsPhoneNumberList.isEmpty) {
      return false;
    }
    else {
      bool isUserPresent = false;

      bool checkForResponse = await Future.forEach(
        this.existingDoctorsPhoneNumberList,
        (phoneNum) {
          if (!isUserPresent && phoneNum.toString() == enteredNumber) {
            isUserPresent = true;
            return true;
          }
        },
      ).then((value) {
        return isUserPresent;
      });

      return checkForResponse;
    }
  }

}