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


  String complaints="Complaints";
  String diagnosis="Diagnosis";
  String advices="Advices";
  String investigation="Investigation";
  String allergies="Allergies";
  String clinical_findings="Clinical Findings";
  String group = "Group";
  String blood_group="Blood Group";

  String medicines="Medicines";

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

  visit_date = widget.data.visit_date;


  if(widget.data.diagnosis !=null && widget.data.diagnosis.isNotEmpty)
  {
    map['diagnosis']=true;

    print('diagnosis not null');
    diagnosis="";
    widget.data.diagnosis.forEach((element) {
      diagnosis+=element + s ;

    });
  }


  if(widget.data.complaints != null && widget.data.complaints.isNotEmpty)
  {
    map['complaints']=true;

    print('complaint not null');
    complaints="";


    widget.data.complaints.forEach((element) {
      complaints += element + s;

    });
  }

  if(widget.data.investigation != null && widget.data.investigation.isNotEmpty)
  {
    map['investigation']=true;

    print('investigation not null');
    investigation="";


    widget.data.investigation.forEach((element) {
      investigation += element + s;

    });
  }

  if(widget.data.advices != null && widget.data.advices.isNotEmpty)
  {
    map['advices']=true;

    print('advices not null');
    advices="";


    widget.data.advices.forEach((element) {
      advices += element + s;


    });
  }

  if(widget.data.allergies != null && widget.data.allergies.isNotEmpty )
  {
    map['allergies']=true;

    print('allergies not null');
    allergies="";


    widget.data.allergies.forEach((element) {
      allergies += element + s;


    });
  }

  if(widget.data.clinical_finding != null && widget.data.clinical_finding.isNotEmpty)
  {
    map['clinical_findings']=true;
    print('clinical finding not null');
    clinical_findings="";


    widget.data.clinical_finding.forEach((element) {
      clinical_findings += element + s;

    });
  }

  if(widget.data.group != null && widget.data.group.isNotEmpty)
  {
    map['group']=true;

    print('group not null');
    group="";


    widget.data.group.forEach((element) {
      group += element + s;

    });
  }

  if(widget.data.blood_group != null && widget.data.blood_group.isNotEmpty)
  {
    map['blood_group']=true;
    print('blood-group not null');
    blood_group="";


    widget.data.blood_group.forEach((element) {
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
                                child: Text(complaints , style: TextStyle(color: map['complaints']?Colors.black:Colors.grey),),
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



                          print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'group', Group: 'Group', name: widget.name, date: formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

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



                          print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  ListSearch(group: 'blood-group', Group: 'Blood-Group', name: widget.name, date: formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString(),);}

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
