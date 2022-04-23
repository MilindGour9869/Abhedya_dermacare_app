

import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart' as pw;


import 'dart:typed_data';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class PdfInvoiceApi {



  static Future<Uint8List> generatePdf( {

    String visit_date ,Map<String,dynamic> patient_detail , String patient_uid ,

    List notes , List diagnosis , List advice  , List allergies , List group , List complaint , List clinical_finding , List investigation , List blood_group ,

    Map<String,Map<String,dynamic>> medicinces , Map<String,dynamic> vitals ,

    String follow_up_date , bool hindi_dosage = true , bool hindi_duration = false




  }) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5 , compress: true);

    final logo = await imageFromAssetBundle('images/logo_without_background.png');
    final sign = await imageFromAssetBundle('images/sign.png');
    final playstore = await imageFromAssetBundle('images/playstore.png');
    final Qr = await imageFromAssetBundle('images/Qr.jpg');
    final Rx = await imageFromAssetBundle('images/Rx.png');


    final hindiFont = await fontFromAssetBundle('font/Martel-SemiBold.ttf');
    final engFont = await fontFromAssetBundle('font/RobotoSlab-Medium.ttf');

    int row=1;

    bool imgLeft =true;

   // print(diagnosis.isNotEmpty);





    var five  =  0.2*PdfPageFormat.cm;

    var three = 0.3*PdfPageFormat.cm;
    var two = 0.2*PdfPageFormat.cm;


    var one = 0.1*PdfPageFormat.cm;
    var bottom = 0.0* PdfPageFormat.cm;

    var bold = pw.FontWeight.bold;



    var purple = PdfColor.fromInt(0xff47017E);
    var orange = PdfColors.orangeAccent;



    pw.TableRow Date(String value){
      return pw.TableRow(
          children: [
            pw.Container(

              alignment: pw.Alignment.topRight,
            //  margin: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm),
              child:  pw.Row(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Text('Date : ', style: pw.TextStyle(
                     fontSize: three,
                      fontWeight: bold

                  ),

                  ),
                  pw.Text(value, style: pw.TextStyle(
                    fontSize: three,


                  ),

                  ),


                ]
              )

            )]
      );
    }

    pw.TableRow Patient_UID(String value){
      return pw.TableRow(
          children: [
            pw.Container(
              //  margin: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm),
                child:  pw.Row(
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      pw.Text('UID : ', style: pw.TextStyle(
                          fontSize: three,
                          fontWeight: bold

                      ),

                      ),
                      pw.Text(value, style: pw.TextStyle(
                        fontSize: three,


                      ),

                      ),


                    ]
                )

            )

          ]
      );
    }

    pw.TableRow Patient_detail({@required Map<String,dynamic>patient_detail}){
      return pw.TableRow(
          children: [
            pw.Container(
              //  margin: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm),
              child:  pw.Row(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text('Patient Details : ', style: pw.TextStyle(
                        fontSize: three,
                        fontWeight: bold

                    ),

                    ),
                    pw.Row(
                      children: [

                        pw.Text('${patient_detail['patient_name'].toString()} / ', style: pw.TextStyle(
                            fontSize: three,
                        ),),

                        pw.Text('${patient_detail['patient_gender'].toString()} / ', style: pw.TextStyle(
                          fontSize: three,
                        ),),

                        pw.Text('${patient_detail['patient_age'].toString()} / ', style: pw.TextStyle(
                          fontSize: three,
                        ),),

                        pw.Text('${patient_detail['mobile'].toString()}', style: pw.TextStyle(
                          fontSize: three,
                        ),),



                      ]
                    )


                  ]
              )

            )

          ]
      );
    }

    pw.TableRow Patient_Address(String value){
      return pw.TableRow(
          children: [
            pw.Container(
              //  margin: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm),
              child:  pw.Row(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text('Address : ', style: pw.TextStyle(
                        fontSize: three,
                        fontWeight: bold

                    ),

                    ),
                    pw.Text(value, style: pw.TextStyle(
                      fontSize: three,


                    ),

                    ),


                  ]
              )

            )

          ]
      );
    }

    pw.TableRow Vitals({@required Map<String,dynamic> vitals}){
      return pw.TableRow(
          children: [
            pw.Container(
              //  margin: pw.EdgeInsets.only(right: 1*PdfPageFormat.cm),
                child:  pw.Row(
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      pw.Text('Patient Details : ', style: pw.TextStyle(
                          fontSize: three,
                          fontWeight: bold

                      ),

                      ),
                      pw.Row(
                          children: vitals.keys.map((e) {
                            return pw.Text('${e.toString()} : ${vitals[e].toString()} / ', style: pw.TextStyle(
                              fontSize: three,
                            ),);
                          }).toList()

                      )


                    ]
                )

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

    pw.TableRow Box_null(){
      return pw.TableRow(
          children: [
            pw.Container()

          ]
      );
    }
    pw.Widget bullet(String value){

      value = value[0].toUpperCase() + value.substring(1).toLowerCase();

      return pw.Bullet(
        text: value,
        bulletShape: pw.BoxShape.rectangle,
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
    pw.TableRow Notes(List value){
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
                      children: value.map<pw.Widget>((e)=>bullet(e.toString())).toList()
                  )





                ]
              )

            )

          ]
      );
    }

    pw.TableRow Diagnosis(List value){
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
                          children: value.map<pw.Widget>((e)=>bullet(e.toString())).toList()

                      )





                    ]
                )

            )

          ]
      );
    }

    pw.TableRow Allergies(List value){
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
                          children: value.map<pw.Widget>((e)=>bullet(e.toString())).toList()

                      )





                    ]
                )

            )

          ]
      );
    }

    pw.TableRow Group(List value){
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
                          children: value.map<pw.Widget>((e)=>bullet(e.toString())).toList()

                      )





                    ]
                )

            )

          ]
      );
    }

    pw.TableRow Clinical_Finding(List value){
      return pw.TableRow(
          children: [
            pw.Container(
                width: 200,
                child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Clinical Findings :" , style: pw.TextStyle(
                          fontSize: three,
                          fontWeight: bold

                      ),),

                      pw.Column(
                          mainAxisSize: pw.MainAxisSize.min,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: value.map<pw.Widget>((e)=>bullet(e.toString())).toList()

                      )





                    ]
                )

            )

          ]
      );
    }

    pw.TableRow Complaint(List value){
      return pw.TableRow(
          children: [
            pw.Container(
                width: 200,
                child: pw.Column(
                    mainAxisSize: pw.MainAxisSize.min,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Complaint :" , style: pw.TextStyle(
                          fontSize: three,
                          fontWeight: bold

                      ),),

                      pw.Column(
                          mainAxisSize: pw.MainAxisSize.min,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: value.map<pw.Widget>((e)=>bullet(e.toString())).toList()

                      )





                    ]
                )

            )

          ]
      );
    }


   //Middle Table
    pw.TableRow MainTable({ Map<String , dynamic> map , List time , List add_info , String medicine_name , int sr_no} ){






      return pw.TableRow(


          children: [
            pw.Container(




              child:  pw.Text(sr_no.toString(), style: pw.TextStyle(
                  fontSize: three,

              )),),



            pw.Container(

              child:  pw.Text(medicine_name , style: pw.TextStyle(
                  fontSize: three,

              )),),

            pw.Container(



              child:  pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: time.map((e) {
                      if(e.toString()=='Morning')
                        {
                          return hindi_dosage?pw.Text('सुबह ' , style: pw.TextStyle(
                            font: hindiFont,
                              fontSize: three
                          )):pw.Text('Morning ' , style: pw.TextStyle(

                              fontSize: three
                          ));

                        }
                      if(e.toString()=='Afternoon')
                      {
                        return hindi_dosage?pw.Text('दोपहर ' , style: pw.TextStyle(
                            font: hindiFont,
                            fontSize: three
                        )):pw.Text('Afternoon ' , style: pw.TextStyle(

                            fontSize: three
                        ));

                      }
                      if(e.toString()=='Evening')
                      {
                        return hindi_dosage?pw.Text('शाम ' , style: pw.TextStyle(
                            font: hindiFont,
                            fontSize: three
                        )):pw.Text('Evening ' , style: pw.TextStyle(

                            fontSize: three
                        ));

                      }
                      if(e.toString()=='Night')
                      {
                        return hindi_dosage?pw.Text('रात ' , style: pw.TextStyle(
                            font: hindiFont,
                            fontSize: three
                        )):pw.Text('Night ' , style: pw.TextStyle(

                            fontSize: three
                        ));

                      }

                    }).toList()
                  ),
                  pw.Wrap(
                    spacing: one,

                    children: add_info.map((e) {
                      return pw.Text('${e} , ', style: pw.TextStyle(
                        fontSize: three,



                      ),
                        maxLines: 1

                      );

                    }).toList()
                  )
                ]
              ),),

            pw.Container(


              child:  pw.Row(
                children: [
                  pw.Text( map['tenure'].toString(), style: pw.TextStyle(
                      fontSize: three,

                  )),


                  hindi_duration?pw.Text( map['duration'].toString()=='Days'?' दिन':
                  map['duration'].toString()=='Weeks'?' सप्ताह':
                  map['duration'].toString()=='Months'?' महीना':''






                      , style: pw.TextStyle(
                      fontSize: three,

                        font: hindiFont
                  )):
      pw.Text( map['duration'].toString()=='Days'?' Days':
      map['duration'].toString()=='Weeks'?' Weeks':
      map['duration'].toString()=='Months'?' Months':''






      , style: pw.TextStyle(
      fontSize: three,


      )),


                ],
              ),),

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

    Map<String , Map<String , dynamic>> map1={

      'Medicine':{
        'sr_no':'Sr no.',
        'duration':'Duration',
        'dosage':'Dosage',
      }
    };

    pw.TableRow MainTableHead(){
      return pw.TableRow(


          children: [
            pw.Container(




              child:  pw.Text('Sr no.' , style: pw.TextStyle(
                  fontSize: three,
                  fontWeight: pw.FontWeight.bold
              )),),



            pw.Container(

              child:  pw.Text('Medicine' , style: pw.TextStyle(
                  fontSize: three,
                  fontWeight: pw.FontWeight.bold
              )),),

            pw.Container(



              child:  pw.Text('Dosage' , style: pw.TextStyle(
                  fontSize: three,

                  fontWeight: pw.FontWeight.bold

              )),),

            pw.Container(


              child:  pw.Text('Duration' , style: pw.TextStyle(
                  fontSize: three,
                  fontWeight: pw.FontWeight.bold
              )),),

          ]
      );

    }







    List<pw.TableRow> Abc=[

      MainTableHead(),
      MainDivider(),


    ];

   if(medicinces!=null)
     { print('\n');

       print(medicinces.length);

     int n=0;




     medicinces.forEach((key, value) {

       print(key);

       String duration ;
       List dosage;

       String add_info='';





       duration = medicinces[key]['duration']['tenure'].toString();
       dosage  =  medicinces[key]['add_info'];








       Map<String , dynamic> Duration={
         'tenure' : medicinces[key]['duration']['tenure'].toString(),
         'duration' : medicinces[key]['duration']['Duration'].toString()



       };

       print(Duration);







       Abc.add(MainTable( map:  Duration  , time: medicinces[key]['time'] , add_info :  medicinces[key]['add_info'] , sr_no:n , medicine_name: key ));

       Abc.add(MainDivider());

       print(Abc);

       n++;








     });
     }








    //Lower Widgets

    pw.TableRow Advice(List value){
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
                          children: value.map<pw.Widget>((e)=>bullet(e.toString())).toList()

                      )





                    ]
                )

            )

          ]
      );
    }

    pw.TableRow Investigation(List value){
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
                          children: value.map<pw.Widget>((e)=>bullet(e.toString())).toList()

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

              imgLeft?pw.Container(
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [

                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [

                          pw.Padding(


                              child: pw.Image(logo , height: 3 * PdfPageFormat.cm , width: 3 * PdfPageFormat.cm),
                              padding: pw.EdgeInsets.only(left: 1 * PdfPageFormat.cm)
                          ),



                          pw.Container(
                              padding: pw.EdgeInsets.only(right: 1 * PdfPageFormat.cm),
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                                  children: [

                                    pw.Text('डॉ. महिराम बिश्नोई' , style: pw.TextStyle(fontSize: 0.7 * PdfPageFormat.cm , font:hindiFont , color: purple , fontWeight: bold)),
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
                            color: purple,



                          ),
                          pw.SizedBox(width: 5),
                          pw.Column(
                              children: [
                                pw.Text("Abhedya's" , style: pw.TextStyle(fontSize: 0.4*PdfPageFormat.cm , fontWeight: bold , font: engFont )),
                                pw.Text("DERMACARE" , style: pw.TextStyle(fontSize: three , font: engFont ) )
                              ]
                          ),
                          pw.SizedBox(width: 5),
                          pw.Container(
                              color: orange,
                              height: 0.7*PdfPageFormat.cm,
                              padding: pw.EdgeInsets.only(right: 1.4*PdfPageFormat.cm),
                              width:18.0 * PdfPageFormat.cm,
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text('मॉडल बस स्टैंड के पास , कर्मचारी कॉलोनी रोड , नाथद्वारा , राजसमंद' , style: pw.TextStyle(
                                  font: hindiFont,
                                  fontSize: three
                              ))


                          ),



                        ]
                    ),
                  ]
                )



              ):pw.Container(

                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [





                          pw.Container(
                              padding: pw.EdgeInsets.only(left: 1 * PdfPageFormat.cm),
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [

                                    pw.Text('डॉ. महिराम बिश्नोई' , style: pw.TextStyle(fontSize: 0.7 * PdfPageFormat.cm , font:hindiFont , color: purple , fontWeight: bold)),
                                    pw.Text('Dr. Mahi Ram Bishnoi' , style: pw.TextStyle(fontSize: 0.5 * PdfPageFormat.cm , fontWeight: bold)),
                                    pw.Text('MBBS , DDV(SKIN),DEM(UK)' , style: pw.TextStyle(fontSize: 0.4 * PdfPageFormat.cm)),
                                    pw.Text('FAM(GERMANY),FAD,RMC-31777' , style: pw.TextStyle(fontSize: 0.4 * PdfPageFormat.cm)),
                                    pw.Text('Email:abhedyasdermacare@gmail.com' , style: pw.TextStyle(fontSize: three)),







                                  ]
                              ),


                          ),

                          pw.Padding(


                              child: pw.Image(logo , height: 3 * PdfPageFormat.cm , width: 3 * PdfPageFormat.cm),
                              padding: pw.EdgeInsets.only(right: 1 * PdfPageFormat.cm)
                          ),





                        ]
                    ),

                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [

                          pw.Container(
                              color: orange,
                              height: 0.7*PdfPageFormat.cm,
                              padding: pw.EdgeInsets.only(left: 1*PdfPageFormat.cm),
                              width:17.5 * PdfPageFormat.cm,
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('मॉडल बस स्टैंड के पास , कर्मचारी कॉलोनी रोड , नाथद्वारा , राजसमंद' , style: pw.TextStyle(
                                  font: hindiFont,
                                  fontSize: three
                              ))


                          ),


                          pw.SizedBox(width: 5),
                          pw.Column(
                              children: [
                                pw.Text("Abhedya's" , style: pw.TextStyle(fontSize: 0.4*PdfPageFormat.cm , fontWeight: bold , font: engFont )),
                                pw.Text("DERMACARE" , style: pw.TextStyle(fontSize: three , font: engFont ) )
                              ]
                          ),
                          pw.SizedBox(width: 5),

                          pw.Container(
                            height: 0.7*PdfPageFormat.cm,
                            width: 2*PdfPageFormat.cm,
                            color: purple,



                          ),





                        ]
                    ),
                  ]
                )
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


                            pw.SizedBox(height:  one),

                            pw.Container(
                              color: orange,
                              padding: pw.EdgeInsets.symmetric(horizontal: two),
                              child: pw.Text('उपलब्ध सुविधाऐ' , style: pw.TextStyle(fontSize: 0.5*PdfPageFormat.cm , font: hindiFont , fontWeight: bold)),
                            ),







                            pw.SizedBox(height:  five),



                            //1
                            pw.Bullet(
                              text: 'समस्त चर्म ऐव योन रोग',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                fontSize: three,
                                font: hindiFont,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
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
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                fontSize: three,
                                font: hindiFont,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
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
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two ),
                            child: pw.Text('अंचाहे बालो को हटाना' , style: pw.TextStyle(
                                fontSize:  three,
                                font:hindiFont,

                            ))),

                            pw.SizedBox(height: five),

                            //4
                            pw.Bullet(
                              text: 'फोटोथेरेपी',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                  font: hindiFont,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
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
                                        fontSize :three,
                                        font:hindiFont,



                                    )),
                                    pw.Text('सोरायसिस का इलाज' , style: pw.TextStyle(
                                        fontSize:  three,
                                        font:hindiFont,



                                    )),
                                  ]
                                )


                            ),

                            pw.SizedBox(height: five),



                            //5
                            pw.Bullet(
                              text: 'PRP , ACUGEL TREATMENT',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('Dark Circle हटाना\nचेहरे पर Glow(चमक)लाना' , style: pw.TextStyle(
                                    fontSize:  three,
                                    font:hindiFont,
                                  fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),

                            //6
                            pw.Bullet(
                              text: 'MNRF',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('पिंपल्स के खड्डे भरना\nचिकनपॉक्स के खड्डे भरना' , style: pw.TextStyle(
                                    fontSize:  three,
                                    font:hindiFont,
                                  fontWeight: bold

                                ))),

                            pw.SizedBox(height: five),


                            //7
                            pw.Bullet(
                              text: 'केमिकल पीलिंग',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                fontSize:three,
                                font: hindiFont,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two ),
                                child: pw.Text('चेहरे की चमक लाना\nपिंपल्स ऐव पिंपल्स के निशान हटाना\nजुरिया जुरिया हटाना' , style: pw.TextStyle(
                                    fontSize :three,
                                    font:hindiFont,
                                  fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),



                            //8
                            pw.Bullet(
                              text: 'ND YAG LASER',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('फोटो फेशियल\nकार्बन पील\nBirth Mark हटना\nTattoo हटना' , style: pw.TextStyle(
                                    fontSize :three,
                                    font:hindiFont,
                                  fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),


                            //9
                            pw.Bullet(
                              text: 'RF Machine',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('चेहरे व गले के मस हटाना\nतिल हटाना\nकान के छेद ठिक करना' , style: pw.TextStyle(
                                    fontSize :three,
                                    font:hindiFont ,
                                    fontWeight: bold))),

                            pw.SizedBox(height: five),



                            //10
                            pw.Bullet(
                              text: 'सेक्स समस्याए',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                fontSize: three,
                                font: hindiFont,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
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
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('स्तन के आकार को बढ़ाना\nस्तन कसाव लाना में' , style: pw.TextStyle(
                                    fontSize :three,
                                    font:hindiFont,
                                  fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),


                            //12
                            pw.Bullet(
                              text: 'MICROBLADING , MICROPIGMENT',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                fontWeight: bold

                              ),
                              bulletColor: purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('आइब्रो का आकार ठीक करना\nसफेद चकतो , होठों का रंग सही करना' , style: pw.TextStyle(
                                    fontSize :three,
                                    font:hindiFont,
                                  fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),

                            //12
                            pw.Bullet(
                              text: 'IONTOPHORESIS',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                  fontSize: three,
                                  fontWeight: bold

                              ),
                              bulletColor: purple,
                              margin: pw.EdgeInsets.only(bottom: bottom),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )

                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('हथेलि , पैर के तलवो पर अत्यधिक पासीना का इलाज' , style: pw.TextStyle(
                                    fontSize :three,
                                    font:hindiFont,
                                    fontWeight: bold


                                ))),

                            pw.SizedBox(height: five),



                            //13
                            pw.Bullet(
                              text: 'BRIDE / GROOM Beauty Treatment\nPackages',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                fontSize: three,
                                fontWeight: bold


                              ),
                              bulletColor: purple,
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
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                fontSize: three,
                                fontWeight: bold


                              ),
                              bulletColor: purple,
                              margin: pw.EdgeInsets.only(bottom: bottom ,),
                              bulletSize: one,
                                bulletMargin: pw.EdgeInsets.only(
                                    left:0 , right: one , top: 0.125*PdfPageFormat.cm
                                )



                            ),
                            pw.Padding(padding: pw.EdgeInsets.only(left: two),
                                child: pw.Text('Derma Plannign\nVampire FaceLift' , style: pw.TextStyle(
                                    fontSize:  three,

                                    fontWeight: bold


                                ))),

                            pw.SizedBox(height:five ),


                            //16
                            pw.Bullet(
                              text: 'Hair Transplant',
                              bulletShape: pw.BoxShape.rectangle,
                              style: pw.TextStyle(

                                fontSize: three,
                                fontWeight: bold


                              ),
                              bulletColor: purple,
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
                          color: orange,

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




                                                 visit_date!=null?Date(visit_date):Box_null(),

                                                 patient_uid!=null?Patient_UID(patient_uid):Box_null(),
                                                 patient_uid!=null?Box():Box_null(),

                                                 patient_detail!=null?Patient_detail(patient_detail:patient_detail):Box_null(),

                                                 patient_detail!=null?Patient_Address('Address'):Box_null(),

                                                 Box(),



                                                 vitals!=null?Vitals(vitals:vitals):Box_null(),

                                                 vitals!=null?Box():Box_null(),

                                                 notes!=null?Notes(notes):Box_null(),

                                                 notes!=null?Box():Box_null(),

                                                 diagnosis!=null?Diagnosis(diagnosis):Box_null(),

                                                 diagnosis!=null?Box():Box_null(),

                                                 allergies!=null?Allergies(allergies):Box_null(),

                                                 allergies!=null?Box():Box_null(),

                                                 group!=null?Group(group):Box_null(),

                                                 group!=null?Box():Box_null(),

                                                 complaint!=null?Complaint(complaint):Box_null(),

                                                 complaint!=null?Box():Box_null(),

                                                 clinical_finding!=null?Clinical_Finding(clinical_finding):Box_null(),

                                                 Box(),

                                               ]
                                           ),


                                           pw.Image(Rx , height: 1 * PdfPageFormat.cm , width: 0.7 * PdfPageFormat.cm),

                                           pw.SizedBox(height: five),








                                           medicinces!=null?pw.Table(



                                               columnWidths: {
                                                 0:pw.FractionColumnWidth(0.1),
                                                 1:pw.FractionColumnWidth(0.3),
                                                 2:pw.FractionColumnWidth(0.4),
                                                 3:pw.FractionColumnWidth(0.1),

                                               },

                                               children: Abc
                                           ):Box_null(),




                                           pw.Table(
                                               children: [
                                                 medicinces!=null?Box():Box_null(),
                                                 Box(),

                                                 advice!=null?Advice(['aaa']):Box_null(),
                                                 advice!=null?Box():Box_null(),


                                                 investigation!=null?Investigation(['aas']):Box_null(),
                                                 investigation!=null?Box():Box_null(),


                                                 follow_up_date!=null?pw.TableRow(
                                                   children: [
                                                     pw.Row(
                                                       children: [
                                                         pw.Text('Follow up Date : ' , style: pw.TextStyle(fontSize: three , fontWeight: bold)),
                                                         pw.Text('22 Apr 2022' , style: pw.TextStyle(fontSize: three )),

                                                       ]
                                                     )
                                                   ]
                                                 ):Box_null()

                                               ]
                                           ),
                                         ]
                                       )
                                     ),

                                    pw.Spacer(),


                                     pw.Row(
                                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                       children: [

                                         pw.Column(
                                           children: [
                                             pw.Image(Qr , height: 2 * PdfPageFormat.cm , width: 2 * PdfPageFormat.cm),
                                             pw.Row(
                                               children: [
                                                 pw.Text('Scan & Download the app from ' , style: pw.TextStyle(fontSize:three)),
                                                 pw.Image(playstore , height: 0.5 * PdfPageFormat.cm , width: 0.5 * PdfPageFormat.cm),

                                               ]
                                             ),
                                             pw.Text('to book appointment' , style: pw.TextStyle(fontSize:three)),

                                           ]
                                         ),

                                         pw.Column(
                                             crossAxisAlignment: pw.CrossAxisAlignment.end,
                                             children: [
                                               pw.Image(sign , height: 2 * PdfPageFormat.cm , width: 2 * PdfPageFormat.cm),
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
                                                pw.Text(' | ' , style: pw.TextStyle(color: orange)),
                                                pw.Text('HAIR' , style: pw.TextStyle(fontSize: three)),
                                                pw.Text(' | ' , style: pw.TextStyle(color: orange)),
                                                pw.Text('LASER' , style: pw.TextStyle(fontSize: three)),
                                                pw.Text(' | ' , style: pw.TextStyle(color: orange)),
                                                pw.Text('COSMETOLOGY' , style: pw.TextStyle(fontSize: three)),
                                                pw.Text(' | ' , style: pw.TextStyle(color: orange)),
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
                                pw.Image(logo , height: 9 * PdfPageFormat.cm , width: 9 * PdfPageFormat.cm ,),
                                pw.Text("Abhedya's" , style: pw.TextStyle(color: purple , fontSize: 43 , font: engFont )),
                                pw.Text("Dermacare" , style: pw.TextStyle(color: orange , fontSize: 33 , font: engFont )),

                              ],
                            )),

                            opacity: 0.6,

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
                    height: 0.6*PdfPageFormat.cm,
                    alignment: pw.Alignment.center,
                    color: orange,
                    child: pw.Text('जय श्री कृष्णा' , style: pw.TextStyle(
                      font: hindiFont,
                      fontSize: three
                    ))

                  ),
                  pw.SizedBox(height: one),
                  pw.Container(
                    width: 800,
                    height: 0.6*PdfPageFormat.cm,
                    color: purple,

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
