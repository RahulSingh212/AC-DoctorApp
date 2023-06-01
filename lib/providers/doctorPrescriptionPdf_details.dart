// ignore_for_file: use_build_context_synchronously, unnecessary_this, unnecessary_new, prefer_const_constructors, unnecessary_brace_in_string_interps, unused_local_variable, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unnecessary_string_interpolations, unused_import, import_of_legacy_library_into_null_safe, duplicate_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:doctor/providers/doctorUser_details.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/src/widgets/basic.dart' as comp;
import 'package:flutter/src/widgets/framework.dart' as WidgetComp;
import 'package:flutter/src/widgets/container.dart' as ContainerComp;
import 'package:flutter/src/widgets/text.dart' as TextComp;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/models/token_info.dart';
import 'package:doctor/screens/My_Calendar_Screen/MyCalendar_Screen.dart';
import 'package:doctor/screens/Tabs_Screen.dart';
import 'package:doctor/screens/signup_Screens/SelectSignInSignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:open_file/open_file.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth/auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';

import './doctorFirebaseLinks_details.dart';
import 'package:provider/provider.dart';

import './doctorFirebaseLinks_details.dart';

import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/medicine_info.dart';
import '../models/slot_info.dart';
import '../models/docPat_info.dart';

class PdfApi {
  // static Future<File> generateCenteredText(String text) async {
  //   final pdf = Document();

  //   // pdf.addPage(Page(
  //   //   build: (context) => Center(
  //   //     child: Text(text, style: TextStyle(fontSize: 48)),
  //   //   ),
  //   // ));
  // //  Page pdfFirstPage = Page();
  // //   pdf.addPage(pdfFirstPage);

  // //   return saveDocument(name: 'my_pdf.pdf', pdf: pdf);
  // }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(BuildContext context, File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}

class PdfInvoiceApi {
  static var doctorSignatureImage;

  static Future<File> generatePrescriptionPdf(
    BuildContext context,
    PrescriptionDetails invoice,
    TextEditingController recommendedPathologicalTests,
    TextEditingController patientBloodPressure,
    TextEditingController patientBodyTemperature,
    String patientAlimentText,
    String doctorRegistrationNumber,
    String doctorSignatureUrl,
  ) async {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var topInsets = MediaQuery.of(context).viewInsets.top;
    var bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    var useableHeight = screenHeight - topInsets - bottomInsets;

    final pdf = Document();

    final tableHeader = [
      'Name',
      'Type',
      'Form',
      'Strength',
      'Dosage',
      'Timings'
    ];

    List<MedicinePrescribe> tableDataList = [];
    for (var med in invoice.mp.values) {
      tableDataList.add(med);
    }

    final tableData = tableDataList.map((medDetails) {
      String timing = "";
      if (medDetails.ismorning) {
        // timing += isLangEnglish ? 'Morning ' : 'प्रभात ';
        timing += 'Morning ';
      }
      if (medDetails.isafternoon) {
        // timing += isLangEnglish ? 'Afternoon ' : 'दोपहर ';
        timing += 'Afternoon ';
      }
      if (medDetails.isevening) {
        // timing += isLangEnglish ? 'Evening ' : 'शाम ';
        timing += 'Evening ';
      }
      if (medDetails.isdinner) {
        // timing += isLangEnglish ? 'Night ' : 'रात ';
        timing += 'Night ';
      }

      return [
        medDetails.Tabletname,
        medDetails.MedicineType,
        medDetails.FormofMedicine,
        medDetails.Strength,
        medDetails.Dosage,
        timing,
      ];
    }).toList();

    // final imageLogo = await rootBundle.loadString('assets/images/agLogo.png');
    final imageLogo = (await rootBundle.load('assets/images/agLogo.png'))
        .buffer
        .asUint8List();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Container(
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      height: 50,
                      width: 50,
                      // child: pw.SvgImage(svg: imageLogo),
                      child: pw.Image(
                        pw.MemoryImage(imageLogo),
                      ),
                    ),
                    pw.Container(
                      child: pw.Text(
                        // isLangEnglish ? 'AURIGA CARE' : "औरिगा केयर",
                        'AURIGA CARE',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontStyle: pw.FontStyle.italic,
                          // color: PdfColor.fromRYB(66, 204, 195),
                          fontSize: 30,
                        ),
                      ),
                    ),
                    pw.Container(
                      height: 50,
                      width: 50,
                      child: pw.BarcodeWidget(
                        data: invoice.tokenInfo.registeredTokenId,
                        barcode: Barcode.qrCode(),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(
                height: 30,
              ),
              pw.Container(
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      child: pw.Container(
                        child: pw.Column(
                          children: [
                            pw.Container(
                              child: pw.RichText(
                                textAlign: TextAlign.left,
                                text: pw.TextSpan(
                                  children: [
                                    pw.TextSpan(
                                      text:
                                          // isLangEnglish
                                          //     ? "Doctor Details:\n\n"
                                          //     : "डॉक्टर विवरण:\n\n",
                                          "Doctor Details:\n\n",
                                      style: pw.TextStyle(
                                        // color: PdfColor.fromRYB(150, 150, 150),
                                        color: PdfColors.blueGrey,
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 15.5,
                                      ),
                                    ),
                                    pw.TextSpan(
                                      // text: isLangEnglish ? "Name:       " : "नाम: ",
                                      text: "Name:       ",
                                      style: pw.TextStyle(
                                        color: PdfColors.blueGrey,
                                        fontSize: 15,
                                      ),
                                    ),
                                    pw.TextSpan(
                                      text:
                                          "${invoice.tokenInfo.doctorFullName}\n",
                                      style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.TextSpan(
                                      text: "Speciality: ",
                                      style: pw.TextStyle(
                                        color: PdfColors.blueGrey,
                                        fontSize: 15,
                                      ),
                                    ),
                                    pw.TextSpan(
                                      text:
                                          "${invoice.tokenInfo.doctorSpeciality}\n",
                                      style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.TextSpan(
                                      text: "Registration No: ",
                                      style: pw.TextStyle(
                                        color: PdfColors.blueGrey,
                                        fontSize: 15,
                                      ),
                                    ),
                                    pw.TextSpan(
                                      text: "${doctorRegistrationNumber}\n",
                                      style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // pw.Container(
                            //   height: 30,
                            //   width: 80,
                            //   // child: pw.SvgImage(svg: imageLogo),
                            //   child: pw.Image(
                            //     doctorSignatureImage,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    pw.Container(
                      child: pw.RichText(
                        textAlign: TextAlign.left,
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              // text: isLangEnglish
                              //     ? "Patient Details:\n\n"
                              //     : "रोगी विवरण:\n\n",
                              text: "Patient Details:\n\n",
                              style: pw.TextStyle(
                                // color: PdfColor.fromRYB(150, 150, 150),
                                color: PdfColors.blueGrey,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 15.5,
                              ),
                            ),
                            pw.TextSpan(
                              // text: isLangEnglish ? "Name:    " : "नाम: ",
                              text: "Name:    ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text: "${invoice.tokenInfo.patient_FullName}\n",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              // text: isLangEnglish ? "Contact: " : "संपर्क: ",
                              text: "Contact: ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${invoice.tokenInfo.patient_PhoneNumber.toString()}\n",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              // text: isLangEnglish ? "Age: " : "आयु: ",
                              text: "Age: ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${invoice.tokenInfo.patient_Age == 0 ? "NA" : invoice.tokenInfo.patient_Age}, ",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              // text: isLangEnglish ? "Blood: " : "खून: ",
                              text: "Blood: ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${invoice.tokenInfo.patient_BloodGroup == "" ? "NA" : invoice.tokenInfo.patient_BloodGroup}\n",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              // text: isLangEnglish ? "Weight: " : "वज़न: ",
                              text: "Weight: ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${invoice.tokenInfo.patient_Weight == 0.0 ? "NA" : invoice.tokenInfo.patient_Weight}, ",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              // text: isLangEnglish ? "Height: " : "कद: ",
                              text: "Height: ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${invoice.tokenInfo.patient_Height == 0.0 ? "NA\n" : invoice.tokenInfo.patient_Height}\n",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              // text: isLangEnglish ? "Height: " : "कद: ",
                              text: "BP: ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${patientBloodPressure.text == 0.0 ? "NA " : patientBloodPressure.text} mmHg\n",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              // text: isLangEnglish ? "Height: " : "कद: ",
                              text: "Temp: ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${patientBodyTemperature.text == 0.0 ? "NA" : patientBodyTemperature.text} C",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.RichText(
                  textAlign: TextAlign.left,
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        // text: isLangEnglish
                        //     ? "Appointment Details:\n"
                        //     : "नियुक्ति विवरण:\n",
                        text: "Appointment Details:\n",
                        style: pw.TextStyle(
                          color: PdfColors.blueGrey,
                          fontSize: 15,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 7.5,
              ),
              pw.Container(
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Container(
                      child: pw.RichText(
                        textAlign: TextAlign.left,
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              // text: isLangEnglish ? "Date: " : "दिनांक: ",
                              text: "Date: ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${DateFormat.yMMMd().format(invoice.tokenInfo.bookedTokenDate)}",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    pw.Container(
                      child: pw.RichText(
                        textAlign: TextAlign.left,
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              // text: isLangEnglish ? "Time: " : "समय: ",
                              text: "Time: ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${TimeOfDayToStringTime(invoice.tokenInfo.bookedTokenTime)}",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(
                height: 15,
              ),
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.RichText(
                  textAlign: TextAlign.left,
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        // text: isLangEnglish
                        //     ? "Prescribed Medicine Details:\n"
                        //     : "निर्धारित दवा विवरण:\n",
                        text: "Prescribed Medicine Details:\n",
                        style: pw.TextStyle(
                          color: PdfColors.blueGrey,
                          fontSize: 15,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Divider(),
              pw.Container(
                child: pw.Table.fromTextArray(
                  headers: tableHeader,
                  data: tableData,
                  border: null,
                  headerStyle: pw.TextStyle(fontWeight: FontWeight.bold),
                  headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                  cellHeight: 30,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                    5: pw.Alignment.center,
                  },
                ),
              ),
              pw.Divider(),
              pw.SizedBox(
                height: 3.5,
              ),
              pw.Container(
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.RichText(
                        textAlign: TextAlign.left,
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              // text: isLangEnglish
                              //     ? "Remarks: \n"
                              //     : "टिप्पणियां: \n",
                              text: "Medicinal Remarks: \n",
                              style: pw.TextStyle(
                                // color: PdfColor.fromRYB(150, 150, 150),
                                // color: PdfColors.blueGrey,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 15.5,
                                decoration: pw.TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    pw.Container(
                      child: pw.RichText(
                        textAlign: TextAlign.left,
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              // text: isLangEnglish ? "Created At: " : "बनाया गया: ",
                              text: "Created At: ",
                              style: pw.TextStyle(
                                color: PdfColors.blueGrey,
                                fontSize: 12,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${TimeOfDayToStringTime(TimeOfDay.now())}, ",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.TextSpan(
                              text:
                                  "${DateFormat.yMMMd().format(DateTime.now())}",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(
                height: 7.5,
              ),
              pw.Container(
                // height: screenHeight * 0.25,
                // width: screenWidth * 0.95,
                alignment: pw.Alignment.centerLeft,
                child: pw.ListView.builder(
                  itemCount: tableDataList.length,
                  itemBuilder: (ctx, index) {
                    if (tableDataList[index].Remarks.trim() != '') {
                      return pw.RichText(
                        textAlign: TextAlign.left,
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: "${tableDataList[index].Tabletname}: ",
                              style: pw.TextStyle(
                                // color: PdfColor.fromRYB(150, 150, 150),
                                color: PdfColors.blueGrey,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            pw.TextSpan(
                              text: "${tableDataList[index].Remarks}",
                              style: pw.TextStyle(
                                color: PdfColors.black,
                                fontSize: 16,
                                // fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return pw.SizedBox();
                    }
                  },
                ),
              ),
              pw.SizedBox(
                height: 7.5,
              ),
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.RichText(
                  textAlign: TextAlign.left,
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        // text: isLangEnglish
                        //     ? "Remarks: \n"
                        //     : "टिप्पणियां: \n",
                        text: "Patient's Aliment: \n",
                        style: pw.TextStyle(
                          // color: PdfColor.fromRYB(150, 150, 150),
                          // color: PdfColors.blueGrey,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 15.5,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 3.5,
              ),
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.RichText(
                  textAlign: TextAlign.left,
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        // text: isLangEnglish
                        //     ? "Remarks: \n"
                        //     : "टिप्पणियां: \n",
                        text: patientAlimentText,
                        style: pw.TextStyle(
                          // color: PdfColor.fromRYB(150, 150, 150),
                          // color: PdfColors.blueGrey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 7.5,
              ),
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.RichText(
                  textAlign: TextAlign.left,
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        // text: isLangEnglish
                        //     ? "Remarks: \n"
                        //     : "टिप्पणियां: \n",
                        text: "Pathalogical Tests: \n",
                        style: pw.TextStyle(
                          // color: PdfColor.fromRYB(150, 150, 150),
                          // color: PdfColors.blueGrey,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 15.5,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 3.5,
              ),
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                child: pw.RichText(
                  textAlign: TextAlign.left,
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        // text: isLangEnglish
                        //     ? "Remarks: \n"
                        //     : "टिप्पणियां: \n",
                        text: recommendedPathologicalTests.text,
                        style: pw.TextStyle(
                          // color: PdfColor.fromRYB(150, 150, 150),
                          // color: PdfColors.blueGrey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.RichText(
                  textAlign: TextAlign.center,
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        // text: isLangEnglish
                        //     ? "Remarks: \n"
                        //     : "टिप्पणियां: \n",
                        text:
                            "Note: This is a tele-consultation prescription and Auriga Care is not responsible for the medicines provided by the doctor.\n",
                        style: pw.TextStyle(
                          color: PdfColors.red900,
                          // color: PdfColor.fromRYB(150, 150, 150),
                          // color: PdfColors.blueGrey,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 7.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.RichText(
                  textAlign: TextAlign.center,
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        // text: isLangEnglish
                        //     ? "Remarks: \n"
                        //     : "टिप्पणियां: \n",
                        text:
                            "Yes, I (${invoice.tokenInfo.patient_FullName}) am ready to talk to the doctor to get my treatment through telemedicine, and this teleconsultation is happening only after my consent.\n",
                        style: pw.TextStyle(
                          color: PdfColors.red900,
                          // color: PdfColor.fromRYB(150, 150, 150),
                          // color: PdfColors.blueGrey,
                          // fontWeight: pw.FontWeight.bold,
                          fontSize: 7.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
          // pw.Center(
          //   child: pw.Text("Hello World"),
          // ); // Center
        },
      ),
    );

    return PdfApi.saveDocument(name: 'prescription.pdf', pdf: pdf);
  }

  // static WidgetComp.Widget buildTitle(
  //     BuildContext context, PrescriptionDetails invoice) {
  //   return
  //       // Scaffold(
  //       // body:
  //       comp.Column(
  //     crossAxisAlignment: comp.CrossAxisAlignment.start,
  //     children: [
  //       TextComp.Text('Header'),
  //     ],
  //   );
  //   // );
  // }
}

class DoctorPrescriptionPdfDetails with ChangeNotifier {
  Future<void> createDoctorPrescription(
    BuildContext context,
    BookedTokenSlotInformation tokenInfo,
    Map<String, MedicinePrescribe> mp,
    TextEditingController recommendedPathologicalTests,
    TextEditingController patientBloopPressure,
    TextEditingController patientBodyTemperature,
    String doctorRegistrationNumber,
    String doctorSignatureUrl,
  ) async {
    print("inside");
    // final prescriptionPdfFile = await PdfApi.generateCenteredText('Simple Text');
    // PdfApi.openFile(prescriptionPdfFile);

    final pd = PrescriptionDetails(
      tokenInfo: tokenInfo,
      mp: mp,
    );

    PdfInvoiceApi.doctorSignatureImage =
        await networkImage(doctorSignatureUrl).then((value) async {
      var pdfFile;
      pdfFile = await PdfInvoiceApi.generatePrescriptionPdf(
        context,
        pd,
        recommendedPathologicalTests,
        patientBloopPressure,
        patientBodyTemperature,
        tokenInfo.patientAilmentDescription,
        doctorRegistrationNumber,
        doctorSignatureUrl,
      );
      // .then((value) {
      //   uploadDoctorAppointmentPrescription(context, tokenInfo, pdfFile);
      // });

      PdfApi.openFile(context, pdfFile).then((value) {
        uploadDoctorAppointmentPrescription(context, tokenInfo, pdfFile);
      });
    });

    // var pdfFile;
    // pdfFile = await PdfInvoiceApi.generatePrescriptionPdf(
    //   context,
    //   pd,
    //   recommendedPathologicalTests,
    //   patientBloopPressure,
    //   patientBodyTemperature,
    //   tokenInfo.patientAilmentDescription,
    //   doctorRegistrationNumber,
    //   doctorSignatureUrl,
    // );
    // // .then((value) {
    // //   uploadDoctorAppointmentPrescription(context, tokenInfo, pdfFile);
    // // });

    // PdfApi.openFile(context, pdfFile).then((value) {
    //   uploadDoctorAppointmentPrescription(context, tokenInfo, pdfFile);
    // });
  }

  Future<void> uploadDoctorAppointmentPrescription(
    BuildContext context,
    BookedTokenSlotInformation tokenInfo,
    File documentPdfFile,
  ) async {
    // FirebaseFirestore db = FirebaseFirestore.instance;
    // CollectionReference usersRef = db.collection("PatientUsersPersonalInformation");

    // var currLoggedInUser = await FirebaseAuth.instance.currentUser;
    // var loggedInUserId = currLoggedInUser?.uid as String;

    String aptDate = "${tokenInfo.bookedTokenDate.day}-${tokenInfo.bookedTokenDate.month}-${tokenInfo.bookedTokenDate.year}";
    String aptTime = tokenInfo.bookedTokenTime.toString();
    String refLink = "PatientReportsAndPrescriptionsDetails/${tokenInfo.patient_personalUniqueIdentificationId}/${tokenInfo.doctor_personalUniqueIdentificationId}/${tokenInfo.registeredTokenId}/${aptDate}/${aptTime}/DoctorGivenPrescription";

    try {
      String documentFileName = "doctorPrescriptionFile.pdf";
      final documentFile = FirebaseStorage.instance.ref().child(refLink).child(documentFileName);

      final documentUploadResponse =
          await documentFile.putFile(documentPdfFile).then((p0) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            TabsScreenDoctor.routeName, (route) => false);
      });
    } catch (errorVal) {
      print(errorVal);
    }

    // Future<ListResult> futureFiles = FirebaseStorage.instance.ref('/${refLink}').listAll();

    // DateTime cT = DateTime.now();
    // String pth =
    //     "${cT.day}-${cT.month}-${cT.year}-${cT.hour}-${cT.minute}-${cT.second}";
    // if (futureFiles.toString() == null) {
    //   try {
    //     String documentFileName = "doctorPrescriptionFile.pdf";
    //     final documentFile = FirebaseStorage.instance
    //         .ref()
    //         .child(refLink)
    //         .child(documentFileName);

    //     final documentUploadResponse =
    //         await documentFile.putFile(documentPdfFile);
    //   } catch (errorVal) {
    //     print(errorVal);
    //   }
    // } else {
    //   try {
    //   final existingDocumentRef = FirebaseStorage.instance.ref();
    //   final deletingFileResponse = await existingDocumentRef
    //       .child('${refLink}/doctorPrescriptionFile.pdf')
    //       .delete()
    //       .then((value) async {
    //     String documentFileName =
    //         "doctorPrescriptionFile.pdf";
    //     final documentFile = FirebaseStorage.instance
    //         .ref()
    //         .child(refLink)
    //         .child(documentFileName);

    //     final documentUploadResponse = await documentFile.putFile(documentPdfFile).then((p0) {
    //       Navigator.of(context).pushNamedAndRemoveUntil(TabsScreenDoctor.routeName, (route) => false);
    //     });
    //   });
    //   }
    //   catch (errorVal) {
    //     print(errorVal);
    //   }
    // }
  }
}

class PrescriptionDetails {
  BookedTokenSlotInformation tokenInfo;
  Map<String, MedicinePrescribe> mp;

  PrescriptionDetails({
    required this.tokenInfo,
    required this.mp,
  });
}

String TimeOfDayToStringTime(TimeOfDay time) {
  int hr = time.hour, min = time.minute;

  String strTime = "";
  if (hr * 60 + min < 720) {
    strTime = "${hr % 12}:${min} AM";
  } else {
    strTime = "${hr % 12}:${min} PM";
  }

  return strTime;
}

// Container(
//               padding: EdgeInsets.only(top: 0.65 * height),
//               alignment: Alignment.topCenter,
//               child: Align(
//                 child: Container(
//                   height: screenHeight * 0.175,
//                   width: screenWidth * 0.35,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.transparent,
//                     radius: screenWidth,
//                     child: CircleAvatar(
//                       radius: screenWidth * 0.6,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(
//                           screenWidth * 0.2,
//                         ),
//                         child: ClipOval(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: Image.asset(
//                               "assets/images/agLogo.png",
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
