import 'package:flutter/material.dart';

//firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/custom_widgets/loading_screen.dart';

//screens
import 'payment.dart';
import 'add_visits.dart';

//models
import 'package:flutter_app/classes/Patient_name_list.dart';
import 'package:flutter_app/default.dart';

//External libs
import 'package:date_format/date_format.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class VisitsDate extends StatefulWidget {


  Patient_name_data_list patient_data;
  String path ;

  VisitsDate( this.patient_data , this.path, {Key? key}) : super(key: key);

  @override
  _VisitsDateState createState() => _VisitsDateState();
}

class _VisitsDateState extends State<VisitsDate> {

  late Future f;

  late List<String> visit_dates;

  bool is_patient_instance_updated = false;

  late Map<String,Timestamp> date_timestamp_map;

  bool delete = false;


  Future<void> visit_date()async{

    visit_dates=[];

    if(widget.patient_data.visits_mapData_list!=null)
      {
        if(widget.patient_data.visits_mapData_list!.isNotEmpty)
          {
            widget.patient_data.visits_mapData_list!.forEach((key, value) {

              date_timestamp_map[key]= value['visit_date'];
              visit_dates.add(key);


            });

            setState(() {
              visit_dates=visit_dates;
            });
          }
      }
  }


    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    f=visit_date();

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context , is_patient_instance_updated);
        return true;

      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: Scaffold(

          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context , is_patient_instance_updated);
              },
              icon: Icon(Icons.arrow_back , size: AppTheme.aspectRatio*40),
            ),
            title: Text(widget.path[0].toUpperCase() + widget.path.substring(1) , ),
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
                    return const Center(child: CircularProgressIndicator());

                  }

                if(visit_dates.isEmpty)
                  {
                    return const Center(child: Text('loading..' ));

                  }


                if(visit_dates.isNotEmpty)
                  {
                    return Center(
                      child: RefreshIndicator(
                        onRefresh: visit_date,
                        child: Wrap(
                            spacing: 3.w,
                            runSpacing: 3.h,
                            direction: Axis.horizontal,


                            children:visit_dates.map((date) {

                              return SizedBox(

                                  child: GestureDetector(
                                    onTap: (){
                                      if(widget.path == 'visit')
                                        {
                                          Navigator.push(context , MaterialPageRoute(builder: (context)=>AddVisits(

                                            widget.patient_data,
                                            false,
                                            date_timestamp_map[date]!,

                                            patient_visit_date_map: widget.patient_data.visits_mapData_list![date]!,

                                          ))).then((value) {

                                            if(value == 'save')
                                              {
                                                is_patient_instance_updated = true;

                                              }



                                          });
                                        }
                                      else if(widget.path == 'payment')
                                        {
                                          Navigator.push(context , MaterialPageRoute(builder: (context)=>Payment(

                                            visit_date: date,

                                            icon_tap: false,

                                            patient_data: widget.patient_data,

                                            map: widget.patient_data.visits_mapData_list![date.toString()]!,

                                          ))).then((value) {
                                            if(value == 'save')
                                            {
                                              is_patient_instance_updated = true;

                                            }

                                          });


                                        }


                                    },


                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 17.h,
                                          width: 30.w,
                                          child: Card(


                                              child: Center(child: Text(date.toString() ),
                                  )),
                                        ),

                                        Visibility(
                                          visible: delete,
                                          child: CircleAvatar(
                                            backgroundColor: AppTheme.white,
                                            child: IconButton(onPressed: ()async{

                                              bool result = ShowDialogue.f(context, 'Are You Sure ..?');

                                              if(result)
                                                {
                                                  SnackOn(context, 'Deleting the selected visit date...');

                                                  widget.patient_data.visits_mapData_list!.remove(date);
                                                  setState(() {
                                                    visit_dates.remove(date);

                                                  });


                                                  await FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).collection('visits').doc(date).delete();

                                                  SnackOff(context: context);
                                                }




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
                    return Text('Error');

                  }

              },
            )
          ),

          floatingActionButton: FloatingActionButton.extended(
            elevation: 15,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),

            splashColor: AppTheme.notWhite,
            onPressed: (){




              if(widget.path == 'visit')
              {
                Navigator.push(context , MaterialPageRoute(builder: (context)=>AddVisits(

                  icon_tap: true,

                  patient_data: widget.patient_data,

                  visit_date: Timestamp.now(),



                ))).then((value) {
                  print("ascdve");
                  if(value == 'save')
                  {
                    visit_date();
                  }
                });
              }

              else if(widget.path == 'payment')
              {

                  Navigator.push(context , MaterialPageRoute(builder: (context)=>Payment(

                    icon_tap: true,

                    patient_data: widget.patient_data,

                    visit_date: Timestamp.now(),



                  ))).then((value) {
                    print("ascdve");
                    if(value == 'save')
                    {
                      visit_date();
                    }
                  });


              }


            },
            icon: Icon(Icons.add , color: Colors.white,),
            label: Text('Add ${widget.path[0].toUpperCase() + widget.path.substring(1)}'),
            backgroundColor: AppTheme.teal,
          ),
          bottomNavigationBar: BottomAppBar(

            color: AppTheme.white,
            child: Container(
              height:MediaQuery.of(context).size.height*0.08,


            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
