import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/classes/add_info.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/add_medicines.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:math' as math;

class Medicines extends StatefulWidget {
  bool delete, select;
  Medicines({this.delete, this.select});

  @override
  _State createState() => _State();
}

class _State extends State<Medicines> {
  var textcontroller = TextEditingController();

  Future f;

  List all_medicine_map_list = [];
  List search_medicine_list = [];

  List medicine_name = [];

  Map<String, Map<String, dynamic>> all_medicine_name_map_data = {};
  Map<String, dynamic> map = {};

  List<Color> color = [];

  int c = -1;

  bool delete = false;
  bool select = false;

  Future getMedicineData() async {
    await FirebaseFirestore.instance
        .collection('Medicines')
        .get()
        .then((QuerySnapshot querySnapshot) {
      color = [];

      medicine_name = [];

      all_medicine_map_list = [];
      search_medicine_list = [];

      map = {};
      all_medicine_name_map_data = {};
      c = -1;

      color.length = querySnapshot.size;

      for (int i = 0; i < color.length; i++) {
        color[i] =
            Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
      }

      querySnapshot.docs.forEach((element) {
        all_medicine_map_list.add(element.data());
      });

      print(all_medicine_map_list);

      medicine_name = all_medicine_map_list.map((e) {
        map['composition'] = e['composition'];
        map['company_name'] = e['company_name'];
        map['medicine_name'] = e['medicine_name'];
        map['tab'] = e['tab'];
        map['doc_id'] = e['id'].toString();
        map['select'] = select;

        all_medicine_name_map_data[e['medicine_name'].toString()] = map;

        map = {};

        return e['medicine_name'];
      }).toList();

      print('awertt');

      print(medicine_name);

      setState(() {
        medicine_name= medicine_name;

        search_medicine_list = medicine_name;
      });
    });
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
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.delete == true) {
      setState(() {
        delete = true;
        select = false;
      });
    } else if (widget.select == true) {
      setState(() {
        delete = false;
        select = true;
      });
    }

    f = getMedicineData();
  }

  Widget Tile(
      {Map<String, Map<String, dynamic>> map, String name, Color color}) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: AddMedicine(
                      composition: map[name]['composition'],
                      company_name: map[name]['company_name'],
                      tab: map[name]['tab'],
                      doc_id: map[name]['doc_id'],
                      medicine_name: name,
                    ),
                  )).then((value) {
            if (value == 'save') {
              getMedicineData();
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  child: Center(child: Text(map[name]['tab'].toUpperCase())),
                ),
                title: Text(
                  name,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${map[name]['composition']}'),
                    Text(
                      '${map[name]['company_name']}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                isThreeLine: true,
                trailing: delete
                    ? IconButton(
                        onPressed: () async {

                          var doc = await FirebaseFirestore.instance
                              .collection('Medicines')
                              .doc(map[name]['doc_id']);
                          doc.delete();

                         setState(() {
                           medicine_name.remove(name);
                         });

                        },
                        icon: Icon(Icons.delete_outline_outlined),
                      )
                    : IconButton(
                        onPressed: () {
                          print(map[name]['select']);


                          setState(() {
                            map[name]['select'] = !map[name]['select'];

                          });

                          if(map[name]['select'])
                            {

                              Map<String , bool> map2={
                                'Morning' : false,
                                'Afternoon' : false,
                                'Evening' : false,
                                'Night' : false,

                              };

                              showDialog(context: context, builder: (context){

                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0  , vertical: 200),
                                  child:Card(

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                       ListTile(
                                         tileColor: AppTheme.notWhite,
                                         leading: Container(
                                           height: MediaQuery.of(context).size.height * 0.08,
                                           width: MediaQuery.of(context).size.width * 0.15,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(5), color: color),
                                           child: Center(child: Text(map[name]['tab'].toUpperCase())),
                                         ),
                                         title: Text(
                                           name,
                                           style: TextStyle(fontSize: 20),
                                         ),
                                         subtitle: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text('${map[name]['composition']}'),
                                             Text(
                                               '${map[name]['company_name']}',
                                               style:
                                               TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                             ),
                                           ],
                                         ),
                                         isThreeLine: true,
                                       ),
                                        SizedBox(height: 10,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: map2.keys.map<Widget>((e) =>GestureDetector(
                                            onTap: (){

                                              setState(() {
                                                map2.forEach((key, value) {
                                                  print('cc');

                                                  value=false;

                                                });
                                                map2[e] = ! map2[e];


                                              });



                                            },
                                            child: CircleAvatar(
                                              backgroundColor: map2[e]?AppTheme.teal:Colors.grey,
                                              child: Text(e[0] , style: TextStyle(color: Colors.white),),
                                            ),
                                          ), ).toList()
                                        ),
                                        SizedBox(height: 10,),

                                        TextButton(
                                          child: Text('Add Additional info'),
                                          onPressed: (){
                                            showDialog(context: context, builder: (context)=>Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0  , vertical: 40),
                                              child: Add_Info(),
                                            ));
                                          },
                                        ),
                                      ],
                                    ),



                                  ),
                                );
                              });

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
        preferredSize: Size.fromHeight(200),
        child: Container(
          decoration: BoxDecoration(
              color: AppTheme.teal,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              )),
          height: MediaQuery.of(context).size.height * 0.23,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBar(
                title: Text('Medicine'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 23.0, right: 40, left: 40, bottom: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
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
        ),
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
                            child: Text('loadin'),
                          )));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Something Went Wrong'));
                }

                return Container(
                  height: MediaQuery.of(context).size.height * 0.727,
                  child: RefreshIndicator(
                    onRefresh: getMedicineData,
                    child: ListView(
                      children: search_medicine_list.map<Widget>((e) {
                        c++;

                        return Tile(
                            map: all_medicine_name_map_data,
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
              builder: (context) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: AddMedicine(
                      composition: null,
                    ),
                  )).then((value) {

                    if(value == 'save')
                      {
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
