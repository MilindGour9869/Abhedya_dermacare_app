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



  Timestamp visit_date  = Timestamp.now();

  Timestamp followUp_date;


  void setdata(){

setState(() {

  visit_date = widget.data.date;


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



//
//    widget.data.advices.forEach((element) {
//
//    });
//    widget.data.medicines.forEach((element) { });
//    widget.data.allergies.forEach((element) { });
//    widget.data.investigation.forEach((element) { });

      visit_date=widget.data.visit_date;


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

                Card(child: Text('${formatDate(visit_date.toDate(),[dd, '-', mm, '-', yyyy])}')),

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

                            setState(() {

                              complaints='';
                              a.forEach((element) {

                                complaints=element +" ";


                              });
                            });




                          });


                         







                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined))




                      ],
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
