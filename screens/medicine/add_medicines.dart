import 'package:flutter/material.dart';

//screen
import 'package:flutter_app/custom_widgets/loading_screen.dart';
import 'package:flutter_app/list_search/list_search.dart';

//App theme
import 'package:flutter_app/default.dart';

//Local Storage
import 'package:flutter_app/storage/storage.dart';

//firebase
import 'package:cloud_firestore/cloud_firestore.dart';

//External libs
import 'package:responsive_sizer/responsive_sizer.dart';


class AddMedicine extends StatefulWidget {


  Map<String,dynamic>? single_medicine_map ; // Lenght = 1

  bool is_add_icon_tap;

  Map<String , Map<String,dynamic> >? all_medicine_data_doc_id_map;

  List<String> medicine_name_list ;


  AddMedicine(
      {
        required this.medicine_name_list, //check whether the medicine name is exist or not
        required this.is_add_icon_tap,


         this.single_medicine_map,
         this.all_medicine_data_doc_id_map,
      });

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {

  String composition = "Composition";
  String company_name = "Company Name";
  String tab = "TAB/CAP/SYP";

  late List<String>? Tab ;
  late List<String>? Composition ;
  late List<String>? Company_name ;

  var medicine_name_edit = TextEditingController();
  var medicine_notes_edit = TextEditingController();



  DropdownMenuItem<String> Menu(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }


  Map<String, bool> map = {
    'composition': false,
    'company_name': false,
    'tab': false,
  };

  Future<void>? init_state(){

    if(widget.single_medicine_map != null) {

      if (widget.single_medicine_map!['composition'] != null) {
        Composition = widget.single_medicine_map!['composition'];
      }

      if (widget.single_medicine_map!['company_name'] != null) {
        Company_name = widget.single_medicine_map!['company_name'];
      }
      if (widget.single_medicine_map!['tab'] != null) {
        Tab = widget.single_medicine_map!['tab'];
      }

      setState(() {

        if (widget.single_medicine_map!['medicine_name'] != null) {
          setState(() {
            medicine_name_edit.text =
            widget.single_medicine_map!['medicine_name'];
          });
        }

        if (widget.single_medicine_map!['medicine_notes'] != null) {
          medicine_notes_edit.text =
          widget.single_medicine_map!['medicine_notes'];
        }

        if (Tab != null) {
          Tab!.forEach((element) {
            tab = element.toString() + ' , ';
          });
          map['tab'] = true;
        }

        if (Composition != null) {
          Composition!.forEach((element) {
            composition = element.toString() + ' , ';
          });
          map['composition'] = true;
        }

        if (Company_name != null) {
          Company_name!.forEach((element) {
            company_name = element.toString() + ' , ';
          });
          map['company_name'] = true;
        }
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init_state();

    }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
                  Padding(
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
                          visible: widget.is_add_icon_tap? false : true,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: IconButton(
                              icon: Icon(Icons.delete_outline_outlined),
                              onPressed: () async {

                                if(widget.all_medicine_data_doc_id_map!=null)
                                  {
                                    widget.all_medicine_data_doc_id_map!.remove(widget.single_medicine_map!.keys.toString());
                                    await Storage.set(key: 'medicine', value: widget.all_medicine_data_doc_id_map!);
                                  }


                                Navigator.pop(context, 'save');
                              },
                            ),
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
                        controller: medicine_notes_edit,
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
                                          color: map['tab']!
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
                                      return List_Search(result: Tab, get: Storage.get, set: Storage.set, group: 'tab', Group: 'Tab', one_select: true, ky: 'tab');
                                    }).then((value) async {

                                  if (value != null) {

                                    Tab = value;
                                    tab = '';
                                    Tab!.forEach((element) {
                                      tab += element + ' , ';
                                    });
                                    setState(() {
                                      tab = tab;
                                      map['tab'] = true;
                                    });
                                  }
                                  else  {

                                    setState(() {
                                      Tab = null;
                                      tab = 'TAB/CAP/SYP';
                                      map['tab'] = false;
                                    });
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
                                          color: map['composition']!
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
                                      return List_Search(result: Composition, get: Storage.get, set: Storage.set, group: 'composition', Group: 'Composition', one_select: false, ky: 'composition');
                                    }).then((value) async {


                                  if (value != null) {

                                    Composition = value;
                                    composition = '';
                                    Composition!.forEach((element) {
                                      composition += element + ' , ';
                                    });
                                    setState(() {
                                      composition= composition;
                                      map['composition'] = true;
                                    });
                                  }
                                  else  {

                                    setState(() {
                                      Composition = null;
                                      composition = 'Composition';
                                      map['composition'] = false;
                                    });
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
                                          color: map['company_name']!
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
                                      return List_Search(result: Company_name, get: Storage.get, set: Storage.set, group: 'company_name', Group: 'Company_Name', one_select: false, ky: 'company_name');
                                    }).then((value) async {

                                  if (value != null) {

                                    Company_name = value;
                                    company_name = '';
                                    Company_name!.forEach((element) {
                                      company_name += element + ' , ';
                                    });
                                    setState(() {
                                      company_name= company_name;
                                      map['company_name'] = true;
                                    });
                                  }
                                  else  {

                                    setState(() {
                                      Company_name = null;
                                      company_name = 'Company Name';
                                      map['company_name'] = false;
                                    });
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
                  Container(
                    margin:  EdgeInsets.symmetric(horizontal: 2.w , vertical: 2.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom:Radius.circular(4)
                      )
                    ),
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
                          'Save',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {

                          if(medicine_name_edit.text.isEmpty)
                          {
                            ShowDialogue(context, 'Medicine Name is Compulsory');
                          }
                          else
                            {

                              //Similar Name checking
                              bool similar = false;
                              widget.medicine_name_list.forEach((element) {
                                if(medicine_name_edit.text == element)
                                  {
                                    similar=true;
                                  }
                              });
                              if(similar && widget.is_add_icon_tap)
                                {
                                  ShowDialogue(context, 'Medicine Name is Similar to Another medicine\nPlease Change the Name');
                                }

                              else
                              {
                                Map<String,dynamic> json={};


                                //Notes is String , not list here
                                if(medicine_notes_edit.text.isNotEmpty)
                                {
                                  json['medicine_notes'] = medicine_notes_edit.text;
                                }

                                //Tab & Company_name & Composition is a List<String>

                                if(Tab != null && Tab!.isNotEmpty)
                                {
                                  json['tab']= Tab.toString();
                                }
                                if(Company_name!=null && Company_name!.isNotEmpty)
                                {
                                  json['company_name'] = Company_name;
                                }
                                if(Composition !=null && Composition!.isNotEmpty)
                                {
                                  json['composition'] = Composition;

                                }

                                if(medicine_name_edit.text.isNotEmpty)
                                {
                                  json['medicine_name']=medicine_name_edit.text;
                                }

                                json['select'] = false; //used in List_Search , for Colour

                                if (widget.is_add_icon_tap) {

                                  var doc = await FirebaseFirestore.instance
                                      .collection('Medicines')
                                      .doc();
                                  json['doc_id']=doc.id;

                                  widget.all_medicine_data_doc_id_map![doc.id]=json;



                                  await Storage.set(key: 'medicine', value: widget.all_medicine_data_doc_id_map!);



                                }
                                else if (!widget.is_add_icon_tap) {

                                  json['doc_id']=widget.single_medicine_map!.keys.toString();

                                  widget.all_medicine_data_doc_id_map![json['doc_id']]=json;

                                  await Storage.set(key: 'medicine', value: widget.all_medicine_data_doc_id_map!);


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

            ],
          ),
        ),
      ),
    );
  }



}
