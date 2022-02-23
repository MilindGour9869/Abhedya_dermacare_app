import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/list_search.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';

import 'package:date_format/date_format.dart';


class AddVisits extends StatefulWidget {

  Patient_name_data_list data;

  String name;




  AddVisits(this.data , this.name);


  @override
  _AddVisitsState createState() => _AddVisitsState();
}

class _AddVisitsState extends State<AddVisits> {


  String complaints="Complaintes";
  String diagnosis="Diagnosis";
  String advices="Advices";
  String investigation="Investigation";
  String allergies="Allergies";
  String medicines="Medicines";
  String clinical_findings="Clinical Findings";




  Timestamp visit_date  = Timestamp.now();

  Timestamp followUp_date;


  void setdata(){

setState(() {

  visit_date = widget.data.visit_date;


  if(widget.data.diagnosis !=null)
  {
    widget.data.diagnosis.forEach((element) {
      diagnosis+=element+" ";

    });
  }


  if(widget.data.complaints != null)
  {
    print('complaint not null');
    complaints="";


    widget.data.complaints.forEach((element) {
      complaints += element +" ";

    });
  }

  if(widget.data.investigation != null)
  {
    print('complaint not null');
    investigation="";


    widget.data.investigation.forEach((element) {
      investigation += element +" ";

    });
  }

  if(widget.data.advices != null)
  {
    print('complaint not null');
    advices="";


    widget.data.advices.forEach((element) {
      advices += element +" ";

    });
  }

  if(widget.data.allergies != null)
  {
    print('complaint not null');
    allergies="";


    widget.data.allergies.forEach((element) {
      allergies += element +" ";

    });
  }

  if(widget.data.clinical_finding != null)
  {
    print('complaint not null');
    clinical_findings="";


    widget.data.clinical_finding.forEach((element) {
      clinical_findings += element +" ";

    });
  }












});

  }








  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init');


    if(widget.data.visit_date !=null)
      {
        print('visite date no null');

        setdata();




      }

    print(widget.data.visit_date==null);


  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: AppTheme.notWhite,
      appBar: AppBar(
        title: Text('Add Visits'),
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
                                child: Text(complaints==""?"Complaints":complaints),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                          print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'complaint', Group: 'Complaint', name: widget.name, date: formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                              complaints='';
                              a.forEach((element) {

                                complaints+=element +" ";


                              });

                              setState(() {
                                complaints=complaints;

                              });





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
                                child: Text(clinical_findings==""?"Clinical_findings":clinical_findings),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                          print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'clinical_finding', Group: 'Clinical_finding', name: widget.name, date: formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                              clinical_findings='';
                              a.forEach((element) {

                                clinical_findings+=element +" ";


                              });

                              setState(() {
                                clinical_findings=clinical_findings;

                              });





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
                                child: Text(diagnosis==""?"Diagnosis":diagnosis),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                          print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'diagnosis', Group: 'Diagnosis', name: widget.name, date: formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                              diagnosis='';
                              a.forEach((element) {

                                diagnosis+=element +" ";


                              });

                              setState(() {
                                diagnosis=diagnosis;

                              });





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
                                child: Text(investigation==""?"Investigation":investigation),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                          print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'investigation', Group: 'Investigation', name: widget.name, date: formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print('anccew');


                            print(a);


                             investigation='';




                              a.forEach((element) {

                                investigation+=element +" ";


                              });

                              print(investigation);


                              setState(() {
                                investigation=investigation;

                              });





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
                                child: Text(allergies==""?"Allergies":allergies),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                          print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'allergie', Group: 'Allergie', name: widget.name, date: formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                              allergies='';
                              a.forEach((element) {

                                allergies+=element +" ";


                              });

                              setState(() {
                                allergies=allergies;

                              });





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
                                child: Text(advices==""?"Advices":advices),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 4,),


                        IconButton(onPressed: ()async{



                          print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'advice', Group: 'advice', name: widget.name, date: formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

                          ).then((value)async{

                            print(value);

                            List a =  await value;

                            print(a);



                              advices='';
                              a.forEach((element) {

                                advices+=element +" ";


                              });

                              setState(() {
                                advices=advices;

                              });





                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                      ],
                    ),
                  ),
                ), // Advice










              ],
            ),
          ),
        ),
      ),
    );
  }
}
