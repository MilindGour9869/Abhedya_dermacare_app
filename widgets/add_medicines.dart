import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/list_search/company_name_list_search.dart';
import 'package:flutter_app/list_search/composition_list_search.dart';

import 'package:flutter_app/storage/storage.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import '../list_search/tab_list_search.dart';

class AddMedicine extends StatefulWidget {


  Map<String , dynamic > medicine_map ;

  String  doc_id, medicine_name;

  bool add_icon_tap;


  Map<String , Map<String,dynamic> > result;

  List medicine_name_list = [];


  AddMedicine(
      {
      this.doc_id,
      this.medicine_name,
      this.result,
       @required this.medicine_name_list, //check whether the medicine name is exist or not
       @required   this.add_icon_tap,    // new or older
        this.medicine_map


      });

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  String composition = "Composition";
  String company_name = "Company Name";
  String tab = "TAB/CAP/SYP";

  List Tab = [];
  List Composition = [];
  List Company_name = [];

  var medicine_name_edit = TextEditingController();
  var medicine_notes = TextEditingController();

  Map<String, Map<String, dynamic>> result = {};

  DropdownMenuItem<String> Menu(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }

  String value;

  Map<String, bool> map = {
    'composition': false,
    'company_name': false,
    'tab': false,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.medicine_map != null)
      {
        if (widget.medicine_map['composition'] != null) {

          Composition = widget.medicine_map['composition'];

          setState(() {
            widget.medicine_map['composition'].forEach((element) {
              composition  = element.toString() + ' , ';
            });
            map['composition'] = true;
          });
        }
        if (widget.medicine_map['company_name'] != null) {

          Company_name.add(widget.medicine_map['company_name']);

          setState(() {
            company_name=widget.medicine_map['company_name'];
            map['company_name'] = true;
          });
        }
        if (widget.medicine_map['tab'] != null) {

          Tab.add(widget.medicine_map['tab']);

          setState(() {
            tab = widget.medicine_map['tab'];

            map['tab'] = true;
          });
        }
        if (widget.medicine_name != null) {
          setState(() {
            medicine_name_edit.text = widget.medicine_name;
          });
        }

        if(widget.medicine_map['medicine_notes']!=null)
        {
          medicine_notes.text = widget.medicine_map['medicine_notes'];

        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
                Material(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
              children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 1.h),
                          child: Text(
                            'Add/Edit Medicine',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),

                          ),
                        ),
                        Visibility(
                          visible: widget.add_icon_tap? false : true,
                          child: IconButton(
                            icon: Icon(Icons.delete_outline_outlined),
                            onPressed: () async {

                              widget.result.remove(widget.doc_id);

                              Storage.set_medicine(updated: true , value: widget.result);


                              Navigator.pop(context, 'save');
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 1.h,
                    ),

                    SizedBox(
                      height: 13.h,
                      child: TextField(
                        controller: medicine_name_edit,
                        decoration: InputDecoration(
                            labelText: 'Medicine Name',
                            helperText: 'Example - Parecetamol 250mg',
                            border: OutlineInputBorder()),
                      ),
                    ),

                    SizedBox(
                      height: 2.h,
                    ),

                    SizedBox(
                      height: 8.h,
                      child: TextField(
                        controller: medicine_notes,
                        decoration: InputDecoration(
                            labelText: 'Medicine Notes',
                            border: OutlineInputBorder()),
                      ),
                    ),

                    SizedBox(
                      height: 1.h,
                    ),



                    Card(
                      color: AppTheme.white,
                      child: Row(
                        children: [
                          SizedBox(
                            width:2.w ,
                          ),
                          Icon(Icons.comment),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(

                              width: MediaQuery.of(context).size.width * 0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 3.h),
                                  child: Text(tab,
                                      style: TextStyle(
                                          color: map['tab']
                                              ? Colors.black
                                              : Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          IconButton(
                              onPressed: () async {
                                //  print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 6.w , vertical: 4.h),
                                        child: Tab_List_Search(
                                          result: Tab,
                                        ),
                                      );
                                    }).then((value) async {
                                  print(value);
                                  print('returend');

                                  if (value != null) {
                                    print('if');

                                    Tab = [];
                                    Tab = value;
                                    List a = await value;

                                    print(a);

                                    tab = '';
                                    a.forEach((element) {
                                      tab += element + ' , ';
                                    });

                                    if (tab != "") {
                                      setState(() {
                                        tab = tab;
                                        map['tab'] = true;
                                      });
                                    } else {
                                      setState(() {
                                        Tab = [];
                                        tab = 'TAB/CAP/SYP';
                                        map['tab'] = false;
                                      });
                                    }
                                  } else if (value == null) {
                                    print('in else if');
                                    print(value);

                                    setState(() {
                                      Tab = [];
                                      tab = 'TAB/CAP/SYP';
                                      map['tab'] = false;
                                    });
                                  } else {
                                    print('in else');
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down_circle_outlined))
                        ],
                      ),
                    ),

                    // Tab

                    SizedBox(
                      height: 1.h,
                    ),

                    Card(
                      color: AppTheme.white,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          Icon(Icons.comment),
                          SizedBox(
                            width: 2.w,
                          ),


                          Flexible(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 3.h),
                                  child: Text(composition,
                                      style: TextStyle(
                                          color: map['composition']
                                              ? Colors.black
                                              : Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          IconButton(
                              onPressed: () async {
                                //  print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 6.w , vertical: 4.h),
                                        child: Composition_List_Search(
                                          result: Composition,
                                        ),
                                      );
                                    }).then((value) async {
                                  print(value);
                                  print('returend');

                                  if (value != null) {
                                    print('if');

                                    Composition = [];
                                    Composition = value;
                                    List a = await value;

                                    print(a);

                                    composition = '';
                                    a.forEach((element) {
                                      composition += element + ' , ';
                                    });

                                    if (composition != "") {
                                      setState(() {
                                        composition = composition;
                                        map['composition'] = true;
                                      });
                                    } else {
                                      setState(() {
                                        Composition = [];
                                        composition = 'Composition';
                                        map['composition'] = false;
                                      });
                                    }
                                  } else if (value == null) {
                                    print('in else if');
                                    print(value);

                                    setState(() {
                                      Composition = [];
                                      composition = 'Composition';
                                      map['composition'] = false;
                                    });
                                  } else {
                                    print('in else');
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down_circle_outlined))
                        ],
                      ),
                    ), //Composition

                    SizedBox(
                      height: 1.h,
                    ),

                    Card(
                      color: AppTheme.white,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          Icon(Icons.comment),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 3.h),
                                  child: Text(company_name,
                                      style: TextStyle(
                                          color: map['company_name']
                                              ? Colors.black
                                              : Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          IconButton(
                              onPressed: () async {
                                //  print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: 6.w , vertical: 4.h),
                                        child: Company_name_List_Search(
                                          result: Company_name,
                                        ),
                                      );
                                    }).then((value) async {
                                  print(value);
                                  print('returend');

                                  if (value != null) {
                                    print('if');

                                    Company_name = [];
                                    Company_name = value;
                                    List a = await value;

                                    print(a);

                                    company_name = '';
                                    a.forEach((element) {
                                      company_name += element + ' , ';
                                    });

                                    if (company_name != "") {
                                      setState(() {
                                        company_name = company_name;
                                        map['company_name'] = true;
                                      });
                                    } else {
                                      setState(() {
                                        Company_name = [];
                                        company_name = 'Company Name';
                                        map['company_name'] = false;
                                      });
                                    }
                                  } else if (value == null) {
                                    print('in else if');
                                    print(value);

                                    setState(() {
                                      Company_name = [];
                                      company_name = 'Company Name';
                                      map['company_name'] = false;
                                    });
                                  } else {
                                    print('in else');
                                  }
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down_circle_outlined))
                        ],
                      ),
                    ), // Company Name

                    SizedBox(
                      height: 1.h,
                    ),



              ],
            ),
                  ),
                ),
                Material(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
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

                          print(medicine_name_edit.text);


                          if(medicine_name_edit.text.isEmpty || medicine_name_edit.text == null)
                          {
                            showDialog(context: context, builder: (context)=>AlertDialog(
                              title: Text('Medicine Name is Compulsory' , textScaleFactor: AppTheme.alert,),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);

                                }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                              ],
                            ));


                          }
                          else
                            {
                              bool similar = false;
                              widget.medicine_name_list.forEach((element) {
                                if(medicine_name_edit.text == element)
                                  {
                                    similar=true;

                                  }
                              });

                              if(similar && widget.add_icon_tap)
                                {
                                  showDialog(context: context, builder: (context)=>AlertDialog(
                                    title: Text('Medicine Name is Similar to Another medicine\nPlease Change the Name ' , textScaleFactor: AppTheme.alert,),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);

                                      }, child: Text('OK' ,  textScaleFactor: AppTheme.alert,))
                                    ],
                                  ));


                                }
                              else
                              {
                                Map<String,dynamic> json={};

                                if(medicine_notes.text.isNotEmpty)
                                {
                                  json['medicine_notes'] = medicine_notes.text;
                                }
                                if(Tab.isNotEmpty)
                                {
                                  json['tab']= Tab[0].toString();
                                }
                                if(Company_name.isNotEmpty)
                                {
                                  json['company_name'] = Company_name[0].toString();
                                }
                                if(Composition.isNotEmpty)
                                {
                                  json['composition'] = Composition;

                                }



                                if(medicine_name_edit.text.isNotEmpty)
                                {
                                  json['medicine_name']=medicine_name_edit.text;
                                }

                                json['select'] = false;








                                if (widget.add_icon_tap) {

                                  print('\nin if ');

                                  var doc = await FirebaseFirestore.instance
                                      .collection('Medicines')
                                      .doc();
                                  json['doc_id']=doc.id;





                                  widget.result[doc.id]=json;



                                  Storage.set_medicine( value: widget.result,updated: true);



                                }
                                else if (!widget.add_icon_tap) {

                                  print('\nin else if ');




                                  json['doc_id']=widget.doc_id;

                                  widget.result[widget.doc_id.toString()]=json;

                                  Storage.set_medicine( value: widget.result,updated: true);

                                 }

                                Navigator.pop(context, 'save');
                              }

                            }


                        },
                      ),
                    ),
                  ],
              ),
            ),
                ),
                Material(
                  child: Container(
                    color: Colors.white,
              height: 1.h,
            ),
                ),
          ],
        ),
      ),
    );
  }
}
