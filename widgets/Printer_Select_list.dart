import 'package:flutter/material.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';
import 'package:flutter_app/classes/printer_setting.dart';
import 'package:printing/printing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../default.dart';

class Printer_Select_List extends StatefulWidget {

  Map<String , dynamic> map_list = {};

  Patient_name_data_list patient_data;

  Printer_Select_List({this.map_list});

  @override
  _Printer_Select_ListState createState() => _Printer_Select_ListState();
}

class _Printer_Select_ListState extends State<Printer_Select_List> {

  Map<String , bool> map_bool = {

    'Complaint' : true,
    'Clinical Finding' : true,
    'Investigation' : true ,
    'Notes' : true ,
    'Diagnosis' : true ,
    'Allergies' : true ,
    'Advices' : true ,
    'Group' : true ,
    'Blood group' : true ,

    'Medicine' : true ,
    'Vitals' : true,

    'Visit Date' : true ,

    'Patient Detail': true ,

    'UID' : true,

    'Follow up date' :true,


  };



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 6.w , vertical : 2.h) ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            child: Column(
              children: [

                Text('Select Which to Print' , style: TextStyle(fontWeight: FontWeight.bold),),

                SizedBox(height: 1.h,),


                SizedBox(
                  height: 70.h,
                  child: SingleChildScrollView(
                    child: Column(

                        children : widget.map_list.keys.map((key) {

                          return widget.map_list[key]!=null?ListTile(
                            leading: CircleAvatar(

                              child: Icon(Icons.done , color: Colors.white,),
                              backgroundColor: map_bool[key]?AppTheme.teal:Colors.grey,
                            ),
                            title: Text(key),
                            onTap: (){
                              setState(() {
                                map_bool[key] = !map_bool[key];



                              });
                            },
                          ):Container();
                        }).toList(),
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 2,
                ),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey
                        ),
                        child: TextButton(onPressed: (){



                          Navigator.pop(context);


                        }, child: Text('Cancel' , style: TextStyle(color: Colors.white),)),
                      ),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppTheme.teal
                        ),
                        child: TextButton(onPressed: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PdfPreview(

                            build: ((format)=>PdfInvoiceApi.generatePdf(

                              visit_date: map_bool['Visit Date']?widget.map_list['Visit Date']:null ,

                              patient_detail: map_bool['Patient Detail']?widget.map_list['Patient Detail']:null ,

                              patient_uid: map_bool['UID']?widget.map_list['UID']:null ,

                              medicine_map: map_bool['Medicine']?widget.map_list['Medicine'].isEmpty?null:widget.map_list['Medicine']:null ,

                              vitals: map_bool['Vitals']?widget.map_list['Vitals'].isEmpty?null:widget.map_list['Vitals']:null ,



                              notes: map_bool['Notes']?widget.map_list['Notes'].isEmpty?null:widget.map_list['Notes']:null ,

                              diagnosis: map_bool['Diagnosis']?widget.map_list['Diagnosis'].isEmpty?null:widget.map_list['Diagnosis']:null ,

                              advice: map_bool['Advices']?widget.map_list['Advices'].isEmpty?null:widget.map_list['Advices']:null ,

                              allergies: map_bool['Allergies']?widget.map_list['Allergies'].isEmpty?null:widget.map_list['Allergies']:null ,

                              clinical_finding: map_bool['Clinical Finding']?widget.map_list['Clinical Finding'].isEmpty?null:widget.map_list['Clinical Finding']:null ,

                              complaint: map_bool['Complaint']?widget.map_list['Complaint'].isEmpty?null:widget.map_list['Complaint']:null ,

                              blood_group: map_bool['Blood group']?widget.map_list['Blood group'].isEmpty?null:widget.map_list['Blood group']:null ,

                              group: map_bool['Group']?widget.map_list['Group'].isEmpty?null:widget.map_list['Group']:null ,

                              investigation: map_bool['Investigation']?widget.map_list['Investigation'].isEmpty?null:widget.map_list['Investigation']:null ,



                              follow_up_date: map_bool['Follow up date']?widget.map_list['Follow up date']:null ,


                            )),



                          )));

                        }, child: Text('Print' , style: TextStyle(color: Colors.white),)),
                      ),

                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
