import 'package:flutter/material.dart';
import 'package:flutter_app/classes/pdf_save.dart';
import 'package:printing/printing.dart';
import '../classes/printer_setting.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart'as pw;




class Setting extends StatefulWidget {
@override
_State createState() => _State();
}

class _State extends State<Setting> {




@override
Widget build(BuildContext context) {


return Center(
  child:   Container(

    child: PdfPreview(

      build: ((format)=>PdfInvoiceApi.generatePdf(format, 'aaa')),



    ),
  ));


}



}

Future<Uint8List> generatePdf(PdfPageFormat format, String title) async {
  final pdf = pw.Document();

  final image = await imageFromAssetBundle('images/logo.png');


  pdf.addPage(
    pw.Page(

      build: (context) {
        return pw.Container(

          child: pw.Text('qq')
        );

      },
    ),
  );

  return pdf.save();
}







