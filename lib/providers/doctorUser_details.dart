// ignore_for_file: use_build_context_synchronously, unnecessary_this, unused_local_variable, non_constant_identifier_names, unused_import, duplicate_import, dead_code

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/screens/Tabs_Screen.dart';
import 'package:doctor/screens/signup_Screens/SelectSignInSignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import './doctorFirebaseLinks_details.dart';

class DoctorUserDetails with ChangeNotifier {
  Map<String, String> mp = {};
  String loggedInDoctorUserUniqueCred = "";
  var doctor_LanguageType = true; // English: true, Hindi: false
  bool isReadingLangEnglish = true;
  String mobileMessagingToken = "";
  String messagingTokenName = "aurigaCare";

  setDoctorLanguageType(bool isEnglish) {
    this.doctor_LanguageType = isEnglish;
    print(doctor_LanguageType);
  }

  bool getDoctorLanguageType() {
    print(doctor_LanguageType);
    return this.doctor_LanguageType;
  }

  setDoctorUserPersonalInformation(Map<String, String> doctorMap) {
    this.mp = doctorMap;
  }

  Map<String, String> getDoctorUserPersonalInformation() {
    return mp;
  }

  String getLoggedInUserUniqueId() {
    return this.loggedInDoctorUserUniqueCred;
  }

  late TextEditingController doctorFullName;
  late TextEditingController doctorFirstName;
  late TextEditingController doctorLastName;
  late TextEditingController doctorGenderType;
  late TextEditingController doctorEnglishSpeaking; //
  late TextEditingController doctorHindiSpeaking; //
  late TextEditingController doctorMobileNumber;
  late TextEditingController doctorRegisteredCity;
  late TextEditingController doctorRegisteredCityPinCode;
  late TextEditingController doctorRegistrationDetails;

  late TextEditingController doctorQualification;
  late TextEditingController doctorMedicineType;
  late TextEditingController doctorDepartmentOfExpertise;
  late TextEditingController doctorYearsOfExperience; //
  late TextEditingController doctorNumberOfPatientsTreated; //
  late TextEditingController doctorTotalExperience; //
  late TextEditingController doctorExperienceRating; //

  late TextEditingController doctorProfilePicUrl;
  late TextEditingController doctorAuthenticationCertificateUrl;
  late TextEditingController doctorProfileCreationTime;
  late File doctorCertificate;

  ///////////////////////////////////////////////////
  setDoctorFullName(TextEditingController fullName) {
    this.doctorFullName = fullName;
  }

  TextEditingController getDoctorFullName() {
    return this.doctorFullName;
  }

  ///////////////////////////////////////////////////
  setDoctorFirstName(TextEditingController firstName) {
    this.doctorFirstName = firstName;
  }

  TextEditingController getDoctorFirstName() {
    return this.doctorFirstName;
  }

  ///////////////////////////////////////////////////
  setDoctorLastName(TextEditingController lastName) {
    this.doctorLastName = lastName;
  }

  TextEditingController getDoctorLastName() {
    return this.doctorLastName;
  }

  ///////////////////////////////////////////////////
  setDoctorGenderType(TextEditingController genderType) {
    this.doctorGenderType = genderType;
  }

  TextEditingController getDoctorGenderType() {
    return this.doctorGenderType;
  }

  ///////////////////////////////////////////////////
  setIsDoctorEnglishSpeaking(bool chk) {
    this.doctorEnglishSpeaking.text = chk.toString();
  }

  TextEditingController getIsDoctorEnglishSpeaking() {
    return this.doctorEnglishSpeaking;
  }

  ///////////////////////////////////////////////////
  setIsDoctorHindiSpeaking(bool chk) {
    this.doctorHindiSpeaking.text = chk.toString();
  }

  TextEditingController getIsDoctorHindiSpeaking() {
    return this.doctorHindiSpeaking;
  }

  ///////////////////////////////////////////////////
  setDoctorRegisteredCity(TextEditingController registeredCity) {
    this.doctorRegisteredCity = registeredCity;
  }

  TextEditingController getDoctorRegisteredCity() {
    return this.doctorRegisteredCity;
  }

  ///////////////////////////////////////////////////
  setDoctorRegisteredCityPincode(TextEditingController registeredCityPinCode) {
    this.doctorRegisteredCityPinCode = registeredCityPinCode;
  }

  TextEditingController getDoctorRegisteredCityPincode() {
    return this.doctorRegisteredCityPinCode;
  }

  ///////////////////////////////////////////////////
  setDoctorRegistrationDetails(TextEditingController registrationDetails) {
    this.doctorRegistrationDetails = registrationDetails;
  }

  TextEditingController getDoctorRegistrationDetails() {
    return this.doctorRegistrationDetails;
  }

  ///////////////////////////////////////////////////
  setDoctorMobileNumber(TextEditingController mobileNumber) {
    this.doctorMobileNumber = mobileNumber;
  }

  TextEditingController getDoctorMobileNumber() {
    return this.doctorMobileNumber;
  }

  ///////////////////////////////////////////////////
  setDoctorQualification(TextEditingController qualification) {
    this.doctorQualification = qualification;
  }

  TextEditingController getDoctorQualification() {
    return this.doctorQualification;
  }

  ///////////////////////////////////////////////////
  setDoctorMedicineType(TextEditingController medicineType) {
    this.doctorMedicineType = medicineType;
  }

  TextEditingController getDoctorMedicineType() {
    return this.doctorMedicineType;
  }

  ///////////////////////////////////////////////////
  setDoctorDepartmentOfExpertise(TextEditingController expertiseType) {
    this.doctorDepartmentOfExpertise = expertiseType;
  }

  TextEditingController getDoctorDepartmentOfExpertise() {
    return this.doctorDepartmentOfExpertise;
  }

  ///////////////////////////////////////////////////
  setDoctorProfilePicUrl(TextEditingController doctorProfilePicUrl) {
    this.doctorProfilePicUrl = doctorProfilePicUrl;
  }

  TextEditingController getDoctorProfilePicUrl() {
    return this.doctorProfilePicUrl;
  }

  ///////////////////////////////////////////////////
  setDoctorAuthenticationCertificateUrl(
      TextEditingController doctorAuthenticationCertificateUrl) {
    this.doctorAuthenticationCertificateUrl =
        doctorAuthenticationCertificateUrl;
  }

  TextEditingController getDoctorAuthenticationCertificateUrl() {
    return this.doctorAuthenticationCertificateUrl;
  }

  ///////////////////////////////////////////////////
  setDoctorProfileCreationTime(
      TextEditingController doctorProfileCreationTime) {
    this.doctorProfileCreationTime = doctorProfileCreationTime;
  }

  TextEditingController getDoctorProfileCreationTime() {
    return this.doctorProfileCreationTime;
  }

  ///////////////////////////////////////////////////
  setDoctorCertificate(File certificate) {
    this.doctorCertificate = certificate;
  }

  File getDoctorCertificate() {
    return this.doctorCertificate;
  }

  Future<void> clearStateOfLoggedInUser(BuildContext context) async {
    this.doctor_LanguageType = true;

    this.doctorFullName = TextEditingController();
    this.doctorFirstName = TextEditingController();
    this.doctorLastName = TextEditingController();
    this.doctorGenderType = TextEditingController();
    this.doctorMobileNumber = TextEditingController();
    this.doctorRegisteredCity = TextEditingController();
    this.doctorRegisteredCityPinCode = TextEditingController();
    this.doctorRegistrationDetails = TextEditingController();

    this.doctorQualification = TextEditingController();
    this.doctorMedicineType = TextEditingController();
    this.doctorDepartmentOfExpertise = TextEditingController();

    this.doctorProfilePicUrl = TextEditingController();
    this.doctorAuthenticationCertificateUrl = TextEditingController();
    this.doctorProfileCreationTime = TextEditingController();

    this.doctorCertificate = File("");

    this.mp = {};
    // Navigator.of(context).pop(false);
  }

  Future<void> upLoadNewDoctorPersonalInformation(
    BuildContext context,
    UserCredential authCredential,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("DoctorsUserPhoneNumberList");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLinkForPhoneNumbers =
        Provider.of<DoctorFirebaseDetails>(context, listen: false)
            .getFirebasePathUrl('/DoctorsUserPhoneNumberList.json');

    final responseForAddingNewDoctorUser = await http.post(
      urlLinkForPhoneNumbers,
      body: json.encode(
        {
          'doctor_personalUniqueIdentificationId': loggedInUserId.toString(),
          'doctor_PhoneNumber': this.doctorMobileNumber.text.toString(),
        },
      ),
    );

    try {
      final submissionResponse = await FirebaseFirestore.instance
          .collection('DoctorUsersPersonalInformation')
          .doc(authCredential.user?.uid)
          .set(
        {
          'doctor_LanguageType': this.isReadingLangEnglish.toString(),
          'doctor_uniqueDatabaseId': DateTime.now().toString(),
          'doctor_personalUniqueIdentificationId': loggedInUserId.toString(),
          'doctor_FullName': this.doctorFullName.text.toString(),
          'doctor_FirstName': "",
          'doctor_LastName': "",
          'doctor_Gender': '',
          'doctor_PhoneNumber': this.doctorMobileNumber.text.toString(),
          'doctor_MedicalRegistrationNumber': "",
          'doctor_CurrentCity': "",
          'doctor_CurrentCityPinCode': "",
          'doctor_RegistrationDetails': "",
          'doctor_EnglishSpeaking': "",
          'doctor_HindiSpeaking': "",
          'doctor_AutherizationStatus': 'Pending...',
          'doctor_EducationQualification': this.doctorQualification.text.toString(),
          'doctor_MedicineType': this.doctorMedicineType.text.toString(),
          'doctor_Speciality': this.doctorDepartmentOfExpertise.text.toString(),
          'doctor_YearsOfExperience': "",
          'doctor_NumberOfPatientsTreated': "0",
          'doctor_MobileMessagingTokenId': mobileMessagingToken.toString(),
          'doctor_TotalExperience': "0",
          'doctor_ExperienceRating': "0.0",
          'doctor_ProfilePicUrl': "",
          'doctor_SignatureUrl': "",
          'doctor_AuthenticationCertificateUrl': "",
          'doctor_ProfileCreationTime': DateTime.now().toString(),
          'doctor_ProfilePermission': 'true',
          'doctor_TotalNumberOfPatientRated': '0'
        },
      ).then((value) {
        setDoctorUserInfo(context);
      });

      // Navigator.of(context).pushReplacementNamed(TabsScreenDoctor.routeName);
      // Navigator.of(context).pop(false);
      setDoctorUserInfo(context);
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> setDoctorUserInfo(BuildContext context) async {
    if (mp.isEmpty) {
      var currLoggedInUser = await FirebaseAuth.instance.currentUser;
      var loggedInUserId = currLoggedInUser?.uid as String;

      var response = await FirebaseFirestore.instance
          .collection('DoctorUsersPersonalInformation')
          .doc(loggedInUserId)
          .get()
          .then(
        (DocumentSnapshot ds) {
          String doctor_LanguageType = "";
          String doctor_uniqueDatabaseId = "";
          String doctor_personalUniqueIdentificationId = "";
          String doctor_AutherizationStatus = "Pending";
          String doctor_EnglishSpeaking = "";
          String doctor_HindiSpeaking = "";
          String doctor_ProfilePermission = "";

          String doctor_FullName = "";
          String doctor_FirstName = "";
          String doctor_LastName = "";
          String doctor_Gender = "";
          String doctor_CurrentCity = "";
          String doctor_CurrentCityPinCode = "";
          String doctor_RegistrationDetails = "";

          String doctor_EducationQualification = "";
          String doctor_MedicineType = "";
          String doctor_Speciality = "";

          String doctor_YearsOfExperience = "";
          String doctor_NumberOfPatientsTreated = "";
          String doctor_TotalExperience = "";
          String doctor_ExperienceRating = "";

          String doctor_PhoneNumber = "";
          String doctor_MedicalRegistrationNumber = "";
          String doctor_ProfilePicUrl = "";
          String doctor_SignatureUrl = "";
          String doctor_AuthenticationCertificateUrl = "";
          String doctor_ProfileCreationTime = "";
          String doctor_TotalNumberOfPatientRated = "";

          doctor_LanguageType = ds.get('doctor_LanguageType').toString();
          doctor_uniqueDatabaseId =
              ds.get('doctor_uniqueDatabaseId').toString();
          doctor_personalUniqueIdentificationId =
              ds.get('doctor_personalUniqueIdentificationId').toString();
          doctor_AutherizationStatus =
              ds.get('doctor_AutherizationStatus').toString();

          doctor_FullName = ds.get('doctor_FullName').toString();
          doctor_FirstName = ds.get('doctor_FirstName').toString();
          doctor_LastName = ds.get('doctor_LastName').toString();
          doctor_Gender = ds.get('doctor_Gender').toString();
          doctor_CurrentCity = ds.get('doctor_CurrentCity').toString();
          doctor_CurrentCityPinCode =
              ds.get('doctor_CurrentCityPinCode').toString();
          doctor_RegistrationDetails =
              ds.get('doctor_RegistrationDetails').toString();
          doctor_EnglishSpeaking = ds.get('doctor_EnglishSpeaking').toString();
          doctor_HindiSpeaking = ds.get('doctor_HindiSpeaking').toString();

          doctor_EducationQualification =
              ds.get('doctor_EducationQualification').toString();
          doctor_MedicineType = ds.get('doctor_MedicineType').toString();
          doctor_Speciality = ds.get('doctor_Speciality').toString();

          doctor_YearsOfExperience =
              ds.get('doctor_YearsOfExperience').toString();
          doctor_NumberOfPatientsTreated =
              ds.get('doctor_NumberOfPatientsTreated').toString();
          doctor_TotalExperience = ds.get('doctor_TotalExperience').toString();
          doctor_ExperienceRating =
              ds.get('doctor_ExperienceRating').toString();
          doctor_TotalNumberOfPatientRated =
              ds.get('doctor_TotalNumberOfPatientRated').toString();

          doctor_PhoneNumber = ds.get('doctor_PhoneNumber').toString();
          doctor_MedicalRegistrationNumber =
              ds.get('doctor_MedicalRegistrationNumber').toString();
          doctor_ProfilePicUrl = ds.get('doctor_ProfilePicUrl').toString();
          doctor_SignatureUrl = ds.get('doctor_SignatureUrl').toString();
          doctor_AuthenticationCertificateUrl =
              ds.get('doctor_AuthenticationCertificateUrl').toString();
          doctor_ProfileCreationTime =
              ds.get('doctor_ProfileCreationTime').toString();
          doctor_ProfilePermission =
              ds.get('doctor_ProfilePermission').toString();

          mp["doctor_LanguageType"] = doctor_LanguageType;
          mp["doctor_uniqueDatabaseId"] = doctor_uniqueDatabaseId;
          mp["doctor_personalUniqueIdentificationId"] =
              doctor_personalUniqueIdentificationId;
          mp["doctor_AutherizationStatus"] = doctor_AutherizationStatus;
          mp['doctor_ProfilePermission'] = doctor_ProfilePermission;

          mp["doctor_FullName"] = doctor_FullName;
          mp["doctor_FirstName"] = doctor_FirstName;
          mp["doctor_LastName"] = doctor_LastName;
          mp["doctor_Gender"] = doctor_Gender;
          mp["doctor_CurrentCity"] = doctor_CurrentCity;
          mp["doctor_CurrentCityPinCode"] = doctor_CurrentCityPinCode;
          mp["doctor_RegistrationDetails"] = doctor_RegistrationDetails;
          mp["doctor_EnglishSpeaking"] = doctor_EnglishSpeaking;
          mp["doctor_HindiSpeaking"] = doctor_HindiSpeaking;

          mp["doctor_EducationQualification"] = doctor_EducationQualification;
          mp["doctor_MedicineType"] = doctor_MedicineType;
          mp["doctor_Speciality"] = doctor_Speciality;

          mp["doctor_YearsOfExperience"] = doctor_YearsOfExperience;
          mp["doctor_NumberOfPatientsTreated"] = doctor_NumberOfPatientsTreated;
          mp["doctor_TotalExperience"] = doctor_TotalExperience;
          mp["doctor_ExperienceRating"] = doctor_ExperienceRating;
          mp["doctor_TotalNumberOfPatientRated"] =
              doctor_TotalNumberOfPatientRated;

          mp["doctor_PhoneNumber"] = doctor_PhoneNumber;
          mp["doctor_MedicalRegistrationNumber"] =
              doctor_MedicalRegistrationNumber;
          mp["doctor_ProfilePicUrl"] = doctor_ProfilePicUrl;
          mp["doctor_SignatureUrl"] = doctor_SignatureUrl;
          mp["doctor_AuthenticationCertificateUrl"] =
              doctor_AuthenticationCertificateUrl;
          mp["doctor_ProfileCreationTime"] = doctor_ProfileCreationTime;

          if (doctor_LanguageType == 'true') {
            isReadingLangEnglish = true;
          } else {
            isReadingLangEnglish = false;
          }
        },
      );

      Navigator.of(context).pushNamedAndRemoveUntil(
          TabsScreenDoctor.routeName, (route) => false);
      notifyListeners();
    }
  }

  Future<void> updateDoctorUserPersonalInformation(
    BuildContext context,
    String labelText,
    String updatedText,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("DoctorUsersPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    db
        .collection("DoctorUsersPersonalInformation")
        .doc(loggedInUserId)
        .update({labelText: updatedText}).then((value) {
      mp[labelText] = updatedText;
    });

    notifyListeners();
    // Navigator.of(context).pushNamedAndRemoveUntil(TabsScreenDoctor.routeName, (route) => false);
  }

  Future<void> updateDoctorSignaturePicture(
    BuildContext context,
    File signaturePictureFile,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("DoctorUsersPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLinkForProfilePic = Provider.of<DoctorFirebaseDetails>(context,
            listen: false)
        .getFirebasePathUrl(
            '/DoctorStorageDetails/$loggedInUserId/DoctorSignaturePicture.json');

    String imageName = "${loggedInUserId}_signaturePic.jpg";
    final signaturePicture = FirebaseStorage.instance
        .ref()
        .child('DoctorStorageDetails/$loggedInUserId/DoctorSignaturePicture')
        .child(imageName);

    try {
      if (mp['doctor_SignatureUrl'] == '') {
        final imageUploadResponse = await signaturePicture.putFile(signaturePictureFile);
        mp['doctor_SignatureUrl'] = await signaturePicture.getDownloadURL();
        db
            .collection("DoctorUsersPersonalInformation")
            .doc(loggedInUserId)
            .update({"doctor_SignatureUrl": mp['doctor_SignatureUrl']});

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     TabsScreenDoctor.routeName, (route) => false);
      } else {
        final existingImageRef = FirebaseStorage.instance.ref();
        final deletingFileResponse = await existingImageRef
            .child(
                'DoctorStorageDetails/$loggedInUserId/DoctorSignaturePicture/${loggedInUserId}_signaturePic.jpg')
            .delete();

        final imageUploadResponse =
            await signaturePicture.putFile(signaturePictureFile);
        mp['doctor_SignatureUrl'] = await signaturePicture.getDownloadURL();
        db
            .collection("DoctorUsersPersonalInformation")
            .doc(loggedInUserId)
            .update({"doctor_SignatureUrl": mp['doctor_SignatureUrl']});
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     TabsScreenDoctor.routeName, (route) => false);
      }

    }
    catch (errorVal) {
      print(errorVal);
    }

  }

  Future<void> updateDoctorProfilePicture(
    BuildContext context,
    File profilePicFile,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef = db.collection("DoctorUsersPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLinkForProfilePic = Provider.of<DoctorFirebaseDetails>(context,
            listen: false)
        .getFirebasePathUrl(
            '/DoctorStorageDetails/$loggedInUserId/DoctorProfilePicture.json');

    String imageName = "${loggedInUserId}_profilePic.jpg";
    final profilePicture = FirebaseStorage.instance
        .ref()
        .child('DoctorStorageDetails/$loggedInUserId/DoctorProfilePicture')
        .child(imageName);

    try {
      if (mp['doctor_ProfilePicUrl'] == '') {
        final imageUploadResponse =
            await profilePicture.putFile(profilePicFile);
        mp['doctor_ProfilePicUrl'] = await profilePicture.getDownloadURL();
        db
            .collection("DoctorUsersPersonalInformation")
            .doc(loggedInUserId)
            .update({"doctor_ProfilePicUrl": mp['doctor_ProfilePicUrl']});

        Navigator.of(context).pushNamedAndRemoveUntil(
            TabsScreenDoctor.routeName, (route) => false);
      } else {
        final existingImageRef = FirebaseStorage.instance.ref();
        final deletingFileResponse = await existingImageRef
            .child(
                'DoctorStorageDetails/$loggedInUserId/DoctorProfilePicture/${loggedInUserId}_profilePic.jpg')
            .delete();

        final imageUploadResponse =
            await profilePicture.putFile(profilePicFile);
        mp['doctor_ProfilePicUrl'] = await profilePicture.getDownloadURL();
        db
            .collection("DoctorUsersPersonalInformation")
            .doc(loggedInUserId)
            .update({"doctor_ProfilePicUrl": mp['doctor_ProfilePicUrl']});

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     TabsScreenDoctor.routeName, (route) => false);
      }
    } catch (errorVal) {
      print(errorVal);
    }
  }

  Future<void> updateDoctorDocuments(
    BuildContext context,
    File documentPdfFile,
  ) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference usersRef =
        db.collection("DoctorUsersPersonalInformation");

    var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    var loggedInUserId = currLoggedInUser?.uid as String;

    Uri urlLinkForDocuments = Provider.of<DoctorFirebaseDetails>(context,
            listen: false)
        .getFirebasePathUrl(
            '/DoctorStorageDetails/$loggedInUserId/DoctorPersonalDocuments.json');

    String documentFileName = "${loggedInUserId}_documentFile.pdf";
    final documentFile = FirebaseStorage.instance
        .ref()
        .child('DoctorStorageDetails/$loggedInUserId/DoctorPersonalDocuments')
        .child(documentFileName);

    try {
      if (mp['doctor_AuthenticationCertificateUrl'] == '') {
        final documentUploadResponse =
            await documentFile.putFile(documentPdfFile);
        mp['doctor_AuthenticationCertificateUrl'] =
            await documentFile.getDownloadURL();
        db
            .collection("DoctorUsersPersonalInformation")
            .doc(loggedInUserId)
            .update({
          "doctor_AuthenticationCertificateUrl":
              mp['doctor_AuthenticationCertificateUrl']
        });

        Navigator.of(context).pushNamedAndRemoveUntil(
            TabsScreenDoctor.routeName, (route) => false);
      } else {
        final existingDocumentRef = FirebaseStorage.instance.ref();
        final deletingFileResponse = await existingDocumentRef
            .child(
                'DoctorStorageDetails/$loggedInUserId/DoctorPersonalDocuments/${loggedInUserId}_documentFile.pdf')
            .delete();

        final documentUploadResponse =
            await documentFile.putFile(documentPdfFile);
        mp['doctor_AuthenticationCertificateUrl'] =
            await documentFile.getDownloadURL();
        db
            .collection("DoctorUsersPersonalInformation")
            .doc(loggedInUserId)
            .update({
          "doctor_AuthenticationCertificateUrl":
              mp['doctor_AuthenticationCertificateUrl']
        });

        Navigator.of(context).pushNamedAndRemoveUntil(
            TabsScreenDoctor.routeName, (route) => false);
      }
    } catch (errorVal) {
      print(errorVal);
    }
  }
}
