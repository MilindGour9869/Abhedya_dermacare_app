
import 'package:pdf/widgets.dart' as pw;


import 'dart:typed_data';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

import 'package:flutter/material.dart' ;

class PdfInvoiceApi {



  static Future<Uint8List> generatePdf( {String date ,  String id , String name ,String gender ,  int age, int mobile ,String notes , List diagnosis , Map<String,Map<String,dynamic>> medicinces , List advice }) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5 , compress: true);

    final image = await imageFromAssetBundle('images/logo_without_background.png');
    final font = await fontFromAssetBundle('font/GIST-DVOTMohini.ttf');
    final font1 = await fontFromAssetBundle('font/DevanagariBold.ttf');

    int row=1;






    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm, marginTop:1 * PdfPageFormat.cm  ),

        build: (context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [

                  pw.Padding(


                 child: pw.Image(image , height: 3 * PdfPageFormat.cm , width: 3 * PdfPageFormat.cm),
                  padding: pw.EdgeInsets.only(left: 1 * PdfPageFormat.cm)
                  ),



                  pw.Container(
                    padding: pw.EdgeInsets.only(right: 1 * PdfPageFormat.cm),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [

                        pw.Text('डॉ. महिराम ' , style: pw.TextStyle(fontSize: 0.5*PdfPageFormat.cm , font:font , color: PdfColors.purple)),
                        pw.Text('Dr. Mahiram Bisnoi' , style: pw.TextStyle(fontSize: 0.5*PdfPageFormat.cm)),
                        pw.Text('aa'),
                        pw.Text('aa'),
                        pw.Text('aa'),







                      ]
                    )
                  ),





                ]
              ),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    height: 0.4*PdfPageFormat.cm,
                    width: 1*PdfPageFormat.cm,
                    color: PdfColors.purple,



                  ),
                  pw.SizedBox(width: 5),
                  pw.Column(
                      children: [
                        pw.Text("Abhedya's" , style: pw.TextStyle(fontSize: 0.4*PdfPageFormat.cm , )),
                        pw.Text("DERMACARE" , style: pw.TextStyle(fontSize: 0.2*PdfPageFormat.cm) )
                      ]
                  ),
                  pw.SizedBox(width: 5),
                  pw.Container(
                    color: PdfColors.orangeAccent,
                    height: 0.4*PdfPageFormat.cm,
                    width:500,


                  ),



                ]
              ),

              pw.Row(
                children: [
                  pw.Flexible(
                    flex: 1,
                    child:pw.Container(
                      padding: pw.EdgeInsets.only(left: 20),
                      width: double.infinity,
                      child: pw.Column(

                        mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,



                          children: [

                            pw.SizedBox(height:  0.5* PdfPageFormat.cm),

                           pw.Padding(
                             padding: pw.EdgeInsets.only(left: 23),
                             child:  pw.Text('उपलब्ध सुविधाऐ' , style: pw.TextStyle(fontSize: 0.5*PdfPageFormat.cm , font: font)),
                           ),

                            pw.SizedBox(height:  0.5* PdfPageFormat.cm),



                            //1
                            pw.Bullet(
                              text: 'समस्त चर्म ऐव योन रोग',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: 0.3*PdfPageFormat.cm,
                                font: font,

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.0* PdfPageFormat.cm ,),
                              bulletSize: 0.1*PdfPageFormat.cm,



                            ),

                            pw.SizedBox(height:0.5* PdfPageFormat.cm ),


                            //2
                            pw.Bullet(
                              text: 'नाखुन बालो से संबंधित रोग',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: 0.3*PdfPageFormat.cm,
                                font: font,

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.0* PdfPageFormat.cm ,),
                              bulletSize: 0.1*PdfPageFormat.cm,



                            ),

                            pw.SizedBox(height:0.5* PdfPageFormat.cm ),




                            //3
                            pw.Bullet(
                              text: 'Triplle Wave Length Diode Laser',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: 0.3*PdfPageFormat.cm

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.1* PdfPageFormat.cm),
                              bulletSize: 0.1*PdfPageFormat.cm,

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: 23),
                            child: pw.Text('अंचाहे बालो को हटाना' , style: pw.TextStyle(
                                fontSize:  0.2* PdfPageFormat.cm,
                                font:font))),

                            pw.SizedBox(height: 0.5*PdfPageFormat.cm),

                            //4
                            pw.Bullet(
                              text: 'फोटोथेरेपी',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: 0.3*PdfPageFormat.cm,
                                  font: font,

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.1* PdfPageFormat.cm),
                              bulletSize: 0.1*PdfPageFormat.cm,

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: 23 ),
                                child: pw.Text('सफेद दाग हटाना\nसोरायसिस का इलाज' , style: pw.TextStyle(
                                    fontSize:  0.2* PdfPageFormat.cm,
                                    font:font))),

                            pw.SizedBox(height: 0.5*PdfPageFormat.cm),



                            //5
                            pw.Bullet(
                              text: 'PRP , ACUGEL TREATMENT',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: 0.3*PdfPageFormat.cm

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.1* PdfPageFormat.cm),
                              bulletSize: 0.1*PdfPageFormat.cm,

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: 23),
                                child: pw.Text('DARK CIRCLE हटाना\nचेहरे पर GLOW(चमक)लाना' , style: pw.TextStyle(
                                    fontSize:  0.2* PdfPageFormat.cm,
                                    font:font))),

                            pw.SizedBox(height: 0.5*PdfPageFormat.cm),

                            //6
                            pw.Bullet(
                              text: 'MNRF',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: 0.3*PdfPageFormat.cm

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.1* PdfPageFormat.cm),
                              bulletSize: 0.1*PdfPageFormat.cm,

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: 23),
                                child: pw.Text('पिंपल्स के खड्डे भरना\nचिकनपॉक्स के खड्डे भरना' , style: pw.TextStyle(
                                    fontSize:  0.2* PdfPageFormat.cm,
                                    font:font))),

                            pw.SizedBox(height: 0.5*PdfPageFormat.cm),


                            //7
                            pw.Bullet(
                              text: 'केमिकल पीलिंग',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: 0.2*PdfPageFormat.cm,
                                font: font,

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.0* PdfPageFormat.cm),
                              bulletSize: 0.1*PdfPageFormat.cm,

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: 23 ),
                                child: pw.Text('चेहरे की चमक लाना\nपिंपल्स ऐव पिंपल्स के निशान हटाना\nजुरिया जुरिया हटाना' , style: pw.TextStyle(
                                    fontSize:  0.2* PdfPageFormat.cm,
                                    font:font))),

                            pw.SizedBox(height: 0.5*PdfPageFormat.cm),



                            //8
                            pw.Bullet(
                              text: 'ND YAG LASER',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: 0.3*PdfPageFormat.cm

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.1* PdfPageFormat.cm),
                              bulletSize: 0.1*PdfPageFormat.cm,

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: 23),
                                child: pw.Text('फोटो फेशियल\nकार्बन पील\nBirth Mark हटना\nTattoo हटना' , style: pw.TextStyle(
                                    fontSize:  0.2* PdfPageFormat.cm,
                                    font:font))),

                            pw.SizedBox(height: 0.5*PdfPageFormat.cm),


                            //9
                            pw.Bullet(
                              text: 'RF Machine',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: 0.3*PdfPageFormat.cm

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.1* PdfPageFormat.cm),
                              bulletSize: 0.1*PdfPageFormat.cm,

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: 23),
                                child: pw.Text('चेहरे व गले के मस हटाना\nतिल हटाना\nकान के छेद ठिक करना' , style: pw.TextStyle(
                                    fontSize:  0.2* PdfPageFormat.cm,
                                    font:font))),

                            pw.SizedBox(height: 0.5*PdfPageFormat.cm),



                            //10
                            pw.Bullet(
                              text: 'सेक्स समस्याए',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: 0.3*PdfPageFormat.cm,
                                font: font,

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.0* PdfPageFormat.cm ,),
                              bulletSize: 0.1*PdfPageFormat.cm,



                            ),

                            pw.SizedBox(height:0.5* PdfPageFormat.cm ),


                            //11
                            pw.Bullet(
                              text: 'BREAST CARE MACHINE',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: 0.3*PdfPageFormat.cm

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.1* PdfPageFormat.cm),
                              bulletSize: 0.1*PdfPageFormat.cm,

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: 23),
                                child: pw.Text('स्तन के आकार को बढ़ाना\nस्तन कसाव लाना में' , style: pw.TextStyle(
                                    fontSize:  0.2* PdfPageFormat.cm,
                                    font:font))),

                            pw.SizedBox(height: 0.5*PdfPageFormat.cm),


                            //12
                            pw.Bullet(
                              text: 'MICROBLADING , MICROPIGMENT',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: 0.3*PdfPageFormat.cm

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.1* PdfPageFormat.cm),
                              bulletSize: 0.1*PdfPageFormat.cm,

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: 23),
                                child: pw.Text('आइब्रो का आकार ठीक करना\nसफेद चकतो , होठों का रंग सही करना' , style: pw.TextStyle(
                                    fontSize:  0.2* PdfPageFormat.cm,
                                    font:font))),

                            pw.SizedBox(height: 0.5*PdfPageFormat.cm),

                            //12
                            pw.Bullet(
                              text: 'IONTOPHORESIS',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: 0.3*PdfPageFormat.cm

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.1* PdfPageFormat.cm),
                              bulletSize: 0.1*PdfPageFormat.cm,

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: 23),
                                child: pw.Text('हथेलि , पैर के तलवो पर अत्यधिक पासीना का इलाज' , style: pw.TextStyle(
                                    fontSize:  0.2* PdfPageFormat.cm,
                                    font:font))),

                            pw.SizedBox(height: 0.5*PdfPageFormat.cm),



                            //13
                            pw.Bullet(
                              text: 'BRIDE / GROOM Beauty Treatment Packages',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: 0.3*PdfPageFormat.cm,


                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.0* PdfPageFormat.cm ,),
                              bulletSize: 0.1*PdfPageFormat.cm,



                            ),

                            pw.SizedBox(height:0.5* PdfPageFormat.cm ),



                            //13
                            pw.Bullet(
                              text: 'Theard Lift , Botox\nDerma Planning\nVampire FaceLift',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: 0.3*PdfPageFormat.cm,


                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.0* PdfPageFormat.cm ,),
                              bulletSize: 0.1*PdfPageFormat.cm,



                            ),

                            pw.SizedBox(height:0.5* PdfPageFormat.cm ),


                            //13
                            pw.Bullet(
                              text: 'Hair Transplant',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: 0.3*PdfPageFormat.cm,


                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: 0.0* PdfPageFormat.cm ,),
                              bulletSize: 0.1*PdfPageFormat.cm,



                            ),

                            pw.SizedBox(height:0.5* PdfPageFormat.cm ),































                          ]
                      ),
                    )

                  ),

                  pw.Flexible(
                    flex: 2,

                      child: pw.Expanded(child:
                  pw.Row(
                    children: [
                      pw.Container(

                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.horizontal(
                            left: pw.Radius.circular(4),

                          ),
                          color: PdfColors.orangeAccent,

                        ),
                        height: 23*PdfPageFormat.cm,
                        width: 2,

                      ),

                      pw.SizedBox(width: 2),

                      pw.Container(
                        child: pw.Stack(
                          children: [


                            pw.Container(

                              width: 14*PdfPageFormat.cm,
                              height: 23*PdfPageFormat.cm,
                              color: PdfColors.white,
                              child:pw.Padding(
                                padding: pw.EdgeInsets.only(left: 1*PdfPageFormat.cm),
                                child:  pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,

                                    children: [

                                      pw.Text('Date : ${date==null?'122':date}' , style: pw.TextStyle(fontSize: 0.3*PdfPageFormat.cm)),
                                      pw.Text('Name : ${name==null?'122':name}' , style: pw.TextStyle(fontSize: 0.3*PdfPageFormat.cm)),
                                      pw.Text('Age : ${age==null?'122':age}' , style: pw.TextStyle(fontSize: 0.3*PdfPageFormat.cm)),
                                      pw.Text('Mobile No. : ${mobile==null?'122':mobile}' , style: pw.TextStyle(fontSize: 0.3*PdfPageFormat.cm)),

                                      pw.SizedBox(height:0.5*PdfPageFormat.cm),

                                      pw.Text('Notes:'),
                                      pw.Text(notes , style: pw.TextStyle(fontSize: 0.3*PdfPageFormat.cm)),

                                      pw.SizedBox(height:0.5*PdfPageFormat.cm),

                                      pw.Text('Diagnosis:'),
                                      pw.Column(
                                        children: diagnosis.map((e) {

                                          return pw.Bullet(
                                            text: e.toString().toUpperCase(),
                                            style: pw.TextStyle(fontSize: 0.3*PdfPageFormat.cm),
                                            bulletSize: 0.1*PdfPageFormat.cm,
                                           padding: pw.EdgeInsets.only(left: 0)



                                          );
                                        } ).toList()
                                      ),

                                      pw.SizedBox(height:0.5*PdfPageFormat.cm),


                                      pw.Table(
                                        children: []
                                      )





























                                    ]
                                ),
                              )







                            ),

                          pw.Opacity(
                            child:  pw.Center(child: pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Image(image , height: 8 * PdfPageFormat.cm , width: 8 * PdfPageFormat.cm ,),
                                pw.Text("Abhedya's" , style: pw.TextStyle(color: PdfColors.purple , fontSize: 40)),
                                pw.Text("Dermacare" , style: pw.TextStyle(color: PdfColors.orangeAccent , fontSize: 30)),

                              ],
                            )),

                            opacity: 0.1,

                          ),



                          ]
                        ),

                        width: 14*PdfPageFormat.cm,
                        height: 23*PdfPageFormat.cm,

                      )

                    ]
                  )


                      ) ),









                ]
              ),






            ]
          );

        },
      ),
    );

    return pdf.save();
  }

  }
