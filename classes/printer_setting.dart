
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

    var five  =  0.3*PdfPageFormat.cm;

    var three = 0.3*PdfPageFormat.cm;
    var two = 0.3*PdfPageFormat.cm;


    var one = 0.1*PdfPageFormat.cm;
    var bottom = 0.0* PdfPageFormat.cm;

    var bold = pw.FontWeight.bold;

    pw.TableRow Date(String value){
      return pw.TableRow(
          children: [
            pw.Container(

              alignment: pw.Alignment.topRight,
            //  margin: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm),
              child:  pw.Text('Date : ${value}', style: pw.TextStyle(
                fontSize: three,

              ),

            )

            )]
      );
    }

    pw.TableRow Patient_detail(String value){
      return pw.TableRow(
          children: [
            pw.Container(
              //  margin: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm),
              child:  pw.Text(value , style: pw.TextStyle(
                fontSize: three,
              ),),

            )

          ]
      );
    }

    pw.TableRow Patient_Address(String value){
      return pw.TableRow(
          children: [
            pw.Container(
              //  margin: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm),
              child:  pw.Text(value , style: pw.TextStyle(
                fontSize: three,
              ),),

            )

          ]
      );
    }

    pw.TableRow Vitals(String value){
      return pw.TableRow(
          children: [
            pw.Container(
              //  margin: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm),
              child:  pw.Text(value , style: pw.TextStyle(
                fontSize: three,
              ),),

            )

          ]
      );
    }


    pw.TableRow SizedBox(){
      return pw.TableRow(
          children: [
            pw.Container(
              height: five

            )

          ]
      );
    }
    pw.Widget bullet(String value){

      value = value[0].toUpperCase() + value.substring(1).toLowerCase();

      return pw.Bullet(
        text: value,
        bulletShape: pw.BoxShape.circle,
        bulletMargin: pw.EdgeInsets.only(
          left: one , right: one , top: 0.125*PdfPageFormat.cm
        ),
        style: pw.TextStyle(

          fontSize: three,



        ),
        bulletColor: PdfColors.black,
        margin: pw.EdgeInsets.only(bottom: 0 ,),
        bulletSize: 0.07*PdfPageFormat.cm,



      );
    }



    pw.TableRow Notes(List<String> value){
      return pw.TableRow(
          children: [
            pw.Container(
             width: 200,
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Notes :" , style: pw.TextStyle(
                    fontSize: three,
                    fontWeight: bold

                  ),),

                  pw.Column(
                      mainAxisSize: pw.MainAxisSize.min,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: value.map<pw.Widget>(bullet).toList()
                  )





                ]
              )

            )

          ]
      );
    }

    pw.TableRow Diagnosis(List<String> value){
      return pw.TableRow(
          children: [
            pw.Container(
                width: 200,
                child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Diagnosis :" , style: pw.TextStyle(
                        fontSize: three,
                          fontWeight: bold

                      ),),

                      pw.Column(
                          mainAxisSize: pw.MainAxisSize.min,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: value.map<pw.Widget>(bullet).toList()
                      )





                    ]
                )

            )

          ]
      );
    }

    pw.TableRow Allergies(List<String> value){
      return pw.TableRow(
          children: [
            pw.Container(
                width: 200,
                child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Allergies :" , style: pw.TextStyle(
                        fontSize: three,
                          fontWeight: bold

                      ),),

                      pw.Column(
                          mainAxisSize: pw.MainAxisSize.min,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: value.map<pw.Widget>(bullet).toList()
                      )





                    ]
                )

            )

          ]
      );
    }

    pw.TableRow Advice(List<String> value){
      return pw.TableRow(
          children: [
            pw.Container(
                width: 200,
                child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Advice :" , style: pw.TextStyle(
                        fontSize: three,
                          fontWeight: bold

                      ),),

                      pw.Column(
                          mainAxisSize: pw.MainAxisSize.min,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: value.map<pw.Widget>(bullet).toList()
                      )





                    ]
                )

            )

          ]
      );
    }

    pw.TableRow Group(List<String> value){
      return pw.TableRow(
          children: [
            pw.Container(
                width: 200,
                child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Group :" , style: pw.TextStyle(
                        fontSize: three,
                          fontWeight: bold

                      ),),

                      pw.Column(
                          mainAxisSize: pw.MainAxisSize.min,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: value.map<pw.Widget>(bullet).toList()
                      )





                    ]
                )

            )

          ]
      );
    }

    pw.TableRow Table({ Map<String , String> map}){
      return pw.TableRow(

          children: [

           pw.Container(
             decoration: pw.BoxDecoration(
                 border: pw.Border(
                     bottom: pw.BorderSide(
                         width: 1
                     )
                 )
             ),
              padding: pw.EdgeInsets.only(top: 7,bottom: 7 ,right: 7),
              child:  pw.Text('${map['sr_no']}.' , style: pw.TextStyle(
                  fontSize: three
              )),),



            pw.SizedBox(width: 2),




            pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      bottom: pw.BorderSide(
                          width: 1
                      )
                  )
              ),
              padding: pw.EdgeInsets.only(top: 7,bottom: 7 ,right: 7),
              child:   pw.Text(map['medicine'].toUpperCase() , style: pw.TextStyle(
                  fontSize: three
              )),
            ),

            pw.SizedBox(width: 2),

            pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      bottom: pw.BorderSide(
                          width: 1
                      )
                  )
              ),
              padding: pw.EdgeInsets.only(top: 7,bottom: 7 ,right: 7),
              child:   pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(map['dosage_time'] , style: pw.TextStyle(
                      fontSize: three
                  )),
                  pw.Text(map['dosage_info']==null?"":map['dosage_info'] , style: pw.TextStyle(
                      fontSize: three
                  )),
                ]
              ),
            ),


            pw.SizedBox(width: 2),



            pw.Container(
              decoration: pw.BoxDecoration(
                  border: pw.Border(
                      bottom: pw.BorderSide(
                          width: 1
                      )
                  )
              ),
              padding: pw.EdgeInsets.only(top: 7,bottom: 7 ,right: 7),
              child:  pw.Row(
                children: [
                  pw.Text(map['duration '] , style: pw.TextStyle(
                      fontSize: three

                  )),
                  pw.Text('दिन' , style: pw.TextStyle(
                      fontSize: three,
                      font: font

                  )),

                ]
              ),
            ),



          ]
      );
    }












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

                        pw.Text('डॉ. महिराम ' , style: pw.TextStyle(fontSize: five , font:font , color: PdfColors.purple)),
                        pw.Text('Dr. Mahiram Bisnoi' , style: pw.TextStyle(fontSize: five)),
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
                        pw.Text("DERMACARE" , style: pw.TextStyle(fontSize: two) )
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
                      padding: pw.EdgeInsets.only(left: 0.7*PdfPageFormat.cm),
                      width: 6*PdfPageFormat.cm,

                      child: pw.Column(

                        mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,



                          children: [

                            pw.SizedBox(height:  five),

                           pw.Padding(
                             padding: pw.EdgeInsets.only(left: 1*PdfPageFormat.cm),
                             child:  pw.Text('उपलब्ध सुविधाऐ' , style: pw.TextStyle(fontSize: 0.5*PdfPageFormat.cm , font: font)),
                           ),

                            pw.SizedBox(height:  five),



                            //1
                            pw.Bullet(
                              text: 'समस्त चर्म ऐव योन रोग',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: three,
                                font: font,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom ,),
                              bulletSize: one,
                              bulletMargin: pw.EdgeInsets.only(
                                  left:0 , right: one , top: 0.125*PdfPageFormat.cm
                              )



                            ),

                            pw.SizedBox(height:five ),


                            //2
                            pw.Bullet(
                              text: 'नाखुन बालो से संबंधित रोग',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: three,
                                font: font,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom ,),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )



                            ),

                            pw.SizedBox(height:five ),




                            //3
                            pw.Bullet(
                              text: 'Triplle Wave Length Diode Laser',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two ),
                            child: pw.Text('अंचाहे बालो को हटाना' , style: pw.TextStyle(
                                fontSize:  two,
                                font:font,
                                fontWeight: bold
                            ))),

                            pw.SizedBox(height: five),

                            //4
                            pw.Bullet(
                              text: 'फोटोथेरेपी',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                  font: font,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two ),
                                child:  pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('सफेद दाग हटाना' , style: pw.TextStyle(
                                        fontSize:  two,
                                        font:font,
                                        fontWeight: bold


                                    )),
                                    pw.Text('सोरायसिस का इलाज' , style: pw.TextStyle(
                                        fontSize:  two,
                                        font:font,
                                        fontWeight: bold


                                    )),
                                  ]
                                )


                            ),

                            pw.SizedBox(height: five),



                            //5
                            pw.Bullet(
                              text: 'PRP , ACUGEL TREATMENT',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('DARK CIRCLE हटाना\nचेहरे पर GLOW(चमक)लाना' , style: pw.TextStyle(
                                    fontSize:  two,
                                    font:font,
                                  fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),

                            //6
                            pw.Bullet(
                              text: 'MNRF',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('पिंपल्स के खड्डे भरना\nचिकनपॉक्स के खड्डे भरना' , style: pw.TextStyle(
                                    fontSize:  two,
                                    font:font,
                                  fontWeight: bold

                                ))),

                            pw.SizedBox(height: five),


                            //7
                            pw.Bullet(
                              text: 'केमिकल पीलिंग',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: two,
                                font: font,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two ),
                                child: pw.Text('चेहरे की चमक लाना\nपिंपल्स ऐव पिंपल्स के निशान हटाना\nजुरिया जुरिया हटाना' , style: pw.TextStyle(
                                    fontSize:  two,
                                    font:font,
                                  fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),



                            //8
                            pw.Bullet(
                              text: 'ND YAG LASER',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('फोटो फेशियल\nकार्बन पील\nBirth Mark हटना\nTattoo हटना' , style: pw.TextStyle(
                                    fontSize:  two,
                                    font:font,
                                  fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),


                            //9
                            pw.Bullet(
                              text: 'RF Machine',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('चेहरे व गले के मस हटाना\nतिल हटाना\nकान के छेद ठिक करना' , style: pw.TextStyle(
                                    fontSize:  two,
                                    font:font ,
                                    fontWeight: bold))),

                            pw.SizedBox(height: five),



                            //10
                            pw.Bullet(
                              text: 'सेक्स समस्याए',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: three,
                                font: font,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom ,),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )



                            ),

                            pw.SizedBox(height:five ),


                            //11
                            pw.Bullet(
                              text: 'BREAST CARE MACHINE',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('स्तन के आकार को बढ़ाना\nस्तन कसाव लाना में' , style: pw.TextStyle(
                                    fontSize:  two,
                                    font:font,
                                  fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),


                            //12
                            pw.Bullet(
                              text: 'MICROBLADING , MICROPIGMENT',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('आइब्रो का आकार ठीक करना\nसफेद चकतो , होठों का रंग सही करना' , style: pw.TextStyle(
                                    fontSize:  two,
                                    font:font,
                                  fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),

                            //12
                            pw.Bullet(
                              text: 'IONTOPHORESIS',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                  fontWeight: bold

                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('हथेलि , पैर के तलवो पर अत्यधिक पासीना का इलाज' , style: pw.TextStyle(
                                    fontSize:  two,
                                    font:font,
                                    fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),



                            //13
                            pw.Bullet(
                              text: 'BRIDE / GROOM Beauty Treatment\nPackages',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: three,
                                fontWeight: bold


                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom ,),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )



                            ),

                            pw.SizedBox(height:five ),





                            //14
                            pw.Bullet(
                              text: 'Theard Lift , Botox',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: three,
                                fontWeight: bold


                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom ,),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )



                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('Derma Plannign\nVampire FaceLift' , style: pw.TextStyle(
                                    fontSize:  two,

                                    fontWeight: bold


                                ))),

                            pw.SizedBox(height:five ),


                            //16
                            pw.Bullet(
                              text: 'Hair Transplant',
                              bulletShape: pw.BoxShape.circle,
                              style: pw.TextStyle(

                                fontSize: three,
                                fontWeight: bold


                              ),
                              bulletColor: PdfColors.purple,
                              margin: pw.EdgeInsets.only(bottom: bottom ,),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )



                            ),

                            pw.SizedBox(height:five ),

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
                        height: 25*PdfPageFormat.cm,
                        width: 2,

                      ),

                      pw.SizedBox(width: 2),

                      pw.Container(
                        child: pw.Stack(
                          children: [


                            pw.Container(

                              width: 14*PdfPageFormat.cm,
                              height: 25*PdfPageFormat.cm,
                              margin: pw.EdgeInsets.only(top: three),
                              color: PdfColors.white,
                              child:pw.Padding(
                                padding: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm , left: 1*PdfPageFormat.cm),
                                child: pw.Column(
                                  children:[
                                     pw.Table(
                                         children:[

                                           Date('ss'),

                                           Patient_detail('Patient'),

                                           Patient_Address('Address'),

                                           SizedBox(),



                                           Vitals('Vitals'),

                                           SizedBox(),

                                           Notes(['Notes'  , 'note 2']),

                                           SizedBox(),

                                           Diagnosis(['Notes'  , 'note 2']),

                                           SizedBox(),

                                           Allergies(['Notes'  , 'note 2']),

                                           SizedBox(),

                                           Group(['Notes'  , 'note 2']),

                                           SizedBox(),




                                           SizedBox(),















                                         ]
                                     ),





                                  ]
                                )
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

                        width: 15*PdfPageFormat.cm,
                        height: 25*PdfPageFormat.cm,

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
