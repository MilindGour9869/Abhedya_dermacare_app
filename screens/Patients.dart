import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/visits_date.dart';
import 'package:flutter_app/widgets/add_patient.dart';
import 'package:flutter_app/default.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/classes/Patient_name_list.dart';

import 'package:date_format/date_format.dart';
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
      return 'good Morning ,';
    }
    if (hour < 17) {
      return 'good Afternoon ,';
    }
    return 'good Evening ,';
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

            print(value);

            if (value == 'save') {

              patient_data();
            }
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
                    patient_data_tile.name == null ? "?" : patient_data_tile.name,
                    style: AppTheme.main_black_25,
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  titlePadding: EdgeInsets.all(0),
                                  title:
                                      Center(child: Text('Are you Sure ?' , style: AppTheme.main_black_25,)),
                                  actions: [
                                    Row(
                                      children: [
                                        Container(
                                          child: TextButton(
                                              onPressed: () {
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

                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'yes',
                                                style: TextStyle(
                                                    color: Colors.white , fontSize: 17.sp),
                                              )),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: AppTheme.green,
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
                                                    color: Colors.white , fontSize: 17.sp),
                                              )),
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
                      Text(patient_data_tile.age == null ? "?" : patient_data_tile.age.toString() , style: AppTheme.grey_20,),
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
                          : patient_data_tile.mobile.toString() , style: AppTheme.grey_20,)
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'last visited on : ${formatDate(patient_data_tile.recent_visit.toDate(), [ dd, '-', mm, '-', yyyy])}',
                    style: AppTheme.grey_italic_20
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
                            style: AppTheme.grey_22
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Payment',
                              style: AppTheme.grey_22
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Documents',
                              style: AppTheme.grey_22
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
    print(100.w/100.h);


    // print('builder');


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.offwhite,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(25.h),
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
                            label: today?Text('Today' , style: AppTheme.black_22,):Text('All' , style: AppTheme.black_22,),
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
                                    style: AppTheme.main_black_25
                                ),

                                Text(
                                  'Dr. Mahi Ram Bishnoi',
                                  style: AppTheme.black_35,
                                ),
                              ],
                            ),
                          ),



                          Container(
                            margin: EdgeInsets.only(bottom: 1.h),

                            height: 6.h,

                            decoration: BoxDecoration(
                                color: AppTheme.notWhite,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(

                              controller: textcontroller,
                              style: AppTheme.ksearchBar,


                              onChanged: onItemChanged,
                              decoration: InputDecoration(
                                  isDense: true,
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 7.w , vertical: 1.3.h ),
                                  border: InputBorder.none,
                                  hintText: 'search',




                                  suffixIcon: Icon(Icons.search)),
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
                                      child: Text('loading', style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.aspectRatio*25

                                      ),),
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
              color: AppTheme.black,
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
    );
  }
}
