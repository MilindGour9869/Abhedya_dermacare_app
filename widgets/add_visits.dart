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

  List<String> Complaint =[];


  Map<String,bool> map={
    'complaints' : false,
    'diagnosis' : false,
    'advices':false,
    'investigation':false,
    'allergies':false,
    'clinical_findings':false,
    'group':false,
    'blood_group':false,
   };

  String s = "  ,  ";





  Timestamp visit_date  = Timestamp.now();

  Timestamp followUp_date;


  void setdata(){

setState(() {

  visit_date = widget.visit_data.visit_date;


  if(widget.visit_data.diagnosis !=null && widget.visit_data.diagnosis.isNotEmpty)
  {
    map['diagnosis']=true;

    print('diagnosis not null');
    diagnosis="";
    widget.visit_data.diagnosis.forEach((element) {
      diagnosis+=element + s ;

    });
  }


  if(widget.visit_data.complaints != null && widget.visit_data.complaints.isNotEmpty)
  {
    map['complaints']=true;

    print('complaint not null');
    complaints="";


    widget.visit_data.complaints.forEach((element) {
      complaints += element + s;
      Complaint.add(element);


    });
  }

  if(widget.visit_data.investigation != null && widget.visit_data.investigation.isNotEmpty)
  {
    map['investigation']=true;

    print('investigation not null');
    investigation="";


    widget.visit_data.investigation.forEach((element) {
      investigation += element + s;

    });
  }

  if(widget.visit_data.advices != null && widget.visit_data.advices.isNotEmpty)
  {
    map['advices']=true;

    print('advices not null');
    advices="";


    widget.visit_data.advices.forEach((element) {
      advices += element + s;


    });
  }

  if(widget.visit_data.allergies != null && widget.visit_data.allergies.isNotEmpty )
  {
    map['allergies']=true;

    print('allergies not null');
    allergies="";


    widget.visit_data.allergies.forEach((element) {
      allergies += element + s;


    });
  }

  if(widget.visit_data.clinical_finding != null && widget.visit_data.clinical_finding.isNotEmpty)
  {
    map['clinical_findings']=true;
    print('clinical finding not null');
    clinical_findings="";


    widget.visit_data.clinical_finding.forEach((element) {
      clinical_findings += element + s;

    });
  }

  if(widget.visit_data.group != null && widget.visit_data.group.isNotEmpty)
  {
    map['group']=true;

    print('group not null');
    group="";


    widget.visit_data.group.forEach((element) {
      group += element + s;

    });
  }

  if(widget.visit_data.blood_group != null && widget.visit_data.blood_group.isNotEmpty)
  {
    map['blood_group']=true;
    print('blood-group not null');
    blood_group="";


    widget.visit_data.blood_group.forEach((element) {
      blood_group += element + s ;

    });
  }



});

  }








  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init');

    print(widget.visit_data.doc_id);


    if(widget.visit_data.visit_date !=null)
      {
        print('visite date no null');

        setdata();




      }

    print(widget.visit_data.visit_date==null);


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

              var visit_doc = FirebaseFirestore.instance.collection('Patient').doc(widget.visit_data.doc_id).collection('visits').doc(formatDate(visit_date.toDate(), [dd, '-', mm, '-', yyyy ]).toString());
              var patient_doc = FirebaseFirestore.instance.collection('Patient').doc(widget.visit_data.doc_id);

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
            height: MediaQuery.of(context).size.height*0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,





              children: [

                SizedBox(
                    height: MediaQuery.of(context).size.height*0.08,
                    width: MediaQuery.of(context).size.width*0.3,

                    child: Card(child: Center(child: Text('${formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy])}')))), //date





                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Card(
                    color: AppTheme.white,
                    child: Row(
                      children: [
                        SizedBox(width: 7,),
                        Icon(Icons.comment),
                        SizedBox(width: 7,),

                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context){

                                  return Column(
                                    children: []
                                  );

                                }
                              );
                            },
                            child: Container(
                              width:  MediaQuery.of(context).size.width*0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(complaints , style: TextStyle(color: map['complaints']?Colors.black:Colors.grey),),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                         // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'complaint', Group: 'Complaint', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            if(value != null)
                              {
                                Complaint = value;


                              }

                            List a =  await value;

                            print(a);



                              complaints='';
                              a.forEach((element) {

                                complaints+=element + s;


                              });

                              if(complaints != "")
                                {
                                  setState(() {
                                    complaints=complaints;
                                    map['complaints']=true;

                                  });
                                }
                              else
                                {
                                  setState(() {
                                    complaints="Complaints";
                                    map['complaints']=false;

                                  });

                                }





                          });


                         







                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                      ],
                    ),
                  ),
                ), // Complaint

                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Card(
                    color: AppTheme.white,
                    child: Row(
                      children: [
                        SizedBox(width: 7,),
                        Icon(Icons.note),
                        SizedBox(width: 7,),

                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context){

                                    return Column(
                                        children: []
                                    );

                                  }
                              );
                            },
                            child: Container(
                              width:  MediaQuery.of(context).size.width*0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(clinical_findings , style: TextStyle(color:map['clinical_findings']?Colors.black:Colors.grey),),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'clinical_finding', Group: 'Clinical_finding', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                              clinical_findings='';
                              a.forEach((element) {

                                clinical_findings+=element + s;


                              });

                            if(clinical_findings != "")
                            {
                              setState(() {
                                clinical_findings=clinical_findings;
                                map['clinical_findings']=true;

                              });
                            }
                            else
                            {
                              setState(() {
                                clinical_findings="Clinical Finding";
                                map['clinical_findings']=false;

                              });

                            }





                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                      ],
                    ),
                  ),
                ), // Clinical finding

                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Card(
                    color: AppTheme.white,
                    child: Row(
                      children: [
                        SizedBox(width: 7,),
                        Icon(Icons.seven_k),
                        SizedBox(width: 7,),

                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context){

                                    return Column(
                                        children: []
                                    );

                                  }
                              );
                            },
                            child: Container(
                              width:  MediaQuery.of(context).size.width*0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(diagnosis , style: TextStyle(color: map['diagnosis']?Colors.black:Colors.grey),),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                          print(formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'diagnosis', Group: 'Diagnosis', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                              diagnosis='';
                              a.forEach((element) {

                                diagnosis+=element + s;


                              });

                            if(diagnosis!= "")
                            {
                              setState(() {
                                diagnosis=diagnosis;
                                map['diagnosis']=true;

                              });
                            }
                            else
                            {
                              setState(() {
                                diagnosis="Diagnosis";
                                map['diagnosis']=false;

                              });

                            }




                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                      ],
                    ),
                  ),
                ), // Diagnosis

                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Card(
                    color: AppTheme.white,
                    child: Row(
                      children: [
                        SizedBox(width: 7,),
                        Icon(Icons.seven_k),
                        SizedBox(width: 7,),

                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context){

                                    return Column(
                                        children: []
                                    );

                                  }
                              );
                            },
                            child: Container(
                              width:  MediaQuery.of(context).size.width*0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(investigation , style: TextStyle(color: map['investigation']?Colors.black:Colors.grey),),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                        //  print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'investigation', Group: 'Investigation', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print('anccew');


                            print(a);


                             investigation='';




                              a.forEach((element) {

                                investigation+=element + s;


                              });

                              print(investigation);

                            if(investigation!= "")
                            {
                              setState(() {
                                investigation=investigation;
                                map['investigation']=true;

                              });
                            }
                            else
                            {
                              setState(() {
                                investigation="Investigation";
                                map['investigation']=false;

                              });

                            }








                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                      ],
                    ),
                  ),
                ), // Investigation

                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Card(
                    color: AppTheme.white,
                    child: Row(
                      children: [
                        SizedBox(width: 7,),
                        Icon(Icons.seven_k),
                        SizedBox(width: 7,),

                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context){

                                    return Column(
                                        children: []
                                    );

                                  }
                              );
                            },
                            child: Container(
                              width:  MediaQuery.of(context).size.width*0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(allergies, style: TextStyle(color: map['allergies']?Colors.black:Colors.grey),),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                          //print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'allergie', Group: 'Allergie', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                              allergies='';
                              a.forEach((element) {

                                allergies+=element + s;


                              });

                            if(allergies!= "")
                            {
                              setState(() {
                                allergies=allergies;
                                map['allergies']=true;

                              });
                            }
                            else
                            {
                              setState(() {
                                allergies="Allergies";
                                map['allergies']=false;

                              });

                            }





                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                      ],
                    ),
                  ),
                ), // Allergie

                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Card(
                    color: AppTheme.white,
                    child: Row(
                      children: [
                        SizedBox(width: 7,),
                        Icon(Icons.seven_k),
                        SizedBox(width: 7,),

                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context){

                                    return Column(
                                        children: []
                                    );

                                  }
                              );
                            },
                            child: Container(
                              width:  MediaQuery.of(context).size.width*0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(advices , style:  TextStyle(color: map['advices']?Colors.black:Colors.grey),),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                      //    print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'advice', Group: 'advice', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                              advices='';
                              a.forEach((element) {

                                advices+=element + s;


                              });

                            if(advices!= "")
                            {
                              setState(() {
                                advices=advices;
                                map['advices']=true;

                              });
                            }
                            else
                            {
                              setState(() {
                                advices="Advices";
                                map['advices']=false;

                              });

                            }





                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                      ],
                    ),
                  ),
                ), // Advice

                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Card(
                    color: AppTheme.white,
                    child: Row(
                      children: [
                        SizedBox(width: 7,),
                        Icon(Icons.seven_k),
                        SizedBox(width: 7,),

                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context){

                                    return Column(
                                        children: []
                                    );

                                  }
                              );
                            },
                            child: Container(
                              width:  MediaQuery.of(context).size.width*0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(group , style: TextStyle(color: map['group']?Colors.black:Colors.grey),),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



//                          print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'group', Group: 'Group', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                            group='';
                            a.forEach((element) {

                              group+=element + s;


                            });

                            if(group!= "")
                            {
                              setState(() {
                                group=group;
                                map['group']=true;

                              });
                            }
                            else
                            {
                              setState(() {
                                group="Group";
                                map['group']=false;

                              });

                            }





                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                      ],
                    ),
                  ),
                ), // Group

                SizedBox(
                  height: MediaQuery.of(context).size.height*0.1,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Card(
                    color: AppTheme.white,
                    child: Row(
                      children: [
                        SizedBox(width: 7,),
                        Icon(Icons.seven_k),
                        SizedBox(width: 7,),

                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (context){

                                    return Column(
                                        children: []
                                    );

                                  }
                              );
                            },
                            child: Container(
                              width:  MediaQuery.of(context).size.width*0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child:  Text(blood_group , style: TextStyle(color: map['blood_group']?Colors.black:Colors.grey),),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



//                          print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'blood-group', Group: 'Blood-Group', patient_doc_id: widget.patient_data.doc_id, date: formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                            blood_group='';
                            a.forEach((element) {

                              blood_group+=element + s;


                            });

                            if(blood_group!= "")
                            {
                              setState(() {
                                blood_group=blood_group;
                                map['blood_group']=true;

                              });
                            }
                            else
                            {
                              setState(() {
                                blood_group="Blood Group";
                                map['blood_group']=false;

                              });

                            }




                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                      ],
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
