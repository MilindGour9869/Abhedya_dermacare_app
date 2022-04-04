import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/visits_date.dart';
import 'package:flutter_app/widgets/add_patient.dart';
import 'package:flutter_app/default.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/classes/Patient_name_list.dart';

import 'package:date_format/date_format.dart';

class Patient extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Patient> {
  bool today = false, all = false;

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

  Widget Tile(Patient_name_data_list data) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPatient(
                        patient_data: data,
                        all_patient_name_list: all_patient_name_list,
                        icon_tap: false,
                      ))).then((value) {
            print('\n\nka boom ');

            print(value);

            if (value == 'save') {
              patient_instance_list = [];
              all_patient_name_list = [];
              search_patient_list = [];
              map_name_patientInstance_list = {};

              patient_data();
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Container(
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
                      data.name == null ? "?" : data.name,
                      style: TextStyle(fontSize: 15),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    titlePadding: EdgeInsets.all(0),
                                    title:
                                        Center(child: Text('Are you Sure ?')),
                                    actions: [
                                      Row(
                                        children: [
                                          Container(
                                            child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    patient_instance_list
                                                        .remove(data);
                                                    all_patient_name_list
                                                        .remove(data.name);
                                                    search_patient_list
                                                        .remove(data.name);
                                                    map_name_patientInstance_list
                                                        .remove(data.name);
                                                    PatientDataDelete(
                                                        data.doc_id);
                                                  });

                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'yes',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.redAccent,
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
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(data.age == null ? "20" : data.age.toString()),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.call,
                          color: Colors.grey,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(data.mobile == null
                            ? "?91"
                            : data.mobile.toString())
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'last visited on : ${formatDate(data.recent_visit.toDate(), [
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
                                      builder: (context) =>
                                          VisitsDate(data))).then((value) {
                                print('sss');
                              });
                            },
                            child: Text(
                              'Visits',
                              style: TextStyle(color: AppTheme.grey),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Payment',
                              style: TextStyle(color: AppTheme.grey),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Documents',
                              style: TextStyle(color: AppTheme.grey),
                            )),
                      ],
                    )
                  ],
                ),
                leading: CircleAvatar(
                  child: Text(
                    data.name == null ? "?" : data.name[0].toUpperCase(),
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: AppTheme.teal,
                ),
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

          patient_instance_list
              .add(Patient_name_data_list.fromJson(element.data()));

          print('aa');
        });

        print(patient_instance_list);

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

    // print('\ninit\n');
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
    // print('builder');


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.offwhite,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.green,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )),
              height: MediaQuery.of(context).size.height * 0.28,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,



                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(Icons.menu),
                        ),



                        ChoiceChip(
                          backgroundColor: AppTheme.offwhite,
                          label: Text('Today'),
                          selected: false,
                          selectedColor: Colors.teal,
                          onSelected: (bool selected) {},
                        ),

                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Text(
                              greeting(),
                              style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.03),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Dr. Mahi Ram Bishnoi',
                              style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.04),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                          ],
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.only(
                            top: 23.0, right: 40, left: 40 , bottom: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(
                              color: AppTheme.notWhite,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: textcontroller,
                            onChanged: onItemChanged,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'search',
                                prefixText: "      ",
                                hintStyle: TextStyle(),
                                suffixIcon: Icon(Icons.search)),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ),
                    ],
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
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text('loading'),
                                    )));
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return const Center(
                                child: Text('Something Went Wrong'));
                          }

                          return Container(
                            height:
                                MediaQuery.of(context).size.height * 0.6,

//                            color: Colors.red,

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
              color: Colors.black,
            ),
            backgroundColor: AppTheme.teal),
        bottomNavigationBar: BottomAppBar(
          color: AppTheme.white,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

//class Patient_Tile extends StatelessWidget {
//   Patient_Tile({
//    Key key, this.name , this.age , this.mobile , this.date
//  }) : super(key: key);
//
//  String name , date  ;
//  int mobile , age ;
//
//
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      title: Text(name==null?"?":name),
//
//      subtitle: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//
//        children: [
//          SizedBox(height: 10,),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: [
//              Icon(Icons.cake_outlined , color: Colors.grey,size: 20,),
//              SizedBox(width: 5,),
//              Text(age==null?"?":age.toString()),
//              SizedBox(width: 10,),
//              Icon(Icons.call , color: Colors.grey,size: 20,),
//              SizedBox(width: 5,),
//              Text(mobile==null?"?":mobile.toString())
//            ],
//          ),
//
//
//          SizedBox(height: 10,),
//          Text('last visited on : ${date==null?"?":date}' , style: TextStyle(fontStyle: FontStyle.italic),),
//
//          Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: [
//              TextButton(onPressed: (){}, child: Text('Visits')),
//              TextButton(onPressed: (){}, child: Text('Payment')),
//              TextButton(onPressed: (){}, child: Text('Documents')),
//            ],
//          )
//
//        ],
//      ),
//
//      leading: CircleAvatar(
//        child: Text(name[0].toUpperCase()),
//
//
//      ),
//
//
//
//
//    );
//  }
//}
