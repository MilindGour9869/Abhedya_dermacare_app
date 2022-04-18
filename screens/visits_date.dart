import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/add_visits.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';

import 'package:date_format/date_format.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class VisitsDate extends StatefulWidget {


  Patient_name_data_list patient_data;








  VisitsDate(this.patient_data);

  @override
  _VisitsDateState createState() => _VisitsDateState();
}

class _VisitsDateState extends State<VisitsDate> {

  Future f;



  List<String> visit_dates=[];

  bool delete = false;









  Future<dynamic> visist_date()async{

    FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).collection('visits').get().then((QuerySnapshot querySnapshot){



      visit_dates=[];


      querySnapshot.docs.forEach((element) {


        print(element.data());

        //visits_instance_list.add(Patient_name_data_list.visits(element.data()));

        Map<String,dynamic> map = element.data();
        print(map['visit_date']);



        
        widget.patient_data.Visit_Map_Data(map: element.data() , visit_date:formatDate(map['visit_date'].toDate(), [ dd, '-', mm, '-', yyyy]).toString()  );
        
        visit_dates.add(formatDate(map['visit_date'].toDate(), [ dd, '-', mm, '-', yyyy]).toString());


        
        print(widget.patient_data.hashCode);
        

        

      });


     setState(() {
       visit_dates=visit_dates;

     });





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
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back , size: AppTheme.aspectRatio*40),
        ),
        title: Text('Visits' , style: AppTheme.main_white_30,),
        backgroundColor: AppTheme.teal,

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(onPressed: (){

              setState(() {
                delete=!delete;

              });
            }, icon: Icon(Icons.delete_outline_outlined , size: AppTheme.aspectRatio*40,)),
          )
        ],
      ),
      body: SingleChildScrollView(

        child: FutureBuilder(
          future: f,
          builder: (context,snapshot){

            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return CircularProgressIndicator();

              }

            if(visit_dates.isEmpty)
              {
                return Center(child: Text('loading' , style: AppTheme.black_22,));

              }


            if(visit_dates.isNotEmpty)
              {
                return Center(
                  child: RefreshIndicator(
                    onRefresh: visist_date,
                    child: Wrap(
                        spacing: 3.w,
                        runSpacing: 3.h,
                        direction: Axis.horizontal,


                        children:visit_dates.map((date) {





                          return SizedBox(

                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context , MaterialPageRoute(builder: (context)=>AddVisits(

                                    visit_date: date.toString(),

                                    icon_tap: false,

                                    patient_data: widget.patient_data,

                                    map: widget.patient_data.visits_mapData_list[date],

                                  ))).then((value) {

                                  });


                                },


                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 17.h,
                                      width: 30.w,
                                      child: Card(


                                          child: Center(child: Text(date.toString() , style: AppTheme.main_black_25,),
                              )),
                                    ),

                                    Visibility(
                                      visible: delete,
                                      child: CircleAvatar(
                                        backgroundColor: AppTheme.white,
                                        child: IconButton(onPressed: ()async{

                                          widget.patient_data.visits_mapData_list.remove(date);
                                          setState(() {
                                            visit_dates.remove(date);

                                          });


                                          await FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).collection('visits').doc(date).delete();




                                        }, icon: Icon(Icons.delete_outline_outlined , color: Colors.red, size: AppTheme.aspectRatio*40,)
                                        ),
                                      ),
                                    )],
                                )));
                        }).toList()),
                  ),
                );
              }

            else
              {
                return Text('Error' , style: AppTheme.black_22,);

              }

          },
        )
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 15,

        splashColor: AppTheme.notWhite,
        onPressed: (){
          Navigator.push(context , MaterialPageRoute(builder: (context)=>AddVisits(

              icon_tap: true,

              patient_data: widget.patient_data,

              visit_date: formatDate(Timestamp.now().toDate(), [ dd, '-', mm, '-', yyyy]).toString(),



          ))).then((value) {
             print("ascdve");
            if(value == 'save')
              {
                visist_date();
              }
          });
        },
        child: Icon(Icons.add , color: Colors.white,),
        backgroundColor: AppTheme.teal,
      ),
      bottomNavigationBar: BottomAppBar(

        color: AppTheme.white,
        child: Container(
          height:MediaQuery.of(context).size.height*0.08,


        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
