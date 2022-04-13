
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;


import 'dart:typed_data';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

//import 'package:flutter/material.dart' ;

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

    List<int> i =[1,2];


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


    pw.TableRow Box(){
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


    //Upper Widgets
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


   //Middle Table
    pw.TableRow MainTable({ Map<String , String> map}){
      return pw.TableRow(


          children: [
            pw.Container(




              child:  pw.Text('Sr no.' , style: pw.TextStyle(
                  fontSize: three
              )),),



            pw.Container(

              child:  pw.Text('Medicine' , style: pw.TextStyle(
                  fontSize: three
              )),),

            pw.Container(



              child:  pw.Text('Dosage' , style: pw.TextStyle(
                  fontSize: three
              )),),

            pw.Container(


              child:  pw.Text('Duration' , style: pw.TextStyle(
                  fontSize: three
              )),),

          ]
      );


    }

    pw.TableRow MainDivider(){
      return pw.TableRow(
          children: [

            pw.Container(
              margin: pw.EdgeInsets.only(right: one),
              child: pw.Divider(height: two),
            ),

            pw.Container(
              margin: pw.EdgeInsets.only(right: one),
              child: pw.Divider(height: two),
            ),

            pw.Container(
              margin: pw.EdgeInsets.only(right: one),
              child: pw.Divider(height: two),
            ),


            pw.Container(
              margin: pw.EdgeInsets.only(right: one),
              child: pw.Divider(height: two),
            ),


          ]
      );
    }


    List<pw.TableRow> Abc=[

      MainTable(),
      MainDivider(),

      MainTable(),
      MainDivider(),

      MainTable(),
      MainDivider(),

      MainTable(),
      MainDivider(),


    ];

    //Lower Widgets

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

    pw.TableRow Investigation(List<String> value){
      return pw.TableRow(
          children: [
            pw.Container(
                width: 200,
                child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Investigation :" , style: pw.TextStyle(
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












    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm, marginTop:0.4 * PdfPageFormat.cm  ),

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

                        pw.Text('डॉ. महिराम बिश्नोई' , style: pw.TextStyle(fontSize: 0.7 * PdfPageFormat.cm , font:font , color: PdfColors.purple , fontWeight: bold)),
                        pw.Text('Dr. Mahi Ram Bishnoi' , style: pw.TextStyle(fontSize: 0.5 * PdfPageFormat.cm , fontWeight: bold)),
                        pw.Text('MBBS , DDV(SKIN),DEM(UK)' , style: pw.TextStyle(fontSize: 0.4 * PdfPageFormat.cm)),
                        pw.Text('FAM(GERMANY),FAD,RMC-31777' , style: pw.TextStyle(fontSize: 0.4 * PdfPageFormat.cm)),
                        pw.Text('Email:abhedyasdermacare@gmail.com' , style: pw.TextStyle(fontSize: three)),







                      ]
                    )
                  ),





                ]
              ),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    height: 0.7*PdfPageFormat.cm,
                    width: 1*PdfPageFormat.cm,
                    color: PdfColors.purple,



                  ),
                  pw.SizedBox(width: 5),
                  pw.Column(
                      children: [
                        pw.Text("Abhedya's" , style: pw.TextStyle(fontSize: 0.4*PdfPageFormat.cm , fontWeight: bold )),
                        pw.Text("DERMACARE" , style: pw.TextStyle(fontSize: three) )
                      ]
                  ),
                  pw.SizedBox(width: 5),
                  pw.Container(
                    color: PdfColors.orangeAccent,
                    height: 0.7*PdfPageFormat.cm,
                    padding: pw.EdgeInsets.only(right: 1.4*PdfPageFormat.cm),
                    width:18.0 * PdfPageFormat.cm,
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text('मॉडल बस स्टैंड के पास , कर्मचारी कॉलोनी रोड , नाथद्वारा , राजसमंद' , style: pw.TextStyle(
                      font: font,
                      fontSize: three
                    ))


                  ),



                ]
              ),

              pw.Row(
                children: [
                  pw.Flexible(
                    flex: 1,
                    child:pw.Container(
                      padding: pw.EdgeInsets.only(left: 0.7*PdfPageFormat.cm),
                      width: 6.3*PdfPageFormat.cm,

                      child: pw.Column(

                        mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,



                          children: [

                            pw.SizedBox(height:  two),


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
                        height: 23.5*PdfPageFormat.cm,
                        width: 2,

                      ),

                      pw.SizedBox(width: 2),

                      pw.Container(
                        child: pw.Stack(
                          children: [


                            pw.Container(

                              width: 14*PdfPageFormat.cm,
                              height: 23.9*PdfPageFormat.cm,
                              margin: pw.EdgeInsets.only(top:0.7*PdfPageFormat.cm ),
                              color: PdfColors.white,
                              child:pw.Padding(
                                padding: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm , left: 1*PdfPageFormat.cm),
                                child: pw.Column(
                                  children:[
                                     pw.Container(
                                       child: pw.Column(
                                         crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                                         children: [
                                           pw.Table(
                                               children:[

                                                 Date('ss'),

                                                 Patient_detail('Patient'),

                                                 Patient_Address('Address'),

                                                 Box(),



                                                 Vitals('Vitals'),

                                                 Box(),

                                                 Notes(['Notes'  , 'note 2']),

                                                 Box(),

                                                 Diagnosis(['Notes'  , 'note 2']),

                                                 Box(),

                                                 Allergies(['Notes'  , 'note 2']),

                                                 Box(),

                                                 Group(['Notes'  , 'note 2']),



                                                 Box(),




                                                 Box(),

















                                               ]
                                           ),


                                           pw.Table(



                                               columnWidths: {
                                                 0:pw.FractionColumnWidth(0.1),
                                                 1:pw.FractionColumnWidth(0.3),
                                                 2:pw.FractionColumnWidth(0.4),
                                                 3:pw.FractionColumnWidth(0.1),

                                               },

                                               children: Abc
                                           ),




                                           pw.Table(
                                               children: [
                                                 Box(),
                                                 Box(),
                                                 Advice(['aaa']),


                                                 Box(),
                                                 Investigation(['aas']),

                                               ]
                                           ),
                                         ]
                                       )
                                     ),

                                    pw.Spacer(),


                                     pw.Row(
                                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                       children: [

                                         pw.Text('Qr Code'),

                                         pw.Column(
                                             crossAxisAlignment: pw.CrossAxisAlignment.end,
                                             children: [
                                               pw.Text('Dr. Mahi Ram Bishnoi' , style: pw.TextStyle(fontSize: three , fontWeight: bold)),
                                               pw.Text('(MBBS,DDV (SKIN)),' , style: pw.TextStyle(fontSize: three ,)),
                                               pw.Text('DEM(UK),FAM(GERMANY),FAD' , style: pw.TextStyle(fontSize: three , )),
                                               pw.Text('RMC-31777,MMC-2017105198' , style: pw.TextStyle(fontSize: three , )),

                                             ]
                                         ),
                                       ]
                                     ),



                                    pw.SizedBox(
                                      height:1*PdfPageFormat.cm
                                    ),



                                    pw.Container(

                                      child: pw.Column(
                                        children: [
                                          pw.Row(
                                              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                              children: [
                                                pw.Text('SKIN' , style: pw.TextStyle(fontSize: three) ),
                                                pw.Text(' | ' , style: pw.TextStyle(color: PdfColors.orangeAccent)),
                                                pw.Text('HAIR' , style: pw.TextStyle(fontSize: three)),
                                                pw.Text(' | ' , style: pw.TextStyle(color: PdfColors.orangeAccent)),
                                                pw.Text('LASER' , style: pw.TextStyle(fontSize: three)),
                                                pw.Text(' | ' , style: pw.TextStyle(color: PdfColors.orangeAccent)),
                                                pw.Text('COSMETOLOGY' , style: pw.TextStyle(fontSize: three)),
                                                pw.Text(' | ' , style: pw.TextStyle(color: PdfColors.orangeAccent)),
                                                pw.Text('HAIR TRANSPLANT CLINIC' , style: pw.TextStyle(fontSize: three)),
                                              ]
                                          ),


                                        ]
                                      )
                                    )




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

                            opacity: 0.2,

                          ),



                          ]
                        ),

                        width: 15*PdfPageFormat.cm,
                        height: 23.9*PdfPageFormat.cm,
                        color: PdfColors.white,

                      )

                    ]
                  )


                      ) ),









                ]
              ),


              pw.Spacer(),

              pw.Column(
                children: [
                  pw.Container(
                    width: 800,
                    height: 0.7*PdfPageFormat.cm,
                    color: PdfColors.orangeAccent,

                  ),
                  pw.SizedBox(height: one),
                  pw.Container(
                    width: 800,
                    height: 0.7*PdfPageFormat.cm,
                    color: PdfColors.purple,

                  ),
                ]
              )







            ]
          );

        },
      ),
    );



    return pdf.save();
  }


  }
