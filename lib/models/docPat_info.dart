// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:doctor/screens/Tabs_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorPreviousPatientInformation {
  final DateTime patient_LastBookedAppointmentDate;
  final TimeOfDay patient_LastBookedAppointmentTime;

  final String patient_personalUniqueIdentificationId;
  final String patient_FullName;
  final String patient_ImageUrl;
  final String patient_Allergies;
  final String patient_BloodGroup;
  final String patient_Gender;
  final String patient_Injuries;
  final String patient_Medication;
  final String patient_Surgeries;
  final String patient_PhoneNumber;
  final int patient_Age;
  final double patient_Height;
  final double patient_Weight;

  DoctorPreviousPatientInformation({
    required this.patient_LastBookedAppointmentDate,
    required this.patient_LastBookedAppointmentTime,
    required this.patient_personalUniqueIdentificationId,
    required this.patient_FullName,
    required this.patient_ImageUrl,
    required this.patient_Allergies,
    required this.patient_BloodGroup,
    required this.patient_Gender,
    required this.patient_Injuries,
    required this.patient_Medication,
    required this.patient_Surgeries,
    required this.patient_PhoneNumber,
    required this.patient_Age,
    required this.patient_Height,
    required this.patient_Weight,
  });
}
