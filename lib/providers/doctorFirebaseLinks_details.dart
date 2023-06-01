// ignore_for_file: unnecessary_this, unused_import, unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorFirebaseDetails with ChangeNotifier {
  // String firebaseUrlInUse = "aurigacarehealthapplication-default-rtdb.firebaseio.com";
  String firebaseUrlInUse = "aurigacare-dpapplication-default-rtdb.firebaseio.com";
  String cloudServerToken = "AAAAJf9Zzxw:APA91bG2byLOz03IcaNF5kfF9jeEj9hudr-VbWCNfBBuGdi6GYToR_rutgKIynxNfeNjKzSBC2JFMZ1xX_e6wVBgL-5yihEtdxcMWMshW8fggjQRxyBuR5QabafIUBpC3iAA9gpHxzSG";

  String getFirebaseUrl() {
    return firebaseUrlInUse;
  }

  Uri getFirebasePathUrl(String pathLocation) {
    Uri url = Uri.https(
      '${firebaseUrlInUse}',
      '${pathLocation}',
    );

    return url;
  }
}