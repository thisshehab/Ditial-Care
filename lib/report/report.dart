import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../Models/patient_model.dart';

class Report extends StatefulWidget {
  var color = Color.fromARGB(255, 165, 165, 165);
  final String patientName;
  final String patientAge;
  final bool dangourse;
  List<PatientSigns> patientSigns;
  String reportTitle;
  Report(
      {required this.reportTitle,
      required this.patientAge,
      required this.patientName,
      required this.patientSigns,
      required this.dangourse});

  @override
  State<Report> createState() => _reporttState();
}

class _reporttState extends State<Report> {
  final pdf = pw.Document();

  var marks;
  void initState() {
    print(widget.patientSigns);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      // maxPageWidth: 1000,
      // useActions: false,
      // canChangePageFormat: true,
      canChangeOrientation: false,

      // pageFormats:pageformat,
      canDebug: false,

      build: (format) => generateDocument(
        format,
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    pw.MemoryImage gdsc = pw.MemoryImage(
      (await rootBundle.load('images/gdsc.png')).buffer.asUint8List(),
    );
    pw.MemoryImage yemen = pw.MemoryImage(
      (await rootBundle.load('images/emblem.jpg')).buffer.asUint8List(),
    );

    final doc = pw.Document(
      pageMode: PdfPageMode.outlines,
      creator: "Eng Shehab",
    );
    final font1 = await PdfGoogleFonts.iBMPlexSansArabicMedium();
    final font2 = await PdfGoogleFonts.iBMPlexSansArabicBold();
    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            width: 595,
            height: 842,
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
          ),
          orientation: pw.PageOrientation.portrait,
          textDirection: pw.TextDirection.rtl,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Wrap(children: [
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Image(yemen, height: 50),
                      pw.Container(child: pw.Image(gdsc, height: 110)),
                      pw.Image(yemen, height: 50),
                    ]),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Center(
                  child: pw.Text(
                    widget.reportTitle,
                    style: pw.TextStyle(fontSize: 17),
                  ),
                ),
                pw.SizedBox(
                  height: 40,
                ),
                // pw.Divider(thickness: .4, color: PdfColor.fromHex("A5A5A5")),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Text("سن المريض  ${widget.patientAge} :"),
                      pw.Text("أسم المريض : ${widget.patientName}"),
                    ]),
                pw.SizedBox(height: 10),

                pw.Divider(thickness: 1, color: PdfColor.fromHex("A5A5A5")),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Column(
                  children: [
                    pw.Padding(
                        padding:
                            pw.EdgeInsets.only(top: 20, right: 50, left: 50),
                        child: pw.ListView.builder(
                            itemBuilder: (context, index) {
                              return pw.Table(
                                  border: pw.TableBorder.all(),
                                  defaultColumnWidth: pw.FixedColumnWidth(240),
                                  children: [
                                    index == 0
                                        ? pw.TableRow(children: [
                                            pw.Padding(
                                              padding: pw.EdgeInsets.all(5),
                                              child: pw.Text("تشبع الاكسجين"),
                                            ),
                                            pw.Padding(
                                              padding: pw.EdgeInsets.all(5),
                                              child: pw.Text("الحرارة"),
                                            ),
                                            pw.Padding(
                                              padding: pw.EdgeInsets.all(5),
                                              child:
                                                  pw.Text("معدل نبضات القلب"),
                                            ),
                                            pw.Padding(
                                              padding: pw.EdgeInsets.all(5),
                                              child: pw.Text("الوقت"),
                                            ),
                                          ])
                                        : pw.TableRow(
                                            children: [pw.Container()]),
                                    !widget.dangourse
                                        ? notdangourse(index)
                                        : dangourse(index)
                                  ]);
                            },
                            itemCount: widget.patientSigns.length))
                  ],
                )
              ],
            )
          ]);
        },
      ),
    );

    return doc.save();
  }

  pw.TableRow notdangourse(int index) {
    return pw.TableRow(children: [
      pw.Padding(
        padding: pw.EdgeInsets.all(3),
        child: pw.Text(widget.patientSigns[index].spo2.toString()),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(3),
        child: pw.Text(widget.patientSigns[index].temp.toString()),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(3),
        child: pw.Text(widget.patientSigns[index].hr.toString()),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(3),
        child: pw.Text(
            widget.patientSigns[index].time.toString().substring(0, 14)),
      ),
    ]);
  }

  pw.TableRow dangourse(int index) {
    return widget.patientSigns[index].dangerous!
        ? pw.TableRow(children: [
            pw.Padding(
              padding: pw.EdgeInsets.all(3),
              child: pw.Text(widget.patientSigns[index].spo2.toString()),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(3),
              child: pw.Text(widget.patientSigns[index].temp.toString()),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(3),
              child: pw.Text(widget.patientSigns[index].hr.toString()),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(3),
              child: pw.Text(
                  widget.patientSigns[index].time.toString().substring(0, 14)),
            ),
          ])
        : pw.TableRow(children: [pw.Container()]);
  }
}
