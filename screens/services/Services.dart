import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/classes/service_dialogue.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/storage/storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


List all_service_list = [];

class Services extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Services> {
  Future? f;

  Map<String, Map<String, dynamic>> all_data_map = {};

  bool updated = false;

  bool consultation = false;
  bool nursing = false;
  bool procedures = false;
  bool vacination = false;
  bool by_you = false;



  var service_edit = TextEditingController();
  var charges_edit = TextEditingController();

  Map<String, Map<String, int>> Consulation = {};
  Map<String, Map<String, int>> Nursing = {};
  Map<String, Map<String, int>> Procedures = {};
  Map<String, Map<String, int>> Vaccination = {};
  Map<String, Map<String, int>> By_You = {};

  var search_edit = TextEditingController();
  var service = TextEditingController();
  var charge = TextEditingController();


  List search_service_list = [];



  int? services_length;

  Map<String, dynamic> map = {};

  Map<String, Map<String, String>> service_list = {};

  Future getServiceData() async {
    Consulation = {};
    Nursing = {};
    Procedures = {};
    Vaccination = {};
    By_You = {};
    service_list = {};

    var a = await Storage.get(key: 'services');

    all_data_map = a == null ? {} : a;

    services_length = all_data_map.keys.length;

    all_data_map.forEach((key, element) {
      service_list[element['service']] = {
        element['doc_id'].toString(): element['id'].toString()
      };

      if (element['id'] == 'Consultation') {
        Consulation[element['doc_id']] = {
          element['service']: element['charge']
        };
      }
      if (element['id'] == 'Nursing') {
        Nursing[element['doc_id']] = {element['service']: element['charge']};
      }
      if (element['id'] == 'Procedures') {
        Procedures[element['doc_id']] = {element['service']: element['charge']};
      }
      if (element['id'] == 'Vaccination') {
        Vaccination[element['doc_id']] = {
          element['service']: element['charge']
        };
      }
      if (element['id'] == 'By You') {
        By_You[element['doc_id']] = {element['service']: element['charge']};
      }
    });

    all_service_list = service_list.keys.toList();

    setState(() {
      search_service_list = all_service_list;
    });
  }

  Future set() async{

    print('set called');
    await Storage.set(key: 'services', value: all_data_map);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init called ');

    getServiceData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Services oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print('did update called !!!');
  }

  onItemChanged(String value) {
    setState(() {
      search_service_list = all_service_list
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if (search_service_list.isEmpty) {
        search_service_list = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(25.h),
          child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.teal,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBar(
                    title: Text('Services'),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                    height: 6.h,
                    decoration: BoxDecoration(
                        color: AppTheme.notWhite,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: search_edit,
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
              )),
        ),
        body: Center(
          child: Container(
              child: search_edit.text == ""
                  ? RefreshIndicator(
                      onRefresh: getServiceData,
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Container(
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  title: Text('Consultation'),
                                  leading: Icon(
                                    Icons.arrow_forward_ios,
                                    size:
                                        MediaQuery.of(context).size.height * 0.03,
                                    color: AppTheme.teal,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      consultation = !consultation;

                                      print(consultation);
                                    });
                                  },
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: AppTheme.teal,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                              context: context,
                                              builder: (context) => Dialogue(
                                                  service_name: 'Consultation',
                                                  service: service_edit,
                                                  charges: charges_edit,
                                                  context: context,
                                                  size: services_length!))
                                          .then((value) {



                                            print('ddd');

                                        if (value != null) {
                                          all_data_map.addAll(value);
                                          updated = true;

                                          set();
                                          getServiceData();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ), // Consultation
                          Visibility(
                              visible: consultation,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  ListView(
                                    shrinkWrap: true,
                                    children: Consulation.keys.map((e) {
                                      List a = Consulation[e]!.keys.toList();
                                      String s = a[0].toString();

                                      List b = Consulation[e]!.values.toList();
                                      String c = b[0].toString();

                                      return GestureDetector(
                                        onTap: () {
                                          service.text = s;
                                          charge.text = c;

                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ServiceDialogue.Dialogue(
                                                      service_name: 'Consultation',
                                                      service: service,
                                                      context: context,
                                                      charges: charge,
                                                      doc_id: e)).then((value) {
                                            if (value == 'delete') {
                                              all_data_map.remove(a[0]);
                                              updated = true;
                                              set();
                                              getServiceData();
                                            } else if (value != null) {
                                              all_data_map.remove(e);
                                              all_data_map.addAll(value);
                                              updated = true;
                                              set();
                                              getServiceData();
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 2),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                            child: Material(
                                              elevation: 2,
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(
                                                            ' ${s[0].toUpperCase() + s.substring(1)}',
                                                            textScaleFactor: AppTheme
                                                                .list_tile_subtile,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            c + ' ₹',

                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  Consulation.remove(
                                                                      e);
                                                                  all_data_map
                                                                      .remove(e);
                                                                  updated = true;

                                                                  set();
                                                                  getServiceData();
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_outline_outlined,
                                                                color: Colors.grey,
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  Consulation.isNotEmpty?Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 2.w , vertical: 2.w),
                                    child: Divider(
                                      height: 0,
                                      thickness: 2,color: Colors.grey,
                                    ),
                                  ):Center(child: Card(child: Padding(
                                    padding:  EdgeInsets.all(1.w),
                                    child: Text('No Data'),
                                  ))),

                                ],
                              )), // Consultation

                          Padding(
                            padding: EdgeInsets.symmetric(

                            vertical: 1.h, horizontal: 2.w),
                            child: Container(
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  title: Text('Nursing'),
                                  leading: Icon(
                                    Icons.arrow_forward_ios,
                                    size:
                                        MediaQuery.of(context).size.height * 0.03,
                                    color: AppTheme.teal,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      nursing = !nursing;

                                      // print(consultation);
                                    });
                                  },
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: AppTheme.teal,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                              context: context,
                                              builder: (context) => Dialogue(
                                                  service_name: 'Nursing',
                                                  service: service_edit,
                                                  charges: charges_edit,
                                                  context: context,
                                                  size: services_length!))
                                          .then((value) {
                                        if (value != null) {
                                          all_data_map.addAll(value);
                                          updated = true;

                                          set();
                                          getServiceData();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ), //Nursing
                          Visibility(
                              visible: nursing,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  ListView(
                                    shrinkWrap: true,
                                    children: Nursing.keys.map((e) {
                                      List a = Nursing[e]!.keys.toList();
                                      String s = a[0].toString();

                                      List b = Nursing[e]!.values.toList();
                                      String c = b[0].toString();

                                      return GestureDetector(
                                        onTap: () {
                                          service.text = s;
                                          charge.text = c;

                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ServiceDialogue.Dialogue(
                                                      service_name: 'Nursing',
                                                      service: service,
                                                      context: context,
                                                      charges: charge,
                                                      doc_id: e)).then((value) {
                                            if (value == 'delete') {
                                              all_data_map.remove(a[0]);
                                              updated = true;
                                              set();
                                              getServiceData();
                                            } else if (value != null) {
                                              all_data_map.remove(e);
                                              all_data_map.addAll(value);
                                              updated = true;
                                              set();
                                              getServiceData();
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 2),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                            child: Material(
                                              elevation: 2,
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(
                                                            ' ${s[0].toUpperCase() + s.substring(1)}',
                                                            textScaleFactor: AppTheme
                                                                .list_tile_subtile,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            c + ' ₹',

                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  Nursing.remove(e);
                                                                  all_data_map
                                                                      .remove(e);
                                                                  updated = true;

                                                                  set();
                                                                  getServiceData();
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_outline_outlined,
                                                                color: Colors.grey,
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  Nursing.isNotEmpty?Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 2.w , vertical: 2.w),
                                    child: Divider(
                                      height: 0,
                                      thickness: 2,color: Colors.grey,
                                    ),
                                  ):Center(child: Card(child: Padding(
                                    padding:  EdgeInsets.all(1.w),
                                    child: Text('No Data'),
                                  ))),
                                ],
                              )), // Nursing

                          Padding(
                            padding: EdgeInsets.symmetric(

                            vertical: 1.h, horizontal: 2.w),
                            child: Container(
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  title: Text('Procedures'),
                                  leading: Icon(
                                    Icons.arrow_forward_ios,
                                    size:
                                        MediaQuery.of(context).size.height * 0.03,
                                    color: AppTheme.teal,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      procedures = !procedures;

                                      // print(consultation);
                                    });
                                  },
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: AppTheme.teal,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                              context: context,
                                              builder: (context) => Dialogue(
                                                  service_name: 'Procedures',
                                                  service: service_edit,
                                                  charges: charges_edit,
                                                  context: context,
                                                  size: services_length!))
                                          .then((value) {
                                        if (value != null) {
                                          all_data_map.addAll(value);
                                          updated = true;

                                          set();
                                          getServiceData();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ), //Procedures
                          Visibility(
                              visible: procedures,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  ListView(
                                    shrinkWrap: true,
                                    children: Procedures.keys.map((e) {
                                      List a = Procedures[e]!.keys.toList();
                                      String s = a[0].toString();

                                      List b = Procedures[e]!.values.toList();
                                      String c = b[0].toString();

                                      return GestureDetector(
                                        onTap: () {
                                          service.text = s;
                                          charge.text = c;

                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ServiceDialogue.Dialogue(
                                                      service_name: 'Procedures',
                                                      service: service,
                                                      context: context,
                                                      charges: charge,
                                                      doc_id: e)).then((value) {
                                            if (value == 'delete') {
                                              all_data_map.remove(a[0]);
                                              updated = true;
                                              set();
                                              getServiceData();
                                            } else if (value != null) {
                                              all_data_map.remove(e);
                                              all_data_map.addAll(value);
                                              updated = true;
                                              set();
                                              getServiceData();
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 2),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                            child: Material(
                                              elevation: 2,
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(
                                                            ' ${s[0].toUpperCase() + s.substring(1)}',
                                                            textScaleFactor: AppTheme
                                                                .list_tile_subtile,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            c + ' ₹',

                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  Procedures.remove(
                                                                      e);
                                                                  all_data_map
                                                                      .remove(e);
                                                                  updated = true;

                                                                  set();
                                                                  getServiceData();
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_outline_outlined,
                                                                color: Colors.grey,
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  Procedures.isNotEmpty?Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 2.w , vertical: 2.w),
                                    child: Divider(
                                      height: 0,
                                      thickness: 2,color: Colors.grey,
                                    ),
                                  ):Center(child: Card(child: Padding(
                                    padding:  EdgeInsets.all(1.w),
                                    child: Text('No Data'),
                                  ))),
                                ],
                              )), // Procedures

                          Padding(
                            padding: EdgeInsets.symmetric(

                            vertical: 1.h, horizontal: 2.w),
                            child: Container(
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  title: Text('Vaccination'),
                                  leading: Icon(
                                    Icons.arrow_forward_ios,
                                    size:
                                        MediaQuery.of(context).size.height * 0.03,
                                    color: AppTheme.teal,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      vacination = !vacination;

                                      // print(consultation);
                                    });
                                  },
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: AppTheme.teal,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                              context: context,
                                              builder: (context) => Dialogue(
                                                  service_name: 'Vaccination',
                                                  service: service_edit,
                                                  charges: charges_edit,
                                                  context: context,
                                                  size: services_length!))
                                          .then((value) {
                                        if (value != null) {
                                          all_data_map.addAll(value);
                                          updated = true;

                                          set();
                                          getServiceData();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ), //Vaccination
                          Visibility(
                              visible: vacination,
                              child:ListView(
                                shrinkWrap: true,
                                children: [
                                  ListView(
                                    shrinkWrap: true,
                                    children: Vaccination.keys.map((e) {
                                      List a = Vaccination[e]!.keys.toList();
                                      String s = a[0].toString();

                                      List b = Vaccination[e]!.values.toList();
                                      String c = b[0].toString();

                                      return GestureDetector(
                                        onTap: () {
                                          service.text = s;
                                          charge.text = c;

                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ServiceDialogue.Dialogue(
                                                      service_name: 'Vaccination',
                                                      service: service,
                                                      context: context,
                                                      charges: charge,
                                                      doc_id: e)).then((value) {
                                            if (value == 'delete') {
                                              all_data_map.remove(a[0]);
                                              updated = true;
                                              set();
                                              getServiceData();
                                            } else if (value != null) {
                                              all_data_map.remove(e);
                                              all_data_map.addAll(value);
                                              updated = true;
                                              set();
                                              getServiceData();
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 2),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                            child: Material(
                                              elevation: 2,
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(
                                                            ' ${s[0].toUpperCase() + s.substring(1)}',
                                                            textScaleFactor: AppTheme
                                                                .list_tile_subtile,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            c + ' ₹',

                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  Vaccination.remove(
                                                                      e);
                                                                  all_data_map
                                                                      .remove(e);
                                                                  updated = true;

                                                                  set();
                                                                  getServiceData();
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_outline_outlined,
                                                                color: Colors.grey,
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  Vaccination.isNotEmpty?Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 2.w , vertical: 2.w),
                                    child: Divider(
                                      height: 0,
                                      thickness: 2,color: Colors.grey,
                                    ),
                                  ):Center(child: Card(child: Padding(
                                    padding:  EdgeInsets.all(1.w),
                                    child: Text('No Data'),
                                  ))),
                                ],
                              )), // Vaccination

                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 2.w),
                            child: Container(
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(
                                  title: Text('By You'),
                                  leading: Icon(
                                    Icons.arrow_forward_ios,
                                    size:
                                        MediaQuery.of(context).size.height * 0.03,
                                    color: AppTheme.teal,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      by_you = !by_you;

                                      // print(consultation);
                                    });
                                  },
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: AppTheme.teal,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                              context: context,
                                              builder: (context) => Dialogue(
                                                  service_name: 'By You',
                                                  service: service_edit,
                                                  charges: charges_edit,
                                                  context: context,
                                                  size: services_length!))
                                          .then((value) {
                                        if (value != null) {
                                          all_data_map.addAll(value);
                                          updated = true;

                                          set();
                                          getServiceData();
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ), //By You
                          Visibility(
                              visible: by_you,
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  ListView(
                                    shrinkWrap: true,
                                    children: By_You.keys.map((e) {
                                      List a = By_You[e]!.keys.toList();
                                      String s = a[0].toString();

                                      List b = By_You[e]!.values.toList();
                                      String c = b[0].toString();

                                      return GestureDetector(
                                        onTap: () {
                                          service.text = s;
                                          charge.text = c;

                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ServiceDialogue.Dialogue(
                                                      service_name: 'Nursing',
                                                      service: service,
                                                      context: context,
                                                      charges: charge,
                                                      doc_id: e)).then((value) {
                                            if (value == 'delete') {
                                              all_data_map.remove(a[0]);
                                              updated = true;
                                              set();
                                              getServiceData();
                                            } else if (value != null) {
                                              all_data_map.remove(e);
                                              all_data_map.addAll(value);
                                              updated = true;
                                              set();
                                              getServiceData();
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 1.h),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                            ),
                                            height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                            child: Material(
                                              elevation: 2,
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 1.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios_rounded,
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          Text(
                                                            ' ${s[0].toUpperCase() + s.substring(1)}',
                                                            textScaleFactor: AppTheme
                                                                .list_tile_subtile,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            c + ' ₹',
                                                            textScaleFactor: AppTheme
                                                                .list_tile_subtile,
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  By_You.remove(e);
                                                                  all_data_map
                                                                      .remove(e);
                                                                  updated = true;

                                                                  set();
                                                                  getServiceData();
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .delete_outline_outlined,
                                                                color: Colors.grey,
                                                              ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  By_You.isNotEmpty?Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 2.w , vertical: 2.w),
                                    child: Divider(
                                      height: 0,
                                      thickness: 2,color: Colors.grey,
                                    ),
                                  ):Center(child: Card(child: Padding(
                                    padding:  EdgeInsets.all(1.w),
                                    child: Text('No Data'),
                                  ))),
                                ],
                              )), // By You
                        ],
                      ),
                    )
                  : Container(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: search_service_list.map<Widget>((e) {
                                List a = service_list[e]!.keys.toList();
                                List b = service_list[e]!.values.toList();
                                late List c;

                                service.text = e.toString();

                                if (b[0] == "Consultation") {
                                  c = Consulation[a[0].toString()]!
                                      .values
                                      .toList();
                                } else if (b[0] == "Nursing") {
                                  c = Nursing[a[0].toString()]!.values.toList();
                                } else if (b[0] == "Procedures") {
                                  c = Procedures[a[0].toString()]!.values.toList();
                                } else if (b[0] == "Vaccination") {
                                  c = Vaccination[a[0].toString()]
                                      !.values
                                      .toList();
                                } else if (b[0] == "By_You") {
                                  c = By_You[a[0].toString()]!.values.toList();
                                }

                                charge.text = c[0].toString();

                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            ServiceDialogue.Dialogue(
                                              service: service,
                                              charges: charge,
                                              service_name: b[0].toString(),
                                              doc_id: a[0].toString(),
                                              context: context,
                                            )).then((value) {
                                      if (value == 'delete') {
                                        all_data_map.remove(a[0]);
                                        updated = true;
                                        set();
                                        getServiceData();
                                      }
                                      if (value != null) {
                                        all_data_map.remove(e);
                                        all_data_map.addAll(value);
                                        updated = true;
                                        set();
                                        getServiceData();
                                      }
                                    });
                                  },
                                  child: ListTile(
                                    title: Text(
                                        '${e[0].toString().toUpperCase() + e.toString().substring(1)}'),
                                    leading: Icon(
                                      Icons.arrow_forward_ios,
                                      size: MediaQuery.of(context).size.height *
                                          0.03,
                                      color: AppTheme.teal,
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.delete_outline_outlined,
                                        color: AppTheme.teal,
                                      ),
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  titlePadding: EdgeInsets.all(0),
                                                  title: Center(
                                                      child:
                                                          Text('Are you Sure ?')),
                                                  actions: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                all_data_map
                                                                    .remove(a[0]
                                                                        .toString());
                                                                updated = true;
                                                                set();
                                                                getServiceData();

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'yes',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(15),
                                                            color: AppTheme.green,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'no',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(15),
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                    )
                                                  ],
                                                ));
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    )),
        ),
      ),
    );
  }
}

Widget Dialogue(
    {
      required String service_name,
   required  TextEditingController service,
    required TextEditingController charges,
   required BuildContext context,
    required int size}) {
  return Scaffold(
    backgroundColor: Colors.transparent,

    body: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 1.h,
                    ),


                    Text(
                      service_name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      color: Colors.white,

                      height: 2.h,
                    ),
                    TextField(
                      controller: service,
                      style: TextStyle(
                        fontSize: 4.w
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Add Service',

                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 2.h,
                    ),
                    TextField(
                      controller: charges,
                      style: TextStyle(
                          fontSize: 4.w
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Charges',
                        prefixText: '₹ ',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    Container(
                      color: Colors.white,
                      height: 2.h,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey),
                            child: TextButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppTheme.green),
                            child: TextButton(
                              child: Text(
                                'Done',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () async {
                                print(size);

                                print('done');

                                if (service.text.isEmpty) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title:
                                        Text('Service field is required' , textScaleFactor: AppTheme.alert,),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);

                                          }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                        ],
                                      ));
                                }

                                if (charges.text.isEmpty) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Charge field is required' , textScaleFactor: AppTheme.alert,),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);

                                          }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                        ],
                                      ));
                                }
                                bool similar = false;


                                all_service_list.forEach((element) {
                                  if(service.text == element)
                                    {
                                      print('Similaer');
                                      similar=true;
                                    }
                                });






                                //  Services();

                               if(!similar)
                                 {

                                   Map<String, Map<String, dynamic>> all_data_map = {};

                                   var doc = await FirebaseFirestore.instance
                                       .collection('Services')
                                       .doc();

                                   final json = {
                                     'id': service_name,
                                     'charge': int.parse(charges.text),
                                     'service': service.text,
                                     'doc_id': doc.id,
                                   };

                                   all_data_map[doc.id] = json;
                                   print(all_data_map);


                                   Navigator.pop(context, all_data_map);
                                   charges.clear();
                                   service.clear();
                                 }
                               else
                                 {
                                   showDialog(
                                       context: context,
                                       builder: (context) => AlertDialog(
                                         title:
                                         Text('Service Name is similar to another service\nPlease change the name' , textScaleFactor: AppTheme.alert,),
                                         actions: [
                                           TextButton(onPressed: (){
                                             Navigator.pop(context);

                                           }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                         ],
                                       ));

                                 }


                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 1.h,
                    )
                  ]),
            ),
          ),
        ],
      )
    ),
  );
}
