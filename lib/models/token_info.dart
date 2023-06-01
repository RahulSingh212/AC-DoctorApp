// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookedTokenSlotInformation {
  final DateTime bookedTokenDate;
  final TimeOfDay bookedTokenTime;
  final String doctor_AppointmentUniqueId;
  final String doctor_personalUniqueIdentificationId;
  final bool isClinicAppointmentType;
  final bool isVideoAppointmentType;
  final bool isTokenActive;
  final String prescriptionUrl;
  final String registeredTokenId;
  final DateTime registrationTiming;
  final String doctorFullName;
  final String doctorSpeciality;
  final String doctorImageUrl;
  final int doctorTotalRatings;
  final String slotType;

  final String testType;
  final String aurigaCareTestCenter;
  final String testReportUrl;
  final double tokenFees;

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
  final String patientAilmentDescription;
  final double givenPatientExperienceRating;

  BookedTokenSlotInformation({
    required this.bookedTokenDate,
    required this.bookedTokenTime,
    required this.doctor_AppointmentUniqueId,
    required this.doctor_personalUniqueIdentificationId,
    required this.isClinicAppointmentType,
    required this.isVideoAppointmentType,
    required this.isTokenActive,
    required this.prescriptionUrl,
    required this.registeredTokenId,
    required this.slotType,
    required this.registrationTiming,
    required this.doctorFullName,
    required this.doctorSpeciality,
    required this.doctorImageUrl,
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
    required this.patientAilmentDescription,
    required this.givenPatientExperienceRating,
    required this.doctorTotalRatings,
    required this.testType,
    required this.aurigaCareTestCenter,
    required this.testReportUrl,
    required this.tokenFees,
  });
}
