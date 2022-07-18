import 'package:flutter/material.dart';

// Storage
import 'package:flutter_app/storage/cloud_storage.dart';
import 'package:flutter_app/storage/storage.dart';

// Screens
import 'add_patient.dart';
import 'package:flutter_app/default.dart';
import 'document.dart';
import 'visits_date.dart';

// model
import 'package:flutter_app/classes/Patient_name_list.dart';

// Cloud
import 'package:cloud_firestore/cloud_firestore.dart';

// Other Lib
import 'package:date_format/date_format.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Patient extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Patient> {
  bool today = true;
  bool all = false;

  late Future f;

  late List<Patient_name_data_list> patient_instance_list;

  late List<String> all_patient_name_list;
  late List<String> search_patient_list;

  late Map<String, Patient_name_data_list> map_name_patientInstance_list;

  var search_text_controller = TextEditingController();

  // Create , Read , Update
  Future<void> patient_detail() async {
    patient_instance_list = [];
    all_patient_name_list = [];
    search_patient_list = [];
    map_name_patientInstance_list = {};
    int i = 0;

    await FirebaseFirestore.instance
        .collection('Patient')
        .snapshots()
        .forEach((snapshot) => snapshot.docs.forEach((element) async {

      Patient_name_data_list patient_class_instance = Patient_name_data_list();



             patient_instance_list.add(patient_class_instance.from_Json_to_Patient_Instance(element.data()));

              await PatientVisitData(patient_instance_list[i], element.id);
              i++;
            }));

    setState(() {
      all_patient_name_list = patient_instance_list.map((e) => e.name).toList();

      int n = all_patient_name_list.length;

      for (int i = 0; i < n; i++) {
        map_name_patientInstance_list[all_patient_name_list[i]] =
            patient_instance_list[i];
      }

      search_patient_list = all_patient_name_list;
    });
  }

  Future<void> PatientVisitData(
      Patient_name_data_list patient_instance, String docId) async {
    await FirebaseFirestore.instance
        .collection('Patient')
        .doc(docId)
        .collection('visits')
        .snapshots()
        .forEach((snapshot) {
      snapshot.docs.forEach((element) {
        Map<String, dynamic> map = element.data();

        patient_instance.Visit_Map_Data(
            element.data(),
            formatDate(map['visit_date'].toDate(), [dd, '-', mm, '-', yyyy])
                .toString());
      });
    });
  }

  //Delete
  Future PatientDataDelete(String docId) async {
    final doc =
        await FirebaseFirestore.instance.collection('Patient').doc(docId);

    doc
        .collection('visits')
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));

    doc.delete();
  }

  //other
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

  // Func Widget
  Widget Tile(Patient_name_data_list patient_instance) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPatient(
                        all_patient_name_list,
                        false,
                        patient_data: patient_instance,
                      ))).then((value) {
            if (value != 'back') {
              patient_detail();
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
                    // Name is Compulsory , so no need to check null safety...
                    '${patient_instance.name[0].toUpperCase() + patient_instance.name.substring(1)}',
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  titlePadding: EdgeInsets.all(0),
                                  title: Center(
                                      child: Text(
                                    'Are you Sure ?',
                                    textScaleFactor: AppTheme.list_tile_subtile,
                                  )),
                                  actions: [
                                    Row(
                                      children: [
                                        Container(
                                          child: TextButton(
                                              onPressed: () async {
                                                setState(() {
                                                  patient_instance_list
                                                      .remove(patient_instance);
                                                  all_patient_name_list.remove(
                                                      patient_instance.name);
                                                  search_patient_list.remove(
                                                      patient_instance.name);
                                                  map_name_patientInstance_list
                                                      .remove(patient_instance
                                                          .name);
                                                  PatientDataDelete(
                                                      patient_instance.doc_id);
                                                });

                                                await Cloud_Storage
                                                    .Patient_Cloud_Data_Delete(
                                                        doc_id: patient_instance
                                                            .doc_id);

                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'yes',
                                                textScaleFactor:
                                                    AppTheme.list_tile_subtile,
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
                                              textScaleFactor:
                                                  AppTheme.list_tile_subtile,
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
                      Text(
                        patient_instance.age == null
                            ? "?"
                            : patient_instance.age.toString(),
                        style: AppTheme.CGrey,
                      ),
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
                      Text(
                        patient_instance.mobile == null
                            ? "?"
                            : patient_instance.mobile.toString(),
                        style: AppTheme.CGrey,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'last visited on : ${patient_instance.recent_visit == null ? '' : formatDate(patient_instance.recent_visit!.toDate(), [
                            dd,
                            '-',
                            mm,
                            '-',
                            yyyy
                          ])}',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VisitsDate(
                                        patient_instance,
                                        'visit',
                                      ))).then((value) {
                            if (value == 'save') {
                              patient_detail();
                            }
                          });
                        },
                        child: Text(
                          'Visits',
                          style: AppTheme.k_list_tile_subtile,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VisitsDate(
                                          patient_instance,
                                          'payment',
                                        ))).then((value) {
                              if (value == 'save') {
                                patient_detail();
                              }
                            });
                          },
                          child: Text(
                            'Payment',
                            style: AppTheme.k_list_tile_subtile,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DocumentScreen(
                                          patient_data: patient_instance,
                                        ))).then((value) {
                              if (value == 'save') {
                                patient_detail();
                              }
                            });
                          },
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
                  patient_instance.name == null
                      ? "?"
                      : patient_instance.name[0].toUpperCase(),
                  style: TextStyle(fontSize: 17.sp, color: Colors.white),
                ),
                backgroundColor: AppTheme.teal,
              ),
            ),
          ),
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    f = patient_detail();
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
                              icon: Icon(
                                Icons.menu,
                                color: AppTheme.black,
                              ),
                            ),
                            ChoiceChip(
                              backgroundColor: AppTheme.offwhite,
                              label: today
                                  ? Text(
                                      'Today',
                                      textScaleFactor:
                                          AppTheme.list_tile_subtile,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      'All',
                                      textScaleFactor:
                                          AppTheme.list_tile_subtile,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              selected: false,
                              selectedColor: Colors.teal,
                              onSelected: (bool selected) {
                                setState(() {
                                  today = !today;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
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
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text('Dr. Mahi Ram Bishnoi',
                                      textScaleFactor: 1.7,
                                      style: TextStyle(
                                        fontFamily: 'RobotoSlab-Medium',
                                      )),
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
                                controller: search_text_controller,
                                onChanged: onItemChanged,
                                decoration: InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 7.w, vertical: 1.3.h),
                                    border: InputBorder.none,
                                    hintText: 'search',
                                    hintStyle: AppTheme.k_search_text_style),
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

                            if (search_patient_list.isEmpty) {
                              return Center(
                                  child: Card(
                                      color: AppTheme.notWhite,
                                      child: Padding(
                                        padding: EdgeInsets.all(5.w),
                                        child: Text(
                                          'loading',
                                        ),
                                      )));
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Something Went Wrong'));
                            }

                            return Container(

                              height: 65.h,

                              child: RefreshIndicator(
                                onRefresh: patient_detail,
                                color: AppTheme.teal,
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: search_patient_list
                                      .map<Widget>((e) => Tile(
                                          map_name_patientInstance_list[e]!))
                                      .toList(),
                                ),
                              ),
                            );
                          })),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
              elevation: 15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPatient(
                              all_patient_name_list,
                              true,
                            ))).then((value) {
                  if (value != 'back') {
                    patient_detail();
                  }
                });
              },
              icon: Icon(Icons.add),
              label: Text('Add Patient'),
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
