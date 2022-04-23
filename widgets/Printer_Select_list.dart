import 'package:flutter/material.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../default.dart';

class Printer_Select_List extends StatefulWidget {

  List Complaint ;

  Patient_name_data_list patient_data;

  Printer_Select_List({this.Complaint});

  @override
  _Printer_Select_ListState createState() => _Printer_Select_ListState();
}

class _Printer_Select_ListState extends State<Printer_Select_List> {

  bool complaint_bool = false;
  bool clinical_finding_bool = false;
  bool diagnosis_bool = false;
  bool investigation_bool = false;
  bool allergies_bool = false;
  bool advice_bool = false;
  bool group_bool = false;
  bool blood_grp_bool = false;

  bool vital_bool = false;
  bool medicine_bool = true;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            child: Column(
                children: [

                  widget.Complaint.isNotEmpty?ListTile(
                    leading: CircleAvatar(

                      child: Icon(Icons.done , color: Colors.white,),
                      backgroundColor: complaint_bool?AppTheme.teal:Colors.grey,
                    ),
                    title: Text('Complaint'),
                    onTap: (){
                      setState(() {
                        complaint_bool = !complaint_bool;
                        print(complaint_bool);


                      });
                    },
                  ):Container(),










                ]
            ),
          )
        ],
      ),
    );
  }
}
