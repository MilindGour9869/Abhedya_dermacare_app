import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/list_search.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';



import 'package:date_format/date_format.dart';


class AddVisits extends StatefulWidget {

  Patient_name_data_list visit_data;
  Patient_name_data_list patient_data;


  String name;

  bool icon_tap;




  AddVisits({this.visit_data , this.name , this.icon_tap = false  , this.patient_data});


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

  String medicines="Medicines";

  //8
  List<String> Complaint =[];
  List<String> Diagnosis =[];
  List<String> Advices =[];
  List<String> Investigation =[];
  List<String> Allergies =[];
  List<String> Clinical_findings =[];
  List<String> Group =[];
  List<String> Blood_group =[];







  Timestamp visit_date  = Timestamp.now();

  Timestamp followUp_date;


  void setdata(){

setState(() {

  visit_date = widget.visit_data.visit_date;


  if(widget.visit_data.diagnosis !=null && widget.visit_data.diagnosis.isNotEmpty)
  {




    widget.visit_data.diagnosis.forEach((element) {

      Diagnosis.add(element);

    });
  }


  if(widget.visit_data.complaints != null && widget.visit_data.complaints.isNotEmpty)
  {






    widget.visit_data.complaints.forEach((element) {

      Complaint.add(element);


    });
  }

  if(widget.visit_data.investigation != null && widget.visit_data.investigation.isNotEmpty)
  {


    // print('investigation not null');



    widget.visit_data.investigation.forEach((element) {

      Investigation.add(element);

    });
  }

  if(widget.visit_data.advices != null && widget.visit_data.advices.isNotEmpty)
  {



    widget.visit_data.advices.forEach((element) {

      Advices.add(element);


    });
  }

  if(widget.visit_data.allergies != null && widget.visit_data.allergies.isNotEmpty )
  {


    widget.visit_data.allergies.forEach((element) {

      Allergies.add(element);


    });
  }

  if(widget.visit_data.clinical_finding != null && widget.visit_data.clinical_finding.isNotEmpty)
  {



    widget.visit_data.clinical_finding.forEach((element) {

      Clinical_findings.add(element);

    });
  }

  if(widget.visit_data.group != null && widget.visit_data.group.isNotEmpty)
  {


    widget.visit_data.group.forEach((element) {

      Group.add(element);

    });
  }

  if(widget.visit_data.blood_group != null && widget.visit_data.blood_group.isNotEmpty)
  {



    widget.visit_data.blood_group.forEach((element) {

      Blood_group.add(element);


    });
  }



});

  }








  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init');

    print(widget.patient_data.doc_id);


    if(widget.visit_data !=null)
      {
        print('visite date no null');

        setdata();




      }
    else
      {
        print(visit_date);
      }




  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: AppTheme.notWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.dark_teal,
        title: Text('Add Visits'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(onPressed: (){

              var visit_doc = FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).collection('visits').doc(formatDate(visit_date.toDate(), [dd, '-', mm, '-', yyyy ]).toString());
              var patient_doc = FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id);

              final json = {
                'complaint' : FieldValue.arrayUnion(Complaint),
                 'visit_date' : visit_date,
              };

              if(widget.icon_tap == true)
                {
                  visit_doc.set(json);
                  patient_doc.update({
                    'recent_visit' : visit_date
                  });

                }
              else if (widget.icon_tap == false)
                {
                  visit_doc.update(json);
                  patient_doc.update({
                    'recent_visit' : visit_date
                  });


                }



              Navigator.of(context).pop();



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

                    child: Card(child: Center(child: Text('${formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy])}')))), //date





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
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{



                         print(widget.patient_data.doc_id);


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'complaint', Group: 'Complaint', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

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
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'clinical_finding', Group: 'Clinical_finding', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

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
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'diagnosis', Group: 'Diagnosis', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

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
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'investigation', Group: 'Investigation', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

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



                              return  ListSearch(group: 'allergies', Group: 'Allergies', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

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



                              return  ListSearch(group: 'advices', Group: 'Advices', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

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



                              return  ListSearch(group: 'group', Group: 'Group', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

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
                      leading: Icon(Icons.add),

                      trailing: IconButton(onPressed: ()async{



                        // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                        showDialog(
                            context: context,
                            builder: (context)  {



                              return  ListSearch(group: 'blood-group', Group: 'Blood-Group', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

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
