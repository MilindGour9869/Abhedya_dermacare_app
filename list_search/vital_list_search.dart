
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/default.dart';


import 'package:flutter_app/storage/storage.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Vital_List_Search extends StatefulWidget {

  Map<String , Map<String , dynamic >> result;
  Vital_List_Search({this.result});

  @override
  _Vital_List_SearchState createState() => _Vital_List_SearchState();
}

class _Vital_List_SearchState extends State<Vital_List_Search> {


  List group_all_data_list =[] ;


  Map<String , Map<String , dynamic >> all_data_map={};
  Map<String , String> all_data_name_map={};
  Map<String , Map<String , dynamic >> result_map={};
  Map<String , dynamic> edit_map={};


  bool updated = false;

  var unit = TextEditingController();
  var vital = TextEditingController();



  List group_search_data_list = [];

  Map<String, bool> select = {};

  var bp_v1_edit = TextEditingController();
  var bp_v2_edit = TextEditingController();

  bool clear = false;



  Future f;


  var search_edit = TextEditingController();



  Future<void> get() async {



    group_search_data_list=[];
    group_all_data_list=[];
    all_data_map={};






    var a = await Storage.get_vital();

    print(a);

    print('\n eferrrgr');


    all_data_map = a==null?{}:a;

    print(all_data_map);


    setState(() {

      all_data_map = all_data_map;

      all_data_map.forEach((key, value) {
        group_all_data_list.add(value['vital_name']);
        all_data_name_map[value['vital_name']] = key;

        edit_map[key] = TextEditingController();




      });



      group_search_data_list=group_all_data_list;


    });

    if(widget.result.isNotEmpty)
      {
        result_map = widget.result;

       String s =  widget.result['Blood Pressure']['value'];
       List a = s.split('/');
       bp_v1_edit.text=a[0];
       bp_v2_edit.text=a[1];


      }




  }

  void set() async {

    print('aassd');




    print(all_data_map);










    await Storage.set_vital(value: all_data_map , updated:  updated );
  }

  void pop(){

    if(bp_v1_edit.text.isNotEmpty){
      if(bp_v2_edit.text.isNotEmpty)
        {
          OnComplete(
            vital_name: 'Blood Pressure',
            vital_unit: 'mmHg',
            value: bp_v1_edit.text,
            value2: bp_v2_edit.text,

          );
        }
    }




    edit_map.forEach((key, value) {

      if(value.text.isNotEmpty)
        {
          OnComplete(
            vital_name: all_data_map[key]['vital_name'],
            vital_unit: all_data_map[key]['vital_unit'],
            value: value.text
          );


        }
    });

    Navigator.pop(context,result_map);
  }

  void onChange(String s){

    group_all_data_list.add(s);
    select[s] = false;

  }



  OnComplete({String vital_name , String value , String vital_unit , String value2})
  {
    print(value);

   if(value.isNotEmpty)
     {
       if(vital_name == 'Blood Pressure')
         {
           Map<String,dynamic> map ={};
           map['vital_name'] = vital_name;
           map['value'] = value + '/' + value2;
           map['vital_unit'] = vital_unit;

           result_map[vital_name] = map;
         }
       else
         {
           Map<String,dynamic> map ={};
           map['vital_name'] = vital_name;
           map['value'] = value;
           map['vital_unit'] = vital_unit;

           result_map[vital_name] = map;
         }

     }



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
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 2.w  , vertical: 3.h),
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
              child: Text('Vitals' , style: TextStyle(color: Colors.black),textScaleFactor: AppTheme.list_tile_subtile,),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(onPressed: (){

                  setState(() {
                    clear=true;

                    bp_v1_edit.clear();
                    bp_v2_edit.clear();
                    result_map={};

                  });



                }, icon: Icon(Icons.refresh_outlined , color: Colors.grey, size: 9.w,)),
              ),
              Padding(
                padding:  EdgeInsets.only(right: 2.w),
                child: SizedBox(
                  height: 1.h,
                  child: CircleAvatar(
                    backgroundColor: AppTheme.teal,
                    child: IconButton(
                      icon: Icon(Icons.add , color: Colors.white,),
                      onPressed: (){


                        showDialog(context: context, builder: (context)=>Dialogue(vital_unit: unit , vital_name: vital , context: context )).then((value) {

                          if(value !=null)
                            {
                              all_data_map.addAll(value);
                              updated=true;
                              set();
                              get();

                            }

                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: FutureBuilder(
            future: f,
            builder: (context,snapshot){




              if(true)
              {
                return  Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 1.w  , vertical: 1.w),
                      child: Material(
                        elevation: 2,
                        child: ListTile(

                          leading: Icon(Icons.arrow_forward_ios_rounded , color: AppTheme.teal, size: 6.w,),


                          title: Text(
                            "Blood Pressure ",
                            textScaleFactor: AppTheme.list_tile_subtile,
                          ),
                          trailing: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width*0.150,
                                    child: TextField(
                                      controller:bp_v1_edit ,
                                        decoration: InputDecoration(

                                          hintText: '0.00',
                                        ),
                                      keyboardType: TextInputType.number,


                                    )

                                ),
                                SizedBox(width: 3,),


                                SizedBox(
                                    width: MediaQuery.of(context).size.width*0.150,
                                    child: TextField(
                                      controller: bp_v2_edit,


                                      decoration: InputDecoration(

                                        hintText: '0.00',
                                      )
                                      ,
                                      keyboardType: TextInputType.number,
                                    )

                                ),
                                SizedBox(width: 4,),

                                Text('mmHg'),

                              ],
                            ),
                          ),


                        ),
                      ),
                    ),

                    ListView(
                      shrinkWrap: true,
                      children: group_search_data_list
                          .map<Widget>((e) {

                            print(all_data_map);


                            String s = all_data_name_map[e];


                            String name =  all_data_map[s]['vital_name'];
                            String unit = all_data_map[s]['vital_unit'];

                            if(widget.result.isNotEmpty)
                              {

                                 edit_map[s].text = widget.result[e]['value'];



                              }

                            if(clear == true)
                              {
                                edit_map.forEach((key, value) {
                                  value.clear();
                                });

                              }







                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 2,

                            child: ListTile(

                              leading: Icon(Icons.arrow_forward_ios_rounded , color: AppTheme.teal,),


                              title: Container(
                                child: Text(name , textScaleFactor: AppTheme.list_tile_subtile,),
                              ),
                              trailing:  Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width*0.150,
                                        child: TextField(

                                          controller: edit_map[s],

                                          decoration: InputDecoration(

                                            hintText: "0.00",
                                          )
                                          ,
                                          keyboardType: TextInputType.number,
                                        )

                                    ),


                                    Text(unit),

                                    IconButton(onPressed: (){

                                      all_data_map.remove(s);
                                      updated=true;
                                      set();
                                      get();


                                    }, icon: Icon(Icons.delete_outline_outlined , color: Colors.grey,))
                                  ],
                                ),
                              ),


                            ),
                          ),
                        );

                      })
                          .toList(),
                    ),
                  ],
                );

              }

              else{
                ('in future builder , else');

                return Center(child:CircularProgressIndicator() );
              }

            },
          ),
        ),
      ),
    );
  }
}

Widget Dialogue(
    {
      TextEditingController vital_name,
      TextEditingController vital_unit,
      BuildContext context,
    }) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 2.w),
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  vital_name.text.isEmpty?'Add Vital':vital_name.text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Material(
                  child: TextField(
                    style: TextStyle(
                        fontSize: 4.w
                    ),
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
                  height: 2.h,
                ),
                Material(
                  child: TextField(
                    style: TextStyle(
                        fontSize: 4.w
                    ),
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
                ),

                SizedBox(height: 1.h,)
              ]),
            ),
          ),

        ],
      ),
    ),
  );
}


