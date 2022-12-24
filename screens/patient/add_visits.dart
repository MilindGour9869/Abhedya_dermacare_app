import 'package:flutter/material.dart';

//firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/custom_widgets/loading_screen.dart';

//App theme
import 'package:flutter_app/default.dart';

//screens
import 'package:flutter_app/list_search/list_search.dart';
import '../printer/Printer_Select_list.dart';
import '../../list_search/vital_list_search.dart';
import '../services/service_search_list.dart';
import '../medicine/Medicines.dart';

//local storage
import 'package:flutter_app/storage/storage.dart';

//External lib
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:date_format/date_format.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//model
import 'package:flutter_app/classes/Patient_name_list.dart';





class AddVisits extends StatefulWidget {

  Patient_name_data_list patient_data;
  bool icon_tap;

  Timestamp visit_date;
  Map<String, dynamic>? patient_visit_date_map;



  AddVisits(
      {

   required this.patient_data , required this.icon_tap ,required  this.visit_date , this.patient_visit_date_map});

  @override
  _AddVisitsState createState() => _AddVisitsState();
}

class _AddVisitsState extends State<AddVisits> {

  //11
  String complaints = "Complaints";
  String diagnosis = "Diagnosis";
  String advices = "Advices";
  String investigation = "Investigation";
  String allergies = "Allergies";
  String clinical_finding = "Clinical Finding";
  String group = "Group";
  String service = "Services";
  String medicine = "Medicine";
  String vital = "Vitals";
  String notes = 'Notes';

  String? blood_group ;

  bool is_blood_group_updated = false;


  //Icon_Image_Path
  String img_complaint = 'images/complaint_color.webp';
  String img_clinical_finding_color = 'images/clinical_finding_color.png';
  String img_diagnosis = 'images/diagnosis.webp';
  String img_medicine_color = 'images/medicine_color.webp';
  String img_vital_color = 'images/vital_color.webp';
  String img_investigation_color = 'images/investigation_color.webp';

  //10
  List<String>? Complaint = [] ;
  List<String>? Diagnosis = [];
  List<String>? Advices = [];
  List<String>? Investigation = [];
  List<String>? Allergies = [] ;
  List<String>? Clinical_finding = [] ;
  List<String>? Group = [] ;
  List<String>? Services = [] ;
  List<String>? Medicine  = [];
  List<String>? Notes = [] ;


  Map<String, Map<String, dynamic>>? medicine_result ;
  Map<String, Map<String, dynamic>>? service_result ;
  Map<String, Map<String, dynamic>>? vital_result ;




  String? follow_up_date;
  Timestamp? followUp_date;

  late Timestamp visit_date;





  num total_charge = 0;


  dynamic set(List<String> list, Map<String, dynamic> map, String name) {
    if (list.isNotEmpty) {
      map[name] = list;
      return map;
    }
  }

  Widget DropDown(String menu) {
    return Text(
      menu,
      textScaleFactor: AppTheme.list_tile_subtile,
    );
  }




  void init_start() {
    setState(() {
      // Complaint = map['complaint'];

      visit_date = widget.visit_date;

      if (widget.patient_data.blood_group != null) {
        blood_group = widget.patient_data.blood_group;
      }

      if(widget.patient_visit_date_map !=null)
      {
        Map<String, dynamic> map = widget.patient_visit_date_map!;

        Complaint = map['complaint'];
        Notes = map['notes'];
        Investigation = map['investigation'];
        Diagnosis = map['diagnosis'];
        Advices = map['advices'];
        Group = map['group'];
        Allergies = map['allergies'];
        Clinical_finding = map['clinical_finding'];

        Services = map['service'].keys.toList();
        service_result = Map<String, Map<String, dynamic>>.from(map['service']);

        medicine_result = Map<String, Map<String, dynamic>>.from(map['medicine']);

        vital_result = map['vitals'];

        followUp_date = map['follow_up_date'];

        total_charge = map['total_charge'];

      }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init_start();

  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        backgroundColor: AppTheme.notWhite,
        appBar: AppBar(
          backgroundColor: AppTheme.teal,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: AppTheme.icon_size,
            ),
            onPressed: () {
              Navigator.pop(context, 'back');
            },
          ),
          title: Text(
            'Add Visits',
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Map<String, dynamic> patient_detail = {

                    'patient_name': widget.patient_data.name,
                    'patient_gender': widget.patient_data.gender == null
                        ? ""
                        : widget.patient_data.gender!.isNotEmpty
                            ? widget.patient_data.gender
                            : "",
                    'patient_age': widget.patient_data.age == null
                        ? ""
                        : widget.patient_data.age.toString(),
                    'patient_mobile': widget.patient_data.mobile == null
                        ? ""
                        : widget.patient_data.mobile.toString(),
                    'address': widget.patient_data.address == null
                        ? ""
                        : widget.patient_data.address!.isNotEmpty
                            ? widget.patient_data.address
                            : "",
                    'patient_blood_group':
                        widget.patient_data.blood_group == null
                            ? ""
                            : widget.patient_data.blood_group!.isNotEmpty
                                ? widget.patient_data.blood_group
                                : "",
                  };

                  showDialog(
                      context: context,
                      builder: (context) {
                        return Printer_Select_List(
                           {
                            'Visit Date': formatDate(visit_date.toDate(), [ dd, '-', mm, '-', yyyy]).toString(),
                            'UID': widget.patient_data.uid,
                            'Patient Detail': patient_detail,
                            'Vitals': vital_result,
                            'Complaint': Complaint,
                            'Investigation': Investigation,
                            'Clinical Finding': Clinical_finding,
                            'Notes': Notes,
                            'Diagnosis': Diagnosis,
                            'Allergies': Allergies,
                            'Advices': Advices,
                            'Group': Group,
                            'Medicine': medicine_result,
                            'Follow up date': follow_up_date,
                          },
                         widget.patient_data.doc_id,
                        );
                      });

                },
                icon: Icon(Icons.print_outlined)),
            Padding(
              padding: EdgeInsets.only(right: 1.w),
              child: IconButton(
                  onPressed: () {

                    SnackOn(context : context, msg : 'Saving ....');

                    Map<String, dynamic?> map;

                    map = {
                      'Complaint': Complaint,
                      'Notes':Notes,
                      'Investigation':Investigation,
                      'Diagnosis' : Diagnosis,
                      'Medicine':medicine_result,
                      'Service':service_result,
                      'Allergies':Allergies,
                      'Advices':Advices,
                      'Group':Group,
                      'Clinical_finding':Clinical_finding,
                      'Vital':vital_result,
                      'follow_up_date':followUp_date,
                      'Total_Charge':total_charge,
                      'visit_date':visit_date,
                   };

                    Map<String,dynamic> json = widget.patient_data.set_visit_date(map, widget.patient_data , formatDate(visit_date.toDate(), [ dd, '-', mm, '-', yyyy]).toString() );

                    if(widget.icon_tap == true)
                      {
                        final doc_id = FirebaseFirestore.instance.collection('Patient').doc();
                        doc_id.set(json);
                      }
                    else if(widget.icon_tap == false)
                      {
                        final doc_id = FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).collection('visits').doc(formatDate(widget.visit_date.toDate(), [ dd, '-', mm, '-', yyyy]).toString());
                        doc_id.update(json);
                      }
                    else
                      {
                        print('error');
                        ShowDialogue(context, 'error');
                      }

                    Map<String,dynamic> patient_json={};
                    final patient_ref=FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id);

                    if(blood_group != null && blood_group!.isNotEmpty && is_blood_group_updated)
                    {
                      patient_json['blood_group']=blood_group;
                    }

                    patient_json['recent_visit']=visit_date;

                    patient_ref.update(patient_json);

                    SnackOff(context: context);



                    Navigator.pop(context, 'save');
                  },
                  icon: Icon(
                    Icons.save,
                    size: AppTheme.icon_size,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.transparent,
              // height: MediaQuery.of(context).size.height*0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: 40.w,
                      child: Card(
                          child: Center(
                              child: TextButton(
                        child: Text(
                          '${visit_date}',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1947),
                                  lastDate: DateTime(2050))
                              .then((value) {

                                if(value != null)
                                  {
                                    setState(() {
                                      visit_date = Timestamp.fromDate(value!);
                                    });
                                  }


                          });
                        },
                      )))), //date

                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: 45.w,
                              child: Card(
                                  elevation: 1,
                                  child: Center(
                                      child: TextButton.icon(
                                    icon: Icon(
                                      FontAwesomeIcons.droplet,
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      blood_group ?? "Blood Group",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => List_Search(
                                                result: [blood_group],
                                                get: Storage.get,
                                                set: Storage.set,
                                                one_select: true,
                                                group: 'blood_group',
                                                Group: 'Blood_Group',
                                                ky: 'blood_group',
                                              )).then((value) {
                                        if (value != null) {
                                          if (value.isNotEmpty) {
                                            setState(() {
                                              blood_group = value[0].toString();
                                            });
                                          }
                                        }
                                      });
                                    },
                                  )))),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Card(
                                  elevation: 1,
                                  child: Center(
                                      child: TextButton.icon(
                                    icon: Icon(Icons.timelapse_rounded),
                                    label: Text(
                                      follow_up_date ?? 'Follow Up Date',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1947),
                                              lastDate: DateTime(2050))
                                          .then((value) {
                                        print(value);
                                        setState(() {


                                          follow_up_date = formatDate(
                                                  Timestamp.fromDate(value!)
                                                      .toDate(),
                                                  [dd, '-', mm, '-', yyyy])
                                              .toString();
                                          followUp_date = Timestamp.fromDate(value);
                                        });
                                      });
                                    },
                                  )))),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(

                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(complaints , ),
                        ),
                        leading: Image.asset(img_complaint),

                        trailing: IconButton(onPressed: ()async{



                          print(widget.patient_data.visits_mapData_list);


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Complaint, get: Storage.get, set: Storage.set, group: 'complaint', Group: 'Complaint', one_select: false, ky: 'complaint');}
                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Complaint = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Complaint!.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Complaint

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(

                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(notes , ),
                        ),
                        leading: Icon(Icons.note),

                        trailing: IconButton(onPressed: ()async{






                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Notes, get: Storage.get, set: Storage.set, group: 'notes', Group: 'Notes', one_select: false, ky: 'notes');


                              }

                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Notes = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Notes!.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Notes


                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(

                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(clinical_finding , ),
                        ),
                        leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset(img_clinical_finding_color ,)),

                        trailing: IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                          print('ddd');






                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Clinical_finding, get: Storage.get, set: Storage.set, group: 'clinical_finding', Group: 'Clinical_finding', one_select: false, ky: 'clinical_finding');}
                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Clinical_finding = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Clinical_finding!.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Clinical Finding

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(



                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(diagnosis , ),
                        ),
                        leading: Image.asset(img_diagnosis),

                        trailing: IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Diagnosis, get: Storage.get, set: Storage.set, group: 'diagnosis', Group: 'Diagnosis', one_select: false, ky: 'diagnosis');
}

    ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Diagnosis = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Diagnosis!.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Diagnosis

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(




                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(investigation , ),
                        ),
                        leading: Image.asset(img_investigation_color),

                        trailing: IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Investigation, get: Storage.get, set: Storage.set, group: 'investigation', Group: 'Investigation', one_select: false, ky: 'investigation');
                              }
                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Investigation = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Investigation!.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Investigation

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(

                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(allergies , ),
                        ),
                        leading: Icon(Icons.add , size: AppTheme.icon_size,),

                        trailing: IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return List_Search(result: Allergies, get: Storage.get, set: Storage.set, group: 'allergies', Group: 'Allergies', one_select: false, ky: 'allergies');
                              }
                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Allergies = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Allergies!.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Allergies

                  Padding(
                    padding:  EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,


                      child: ListTile(

                        title: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Text(advices, ),
                        ),
                        leading: Icon(Icons.add),

                        trailing: IconButton(onPressed: ()async{



                          // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


                          showDialog(
                              context: context,
                              builder: (context)  {



                                return  List_Search(result: Advices, get: Storage.get, set: Storage.set, group: 'advices', Group: 'Advices', one_select: false, ky: 'advices');
                              }
                          ).then((value)async{

                            print(value);

                            if(value != null)
                            {
                              setState(() {
                                Advices = value;
                              });


                            }
                          });










                        }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

                        subtitle: Padding(
                          padding:  EdgeInsets.only(top: 1.w),
                          child: Container(

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Advices!.map<Widget>((e)=>DropDown(e) ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Advices

                  Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Text(
                            group,
                          ),
                        ),
                        leading: Icon(Icons.add),
                        trailing: IconButton(
                            onPressed: () async {
                              // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return List_Search(result: Group, get: Storage.get, set: Storage.set, group: 'group', Group: 'Group', one_select: false, ky: 'group');
                                  }).then((value) async {
                                print(value);

                                if (value != null) {
                                  setState(() {
                                    Group = value;
                                  });
                                }
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.black,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: Group!.map<Widget>((e) => DropDown(e))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Group

                  Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Text(
                            service,
                          ),
                        ),
                        leading: Icon(Icons.add),
                        trailing: IconButton(
                            onPressed: () async {
                              // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Service_Search_List(
                                      result: Services!,
                                    );
                                  }).then((value) async {


                                if (value != null) {
                                  setState(() {
                                   Services = value.keys.toList();
                                   service_result = value;

                                   print('frr');
                                   print(service_result);

                                   total_charge = 0;


                                   service_result!.forEach((key, value) {


                                     print(total_charge);

                                     total_charge += value['charge'];



                                   });





                                  });
                                }
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.black,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Container(
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: service_result!.keys.map((e) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(e[0].toUpperCase() + e.substring(1)),

                                        Text('₹ ${service_result![e]!['charge'].toString()}' )
                                      ],
                                    );
                                  }).toList(),
                                ),
                                Divider(
                                  thickness: 1.2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total Charge'),
                                    Text('₹ ${total_charge.toString()}' )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Text(
                            medicine,
                          ),
                        ),
                        leading: Icon(Icons.add),
                        trailing: IconButton(
                            onPressed: () async {
                              print(medicine_result);

                              // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Medicines(
                                            to_add_medicne: false,
                                            to_select_medicine: true,
                                            result_map: medicine_result,
                                          ))).then((value) {
                                print('ccc');
                                print(value);

                                if (value != null) {
                                  Medicine = [];

                                  medicine_result = value;

                                  setState(() {
                                    Medicine = medicine_result!.keys.toList();
                                  });

                                  print(Medicine);
                                }
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.black,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: medicine_result!.keys.map<Widget>((e) {
                                return DropDown(e);
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(1.w),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 2,
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Text(
                            vital,
                          ),
                        ),
                        leading: Icon(
                          Icons.add,
                          size: AppTheme.icon_size,
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Vital_List_Search(
                                      result: vital_result!,
                                    );
                                  }).then((value) async {
                                print('dsdsds');

                                print(value);

                                if (value != null) {
                                  setState(() {
                                    vital_result = value;
                                  });
                                }
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.black,
                            )),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: vital_result!.keys.map<Widget>((e) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      vital_result![e]!['vital_name'],
                                      textScaleFactor:
                                          AppTheme.list_tile_subtile,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          vital_result![e]!['value'],
                                          textScaleFactor:
                                              AppTheme.list_tile_subtile,
                                        ),
                                        SizedBox(
                                          width: 0.5.w,
                                        ),
                                        Text(
                                          vital_result![e]!['vital_unit'],
                                          textScaleFactor:
                                              AppTheme.list_tile_subtile,
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // Vital
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


