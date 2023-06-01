// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:doctor/screens/Tabs_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicinePrescribe {
  late String MedicineType;
  late String Tabletname;
  late String Remarks;

  late String FormofMedicine;
  late String Dosage;
  late String Strength;
  late bool isevening;
  late bool isdinner;
  late bool ismorning;
  late bool isafternoon;

  MedicinePrescribe({
    required this.FormofMedicine,
    required this.Tabletname,
    required this.Dosage,
    required this.isdinner,
    required this.isafternoon,
    required this.isevening,
    required this.ismorning,
    required this.Remarks,
    required this.MedicineType,
    required this.Strength,
  });
}
