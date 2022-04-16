
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/default.dart';


import 'package:flutter_app/storage/storage.dart';
import 'package:flutter/services.dart';

class Vital_List_Search extends StatefulWidget {

  List result;
  Vital_List_Search({this.result});

  @override
  _Vital_List_SearchState createState() => _Vital_List_SearchState();
}

class _Vital_List_SearchState extends State<Vital_List_Search> {


  List group_all_data_list =[] ;
  List group_updated_result = [];
  Map<String , Map<String , dynamic >> all_data_map={};
  Map<String , String> all_data_name_map={};

  bool updated = false;

  var unit_edit = TextEditingController();



  List group_search_data_list = [];

  Map<String, bool> select = {};



  Future f;


  var search_edit = TextEditingController();



  Future<void> get() async {


    group_updated_result=[];
    group_search_data_list=[];
    group_all_data_list=[];
    all_data_map={};



    var a = await Storage.get_tab();

    print(a);

    all_data_map = a==null?{}:a;

    print(all_data_map);


    setState(() {

      all_data_map = all_data_map;

      all_data_map.forEach((key, value) {
        group_all_data_list.add(value['vital_name']);
        all_data_name_map[value['vital_name']] = key;


      });

      group_search_data_list=group_all_data_list;


    });

    if(widget.result.isNotEmpty)
      {
        print(widget.result);

      }




  }

  void set() async {

    print('aassd');




    print(all_data_map);










    await Storage.set_tab(value: all_data_map , updated:  updated );
  }

  void pop(){
    Navigator.pop(context, group_updated_result);
  }

  void onChange(String s){

    group_all_data_list.add(s);
    select[s] = false;

  }

  onItemChanged(String value) {
    setState(() {
      if(group_all_data_list != null)
      {
        group_search_data_list = group_all_data_list
            .where((string) => string.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
      if (group_search_data_list.isEmpty) {
        group_search_data_list = [];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    set();

    group_updated_result=[];
    group_search_data_list=[];
    group_all_data_list=[];
    all_data_map={};


  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){

        pop();


      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              pop();
            },
          ),
          title: Padding(
            padding: const EdgeInsets.all(0),
            child: TextField(
              controller: search_edit,
              decoration: InputDecoration(
                hintText: 'Search / Add ',
              ),
              onChanged: onItemChanged,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: CircleAvatar(
                backgroundColor: AppTheme.teal,
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){


                    showDialog(context: context, builder: (context)=>Card(


                    ));
                  },
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: f,
          builder: (context,snapshot){


            if(group_search_data_list.isNotEmpty)
            {
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(

                    width: double.infinity,
                    child:  ListView(
                      shrinkWrap: true,
                      children: group_search_data_list
                          .map<Widget>((e) {






                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 2,

                            child: ListTile(


                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SelectableText(
                                    e,
                                  ),


                                  Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context).size.width*0.150,
                                            child: TextField(
                                              controller: unit_edit,

                                              decoration: InputDecoration(

                                                hintText: "Unit",
                                              )
                                              ,
                                              keyboardType: TextInputType.number,
                                            )

                                        ),
                                        SizedBox(width: 4,),

                                        Text('Unit'),
                                      ],
                                    ),
                                  )

                                ],
                              ),


                            ),
                          ),
                        );

                      })
                          .toList(),
                    )),
              );

            }

            else{
              ('in future builder , else');

              return Center(child:CircularProgressIndicator() );
            }

          },
        ),
      ),
    );
  }
}

Widget Dialogue(
    {String service_name,
      TextEditingController vital_name,
      TextEditingController vital_unit,
      BuildContext context,
      int size}) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 200),
      child: Material(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 10,
              ),
              Text(
                vital_name.text==null?'Add Vital':vital_name.text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.03),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                child: TextField(
                  controller: vital_name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Vital Name',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                child: TextField(
                  controller: vital_unit,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Vital Unit',

                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
              SizedBox(
                height: 20,
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

                          if (vital_name.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Vital Name field is required'),
                                ));
                          }

                          if (vital_unit.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Vital Unit field is required'),
                                ));
                          }

                          Map<String, Map<String, dynamic>> all_data_map = {};

                          var doc = await FirebaseFirestore.instance
                              .collection('Vital')
                              .doc();



                          final json = {

                            'vital_name': vital_name.text,
                            'vital_unit': vital_unit.text,
                            'doc_id': doc.id,
                            'unit_edit' : TextEditingController()

                          };

                          all_data_map[doc.id] = json;
                          print(all_data_map);

                          //  Services();

                          Navigator.pop(context, all_data_map);

                          vital_unit.clear();
                          vital_name.clear();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ));
}


