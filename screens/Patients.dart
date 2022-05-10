import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/visits_date.dart';
import 'package:flutter_app/storage/cloud_storage.dart';
import 'package:flutter_app/storage/storage.dart';
import 'package:flutter_app/widgets/add_patient.dart';
import 'package:flutter_app/default.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/classes/Patient_name_list.dart';

import 'package:date_format/date_format.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';





class Patient extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Patient> {


  bool today = true;

  Future f;

  List<Patient_name_data_list> patient_instance_list = [];
  List all_patient_name_list = [];
  List search_patient_list = [];
  Map<String, Patient_name_data_list> map_name_patientInstance_list = {};

  var textcontroller = TextEditingController();

  Future PatientDataDelete(@required String doc_Id) async {
    final doc =
        await FirebaseFirestore.instance.collection('Patient').doc(doc_Id);

    doc.delete();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'good morning ,';
    }
    if (hour < 17) {
      return 'good afternoon ,';
    }
    return 'good evening ,';
  }

  Widget Tile(Patient_name_data_list patient_data_tile) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPatient(
                        patient_data: patient_data_tile,
                        all_patient_name_list: all_patient_name_list,
                        icon_tap: false,
                      ))).then((value) {
            print('\n\nka boom ');


          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.white,
          ),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    patient_data_tile.name == null ? "?" : '${patient_data_tile.name[0].toUpperCase()+patient_data_tile.name.substring(1)}',


                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  titlePadding: EdgeInsets.all(0),
                                  title:
                                      Center(child: Text('Are you Sure ?' ,textScaleFactor: AppTheme.list_tile_subtile,)),
                                  actions: [
                                    Row(
                                      children: [
                                        Container(
                                          child: TextButton(
                                              onPressed: () async{
                                                setState(() {
                                                  patient_instance_list
                                                      .remove(patient_data_tile);
                                                  all_patient_name_list
                                                      .remove(patient_data_tile.name);
                                                  search_patient_list
                                                      .remove(patient_data_tile.name);
                                                  map_name_patientInstance_list
                                                      .remove(patient_data_tile.name);
                                                  PatientDataDelete(
                                                      patient_data_tile.doc_id);



                                                });

                                                  await Cloud_Storage.Patient_Cloud_Data_Delete(
                                                    doc_id: patient_data_tile.doc_id
                                                );

                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'yes',
                                                textScaleFactor: AppTheme.list_tile_subtile,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: AppTheme.teal,
                                          ),
                                        ),
                                        Container(
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'no',

                                                style: TextStyle(
                                                    color: Colors.white),

                                                textScaleFactor: AppTheme.list_tile_subtile,
                                              ),


                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    )
                                  ],
                                ));
                      },
                      icon: Icon(Icons.delete_outline))
                ],
              ),
              dense: true,
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.cake_outlined,
                        color: Colors.grey,

                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(patient_data_tile.age == null ? "?" : patient_data_tile.age.toString() , style: AppTheme.CGrey,),
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.call,
                        color: Colors.grey,

                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(patient_data_tile.mobile == null
                          ? "?"
                          : patient_data_tile.mobile.toString() , style: AppTheme.CGrey,)
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'last visited on : ${formatDate(patient_data_tile.recent_visit.toDate(), [ dd, '-', mm, '-', yyyy])}',

                    style: TextStyle(
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VisitsDate(patient_data_tile))).then((value) {

                                          if(value == 'change')
                                            {
                                              patient_data();


                                            }

                            });
                          },
                          child: Text(
                            'Visits',



                            style: AppTheme.k_list_tile_subtile,

                          ),



                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Payment',
                            style: AppTheme.k_list_tile_subtile,

                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Documents',
                            style: AppTheme.k_list_tile_subtile,

                          )),
                    ],
                  )
                ],
              ),
              leading: CircleAvatar(
                child: Text(
                  patient_data_tile.name == null ? "?" : patient_data_tile.name[0].toUpperCase(),
                  style: TextStyle(fontSize: 17.sp , color: Colors.white),
                ),
                backgroundColor: AppTheme.teal,
              ),
            ),
          ),
        ),
      );

  Future<dynamic> patient_data() async => await FirebaseFirestore.instance
          .collection('Patient')
          .get()
          .then((QuerySnapshot querySnapshot) {

    patient_instance_list = [];
    all_patient_name_list = [];
    search_patient_list = [];
    map_name_patientInstance_list = {};


        querySnapshot.docs.forEach((element) {


          print(element.data());

          Patient_name_data_list p = new Patient_name_data_list();

          patient_instance_list
              .add(p.fromJson(element.data()));

          print('aa');
        });

        patient_instance_list.forEach((element) {
          print(element.hashCode);
        });


        setState(() {
          all_patient_name_list =
              patient_instance_list.map((e) => e.name).toList();

          int n = all_patient_name_list.length;

          for (int i = 0; i < n; i++) {
            map_name_patientInstance_list[all_patient_name_list[i]] =
                patient_instance_list[i];
          }

          print('rgg');

          print(all_patient_name_list);

          search_patient_list = all_patient_name_list;
        });

        var q;

        return q;
      });

  onItemChanged(String value) {
    setState(() {
      search_patient_list = all_patient_name_list
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if (search_patient_list.isEmpty) {
        search_patient_list = [];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



     print('\ninit\n');

     print(Storage.user_map);









    f = patient_data();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    patient_instance_list = [];
    all_patient_name_list = [];
    search_patient_list = [];
    map_name_patientInstance_list = {};
  }

  @override
  Widget build(BuildContext context) {

    //print(100.h/100.w);
    print('\n');
    print(MediaQuery.of(context).textScaleFactor);





    // print('builder');


    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppTheme.offwhite,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(26.h),
            child: Container(
                decoration: BoxDecoration(
                    color: AppTheme.green,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )),

                child: Column(

                 // mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [


                    Flexible(
                      flex: 1,
                      child: Container(

                        padding: EdgeInsets.symmetric(horizontal: 2.w),





                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: Icon(Icons.menu , color: AppTheme.black,),
                            ),



                            ChoiceChip(
                              backgroundColor: AppTheme.offwhite,
                              label: today?Text('Today' , textScaleFactor: AppTheme.list_tile_subtile,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,

                              ),):Text('All' , textScaleFactor: AppTheme.list_tile_subtile ,style: TextStyle(
                                fontWeight: FontWeight.bold,

                              ), ),
                              selected: false,
                              selectedColor: Colors.teal,
                              onSelected: (bool selected) {
                                setState(() {
                                  today=!today;

                                });
                              },
                            ),

                          ],
                        ) ,
                      ),
                    ),



                    Flexible(
                      flex: 4,
                      child: Container(

                        margin:  EdgeInsets.symmetric(horizontal: 10.w ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 1.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      greeting(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal
                                    ),

                                  ),

                                  Text(
                                    'Dr. Mahi Ram Bishnoi',
                                    textScaleFactor: 1.7,
                                    style:TextStyle(
                                      fontFamily: 'RobotoSlab-Medium',

                                    )


                                  ),
                                ],
                              ),
                            ),



                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),

                              height: 6.h,

                              decoration: BoxDecoration(
                                  color: AppTheme.notWhite,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(

                                controller: textcontroller,



                                onChanged: onItemChanged,
                                decoration: InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 7.w , vertical: 1.3.h ),
                                    border: InputBorder.none,
                                    hintText: 'search',
                                    hintStyle:  AppTheme.k_search_text_style





                                   ),
                                keyboardType: TextInputType.name,
                              ),
                            ),






                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      child: FutureBuilder(
                          future: f,
                          builder: (context, snapshot) {
                            // print(snapshot.data);

                            if (search_patient_list.isEmpty) {
                              return Center(
                                  child: Card(
                                      color: AppTheme.notWhite,
                                      child: Padding(
                                        padding:  EdgeInsets.all(5.w),
                                        child: Text('loading',),
                                      )));
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return  Center(
                                  child: Text('Something Went Wrong'));
                            }

                            return Container(
                              height:
                                 65.h,

                           //   color: Colors.red,

                              child: RefreshIndicator(
                                onRefresh: patient_data,
                                color: AppTheme.teal,
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: search_patient_list
                                      .map<Widget>((e) => Tile(
                                          map_name_patientInstance_list[e]))
                                      .toList(),
                                ),
                              ),
                            );
                          })),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
              elevation: 15,

              splashColor: AppTheme.notWhite,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPatient(
                              all_patient_name_list: all_patient_name_list,
                              icon_tap: true,
                            ))).then((value) {
                  print('ggb');

                  if (value == 'save') {
                    patient_instance_list = [];
                    all_patient_name_list = [];
                    search_patient_list = [];
                    map_name_patientInstance_list = {};

                    patient_data();
                  }
                });
              },
              child: Icon(
                Icons.add,
                color: AppTheme.white,
                semanticLabel: 'ss',
              ),
              backgroundColor: AppTheme.teal),
          bottomNavigationBar: BottomAppBar(
            color: AppTheme.white,
            child: Container(
              height: 7.h,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}


