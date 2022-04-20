import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter_app/default.dart';
import 'package:flutter_app/storage/storage.dart';
import 'package:flutter_app/widgets/Add_Data.dart';
import 'package:flutter_app/widgets/add_medicines.dart';



import 'dart:math' as math;

import 'package:responsive_sizer/responsive_sizer.dart';

class Medicines extends StatefulWidget {
  bool delete, select;

  List<String> name;
  Map<String , Map<String , dynamic>> result_map={};



  Medicines({this.delete, this.select , this.name ,this.result_map});



  @override
  _State createState() => _State();
}

class _State extends State<Medicines> {
  var textcontroller = TextEditingController();

  Future f;

  List all_medicine_map_list = [];
  List search_medicine_list = [];

  List medicine_name = [];

  Map<String , Map<String , dynamic >> all_data_doc_id_map={};
  Map<String , Map<String , dynamic >> all_data_name_map={};

  bool updated = false;


  List<Color> color = [];

  Map<String, Map<String, dynamic>> result_map = {};


  int c = -1;

  bool delete = true;
//  bool select = false;

  Future getMedicineData() async {


          color = [];

          medicine_name = [];

          all_medicine_map_list = [];
          search_medicine_list = [];

           c = -1;




      var a = await Storage.get_medicine();

      print('\nssss');
      print(a);


      all_data_doc_id_map = a==null?{}:a;

      print('fssv');


      print(all_data_doc_id_map);


      all_data_doc_id_map.forEach((key, value) {

        print('Nor errcsdwq');


       all_data_name_map[value['medicine_name'].toString()] = value;


       medicine_name.add(value['medicine_name']);
     });

     setState(() {
       medicine_name=medicine_name;

       search_medicine_list = medicine_name;
     });

          color.length = medicine_name.length;


          for (int i = 0; i < color.length; i++) {
            color[i] =
            Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
          }

          print('ffff');



          print(all_data_doc_id_map);




    if(widget.result_map != null)
      {
        List a = widget.result_map.keys.toList();
        print('result map is not null');

        print(a);

        a.forEach((element) {
          all_data_name_map[element].forEach((key, value) {
            if(key == 'select')
              all_data_name_map[element]['select'] = true;




          });
        });

        setState(() {
          all_data_name_map = all_data_name_map;
          print('fddbf');
          print(all_data_name_map);


        });
      }




  }

  void set(){
    Storage.set_medicine(value: all_data_doc_id_map, updated: updated);
  }

  onItemChanged(String value) {
    setState(() {
      search_medicine_list = medicine_name
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if (search_medicine_list.isEmpty) {
        search_medicine_list = [];
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    set();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();




    if (widget.delete == false) {
      setState(() {
        delete = false;

      });
    }

    if(widget.result_map != null)
      {
        print('\n init ');

        print(result_map);

        result_map = widget.result_map;

        print(result_map);


      }





    f = getMedicineData();
  }

  Widget Tile(
      {Map<String, Map<String, dynamic>> map, String name, Color color}) {

    String tab="" , composition ="" , company_name = "";

    List a = map[name]['tab'];
    tab=a==null?"":a[0].toString();

    List b = map[name]['composition']==null?[]:map[name]['composition'];

    print('\ncds');

    if(b != null && b.isNotEmpty) {
      b.forEach((element) {

        composition = element.toString() + ' , ';
      });
    }

    print(map[name]['company_name']);




    List c = map[name]['company_name'];
    company_name=c==null?"":c[0].toString();






    return GestureDetector(
        onTap: () {
         if(delete)
           {
             showDialog(
                 context: context,
                 builder: (context) => AddMedicine(
                     composition: map[name]['composition'],
                     company_name: map[name]['company_name'],
                     tab: map[name]['tab'],
                     doc_id: map[name]['doc_id'],
                     medicine_name: name,
                     result: all_data_doc_id_map,
                   ),
                 ).then((value) {
               if (value == 'save') {

                 print('\neee');

                 getMedicineData();
               }
             });
           }
         else if(!delete)
           {
             print(result_map[name]);
             print('feeaar');


             showDialog(context: context, builder: (context)=> AddData(
                 color: color,
                 map: map,
                 medicine_name: name,
                 result_map : result_map[name]
               ),
             ).then((value) {

               print('\nBack from add data');
               print(value);

               if(value != null)
                 {


                   result_map[name] = value;




                 }
             });
           }
        },
        child: Padding(
          padding:  EdgeInsets.all(4.w),
          child: Material(
            elevation: 4,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                tileColor: AppTheme.notWhite,
                leading: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: color),
                  child: Center(child: Text(tab.toUpperCase())),
                ),
                title: Text(
                  name,

                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(composition),
                    Text(
                      company_name,
                      style:
                          TextStyle( fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                isThreeLine: true,
                trailing: delete
                    ? IconButton(
                        onPressed: () async {

                          all_data_doc_id_map.remove(map[name]['doc_id'].toString());
                          updated=true;

                          all_data_name_map.remove(name);
                          search_medicine_list.remove(name);

                          setState(() {
                            all_data_name_map = all_data_name_map;

                          });

                         setState(() {
                           medicine_name.remove(name);
                         });

                        },
                        icon: Icon(Icons.delete_outline_outlined),
                      )
                    : IconButton(
                        onPressed: () {



                          setState(() {
                            map[name]['select'] = !map[name]['select'];

                          });



                          if(map[name]['select'])
                            {


                              print(result_map);




                              showDialog(context: context, builder: (context){

                                return AddData(
                                  color: color,
                                  map: map,
                                  medicine_name: name,
                                );
                              }).then((value) {

                                print('rtttt');
                                print(value);


                               if(value != null)
                                 {
                                   result_map[name]  = value;
                                 }

                               print(result_map[name]);



                              });

                            }
                          else if(!map[name]['select'])
                            {
                              print('\n in else if');
                              print(map[name]);

                              result_map.remove(name);


                              print(result_map);


                            }




                        },
                        icon: CircleAvatar(
                          backgroundColor: map[name]['select']?AppTheme.green:Colors.grey,
                            child: Icon(
                          Icons.done,
                          color: Colors.white,
                        )),
                      ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [


                AppBar(
                  title: Text('XyZ' ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Visibility(
                        visible: delete?false:true,
                        child: IconButton(
                          icon: Icon(Icons.save),
                          onPressed: (){
                            Navigator.pop(context , result_map);

                          },
                        ))
                  ],
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w , vertical: 2.h),

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




                        suffixIcon: Icon(Icons.search)),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ],
            )),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: f,
              builder: (context, snapshot) {
                c = -1;

                print(snapshot.data);

                if (search_medicine_list.isEmpty) {
                  return Center(
                      child: Card(
                          color: AppTheme.notWhite,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text('loadin' ),
                          )));
                }




                return Container(
                  height: MediaQuery.of(context).size.height * 0.727,
                  child: RefreshIndicator(
                    onRefresh: getMedicineData,
                    child: ListView(
                      children: search_medicine_list.map<Widget>((e) {
                        c++;

                        return Tile(
                            map: all_data_name_map,
                            name: e.toString(),
                            color: color[c]);
                      }).toList(),
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        elevation: 15,
        splashColor: AppTheme.notWhite,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AddMedicine(
                composition: null,
                result: all_data_doc_id_map,
              )).then((value) {

                    print('dd');


                    if(value == 'save')
                      { print('\nggg');
                        getMedicineData();
                      }
          });
        },
        child: Icon(
          Icons.add,
          color: AppTheme.white,
        ),
        backgroundColor: AppTheme.teal,
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppTheme.offwhite,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
