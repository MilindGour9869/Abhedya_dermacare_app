import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/Vitals.dart';
import 'package:flutter_app/widgets/list_search.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';





import 'package:date_format/date_format.dart';
import 'package:flutter_app/widgets/service_search_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/Medicines.dart';


class AddVisits extends StatefulWidget {


  Patient_name_data_list patient_data;

  String visit_date;

  Map<String , dynamic> map;





  bool icon_tap;










  AddVisits({ this.map , this.visit_date , this.icon_tap = false  , this.patient_data});


  @override
  _AddVisitsState createState() => _AddVisitsState();
}

class _AddVisitsState extends State<AddVisits> {


  String complaints="Complaints";
  String diagnosis="Diagnosis";
  String advices="Advices";
  String investigation="Investigation";
  String allergies="Allergies";
  String clinical_findings="Clinical Findings";
  String group = "Group";
  String blood_group="Blood Group";
  String service = "Services";
  String medicine = "Medicine";


  String img_complaint =  'images/complaint_color.webp';
  String img_clinical_finding_color =  'images/clinical_finding_color.png';
  String img_diagnosis =  'images/diagnosis.webp';
  String img_medicine_color =  'images/medicine_color.webp';
  String img_vital_color =  'images/vital_color.webp';
  String img_investigation_color =  'images/investigation_color.webp';



  //10
  List Complaint =[];
  List Diagnosis =[];
  List Advices =[];
  List Investigation =[];
  List Allergies =[];
  List Clinical_findings =[];
  List Group =[];
  List Blood_group =[];
  List Services =[];
  List<String> Medicine = [];


  Map<String  , Map<String , dynamic>> medicine_result={};
  Map<String  , Map<String , dynamic>> vital_result={};

  Map<String , dynamic> map;

  String visit_date;

  Timestamp date;


  dynamic set(List<String> list , Map<String , dynamic> map , String name){

    if(list.isNotEmpty)
      {
        map[name] = list;
        return map;

      }


  }








  Timestamp followUp_date;


  void setdata(){

setState(() {

 // Complaint = map['complaint'];

  if(map['complaint'] != null)
  {
     Complaint = map['complaint'];
  }
  if(map['investigation'] != null)
  {
      Investigation = map['investigation'];
  }
  if(map['diagnosis'] != null )
  {
      Diagnosis = map['diagnosis'];
  }
  if(map['advices'] != null)
  {
      Advices = map['advices'];
  }
  if(map['group'] != null)
  {
      Group = map['group'];
  }
  if(map['blood_group'] != null)
  {
      Blood_group = map['blood_group'];
  }
  if(map['allergies'] != null)
  {
      Allergies = map['allergies'];
  }
  if(map['service'] != null)
  {
      Services = map['service'];
  }
  if( map['clinical_finding'] != null)
  {
     Clinical_findings =  map['clinical_finding'];
  }
  if( map['medicine'] != null)
    {
      Medicine = map['medicine'];

    }










});

  }








  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init');



    print(widget.patient_data.hashCode);


    if(widget.map != null)
      {
        map = widget.map;


         setdata();




      }
    else
      {
        print('add visit init else ');
      }

    visit_date=widget.visit_date;





  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: AppTheme.notWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context , 'back');
          },
        ),
        title: Text('Add Visits'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(onPressed: (){

              var visit_doc = FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).collection('visits').doc(visit_date);
              var patient_doc = FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id);

              Map<String , dynamic> map ={};




              if(Complaint.isNotEmpty)
                {
                  map['complaint'] = Complaint;
                }
              if(Investigation.isNotEmpty)
              {
                map['investigation'] = Investigation;
              }
              if(Diagnosis.isNotEmpty)
              {
                map['diagnosis'] = Diagnosis;
              }
              if(Advices.isNotEmpty)
              {
                map['advices'] = Advices;
              }
              if(Group.isNotEmpty)
              {
                map['group'] = Group;
              }
              if(Blood_group.isNotEmpty)
              {
                map['blood_group'] = Blood_group;
              }
              if(Allergies.isNotEmpty)
              {
                map['allergies'] = Allergies;
              }
              if(Services.isNotEmpty)
              {
                map['service'] = Services;
              }
              if(Clinical_findings.isNotEmpty)
              {
                map['clinical_finding'] = Clinical_findings;
              }

              widget.patient_data.visits_mapData_list[visit_date]=map;


              if(visit_date == formatDate(Timestamp.now().toDate(), [ dd, '-', mm, '-', yyyy]).toString())
                {
                  map['visit_date'] = new Timestamp.now();
                  patient_doc.update({
                    'recent_visit' :Timestamp.now(),

                  } );

                }

              if(date != null)
                {
                  map['visit_date'] = date;
                  patient_doc.update({
                    'recent_visit' :date,


                  } );

                }











              visit_doc.set(map , SetOptions(merge: true));
















              Navigator.pop(context , 'save');



            }, icon: Icon(Icons.save)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.transparent,
           // height: MediaQuery.of(context).size.height*0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,





              children: [

                SizedBox(
                    height: MediaQuery.of(context).size.height*0.08,
                    width: MediaQuery.of(context).size.width*0.3,

                    child: Card(child: Center(child: TextButton(

                        child: Text('${visit_date}' , style: TextStyle(color: Colors.black),),
                        onPressed:(){
                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1947), lastDate: DateTime(2050)).then((value){
                            print(value);
                            setState(() {

                              date = Timestamp.fromDate(value);

                              visit_date = formatDate(Timestamp.fromDate(value).toDate(),[dd, '-', mm, '-', yyyy]).toString();
                            });
                          } );
                        } ,

                    )


                    ))), //date





                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(

                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(complaints),
                      ),
                      leading: Image.asset(img_complaint),

                      trailing: IconButton(onPressed: ()async{



                         print(widget.patient_data.doc_id);


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'complaint', Group: 'Complaint', patient_doc_id: widget.patient_data.doc_id, date: visit_date, patient_name_data_list: widget.patient_data,);}

                        ).then((value)async{

                          print(value);

                          if(value != null)
                          {
                            setState(() {
                              Complaint = value;
                            });


                          }
                        });










                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                     subtitle: Padding(
                       padding: const EdgeInsets.only(top: 8.0),
                       child: Container(

                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: Complaint.map<Widget>((e)=>DropDown(e) ).toList(),
                         ),
                       ),
                     ),
                    ),
                  ),
                ), // Complaint

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(

                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(clinical_findings),
                      ),
                      leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(img_clinical_finding_color ,)),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'clinical_finding', Group: 'Clinical_finding', patient_doc_id: widget.patient_data.doc_id, date: visit_date);}

                        ).then((value)async{

                          print(value);

                          if(value != null)
                          {
                            setState(() {
                              Clinical_findings = value;
                            });


                          }
                        });










                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Clinical_findings.map<Widget>((e)=>DropDown(e) ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), // Clinical Finding

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(



                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(diagnosis),
                      ),
                      leading: Image.asset(img_diagnosis),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'diagnosis', Group: 'Diagnosis', patient_doc_id: widget.patient_data.doc_id, date:visit_date);}

                        ).then((value)async{

                          print(value);

                          if(value != null)
                          {
                            setState(() {
                              Diagnosis = value;
                            });


                          }
                        });










                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Diagnosis.map<Widget>((e)=>DropDown(e) ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), // Diagnosis

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(




                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(investigation),
                      ),
                      leading: Image.asset(img_investigation_color),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'investigation', Group: 'Investigation', patient_doc_id: widget.patient_data.doc_id, date: visit_date);}

                        ).then((value)async{

                          print(value);

                          if(value != null)
                          {
                            setState(() {
                              Investigation = value;
                            });


                          }
                        });










                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Investigation.map<Widget>((e)=>DropDown(e) ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), // Investigation

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(

                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(allergies),
                      ),
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'allergies', Group: 'Allergies', patient_doc_id: widget.patient_data.doc_id, date:visit_date);}

                        ).then((value)async{

                          print(value);

                          if(value != null)
                          {
                            setState(() {
                              Allergies = value;
                            });


                          }
                        });










                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Allergies.map<Widget>((e)=>DropDown(e) ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), // Allergies

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(

                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(advices),
                      ),
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'advices', Group: 'Advices', patient_doc_id: widget.patient_data.doc_id, date: visit_date);}

                        ).then((value)async{

                          print(value);

                          if(value != null)
                          {
                            setState(() {
                              Advices = value;
                            });


                          }
                        });










                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Advices.map<Widget>((e)=>DropDown(e) ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), // Advices

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(

                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(group),
                      ),
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'group', Group: 'Group', patient_doc_id: widget.patient_data.doc_id, date: visit_date,);}

                        ).then((value)async{

                          print(value);

                          if(value != null)
                          {
                            setState(() {
                              Group = value;
                            });


                          }
                        });










                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Group.map<Widget>((e)=>DropDown(e) ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), // Group

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(

                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(blood_group),
                      ),
                      leading: Icon(FontAwesomeIcons.droplet , color: Colors.redAccent,),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'blood-group', Group: 'Blood-Group', patient_doc_id: widget.patient_data.doc_id, date: visit_date);}

                        ).then((value)async{

                          print(value);

                          if(value != null)
                          {
                            setState(() {
                              Blood_group = value;
                            });


                          }
                        });










                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Blood_group.map<Widget>((e)=>DropDown(e) ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), // Blood-Group

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(

                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(service),
                      ),
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context) {
                              return Service_Search_List( result: Services,
                              );

                            }).then((value)async{

                          print(value);

                          if(value != null)
                          {
                            setState(() {
                              Services=[];

                              Services = value;
                            });


                          }
                        });










                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Services.map<Widget>((e)=>DropDown(e) ).toList(),
                          ),
                        ),
                      ),


                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(

                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(medicine),
                      ),
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{

                        print(medicine_result);




                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Medicines(delete: false, name: Medicine,result_map: medicine_result,))).then((value) {

                          print('ccc');
                          print(value);


                          if(value != null)
                            { Medicine =[];

                              medicine_result = value;

                              setState(() {
                                Medicine = medicine_result.keys.toList();


                              });

                              print(Medicine);


                            }


                        });















                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Medicine.map<Widget>((e)=>DropDown(e) ).toList(),
                          ),
                        ),
                      ),


                    ),
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,


                    child: ListTile(

                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('vitals'),
                      ),
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{

                        print(vital_result);




                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Vital_List_Search())).then((value) {

                          print('ccc');
                          print(value);


                          if(value != null)
                          {

                          vital_result = value;



                          }


                        });















                      }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: Medicine.map<Widget>((e)=>DropDown(e) ).toList(),
                          ),
                        ),
                      ),


                    ),
                  ),
                ),









              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget DropDown (String menu)
{
  return Text(menu);
}
