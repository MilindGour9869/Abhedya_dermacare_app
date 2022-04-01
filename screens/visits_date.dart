import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/add_visits.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';

import 'package:date_format/date_format.dart';


class VisitsDate extends StatefulWidget {


  Patient_name_data_list patient_data;








  VisitsDate(this.patient_data);

  @override
  _VisitsDateState createState() => _VisitsDateState();
}

class _VisitsDateState extends State<VisitsDate> {

  Future f;

  List<Patient_name_data_list> visits_instance_list=[];
  List date =[];
  List dt=[];

  Map<String , Patient_name_data_list> date_instance={};






  Future<dynamic> visist_date()async{

    FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).collection('visits').get().then((QuerySnapshot querySnapshot){

      querySnapshot.docs.forEach((element) {

        print('ghjh');

        print(element.data());

        visits_instance_list.add(Patient_name_data_list.visits(element.data()));

      });

      print('aaa');
      print(visits_instance_list);

    // print( visits_instance_list[0].complaints);




      visits_instance_list.forEach((element) {
        date.add(element.visit_date);

        date_instance[element.visit_date.toString()]=element;

      }
      );



      setState(() {
        dt=date;
      });


      print(dt);

    } );
  }




















  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.patient_data.doc_id);
    f=visist_date();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Visits'),
      ),
      body: SingleChildScrollView(

        child: FutureBuilder(
          future: f,
          builder: (context,snapshot){

            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return CircularProgressIndicator();

              }

            if(dt.isEmpty)
              {
                return Text('loading');

              }


            if(dt.isNotEmpty)
              {
                return Center(
                  child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      direction: Axis.horizontal,


                      children:dt.map((e) {





                        return SizedBox(
                            height: 100,
                            width: 100,

                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context , MaterialPageRoute(builder: (context)=>AddVisits(visit_data :date_instance[e.toString()] , name: widget.patient_data.name , icon_tap: false, patient_data: widget.patient_data,)));


                              },

                              child: Card(

                                  child: Center(child: Text('${formatDate(e.toDate(),[dd, '-', mm, '-', yyyy])}'))),
                            ));
                      }).toList()),
                );
              }

            else
              {
                return Text('aerror');

              }

          },
        )
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 15,

        splashColor: AppTheme.notWhite,
        onPressed: (){
          Navigator.push(context , MaterialPageRoute(builder: (context)=>AddVisits( name: widget.patient_data.name , icon_tap: true, patient_data: widget.patient_data)));
        },
        child: Icon(Icons.add , color: Colors.black,),
        backgroundColor: AppTheme.green,
      ),
      bottomNavigationBar: BottomAppBar(

        color: AppTheme.offwhite,
        child: Container(
          height:MediaQuery.of(context).size.height*0.08,


        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
