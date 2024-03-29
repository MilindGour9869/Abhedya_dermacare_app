import 'package:flutter/material.dart';

//App Theme
import 'package:flutter_app/default.dart';

//Local Storage
import 'package:flutter_app/storage/storage.dart';

//screen
import 'Add_Data.dart';
import 'add_medicines.dart';

//External Libs
import 'dart:math' as math; // for color of medicine
import 'package:responsive_sizer/responsive_sizer.dart';

class Medicines extends StatefulWidget {
  
  
  bool? to_add_medicne = false , to_select_medicine = false;


  
  Map<String , Map<String , dynamic>>? result_map={};

  Medicines({ required this.to_add_medicne, required this.to_select_medicine  , this.result_map});



  @override
  _State createState() => _State();
}

class _State extends State<Medicines> {
  
  var textcontroller = TextEditingController();

  late Future f;

  List all_medicine_map_list = [];
  List<String> search_medicine_list = [];
  List<String> medicine_name = [];



  late  Map<String , Map<String , dynamic >> all_medicine_data_doc_id_map;
  late  Map<String , Map<String , dynamic >> all_medicine_data_name_map;

  bool updated = false;

  List<Color> color = [];

  Map<String, Map<String, dynamic>> result_map = {};


  int c = -1;

  bool delete = true;
//  bool select = false;

  Future<void> getMedicineData() async {

    color = [];

    all_medicine_map_list = [];
    search_medicine_list = [];

    c = -1;

    final a = await Storage.get(key: 'medicine');

    if(a!=null)
      {
        all_medicine_data_doc_id_map = a;
        all_medicine_data_doc_id_map.forEach((key, value) {


          value['select'] = false;

          all_medicine_data_name_map[value['medicine_name'].toString()] = value;

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




        if(widget.result_map != null)
        {
          List a = widget.result_map!.keys.toList();
          print('result map is not null');

          print(a);

          a.forEach((element) {
            all_medicine_data_name_map[element]!.forEach((key, value) {
              if(key == 'select')
                all_medicine_data_name_map[element]!['select'] = true;




            });
          });

          setState(() {
            all_medicine_data_name_map = all_medicine_data_name_map;
            print('fddbf');
            print(all_medicine_data_name_map);


          });
        }

      }



    




  }

  void set(){
    Storage.set(key: 'medicine', value: all_medicine_data_doc_id_map);
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




    if (widget.to_add_medicne == false) {
      setState(() {
        delete = false;

      });
    }

    if(widget.result_map != null)
      {
        

        result_map = widget!.result_map!;

       


      }





    f = getMedicineData();
  }

  Widget Tile(
      {required Map<String, Map<String, dynamic>> map, required String name, required Color color}) {



    String tab="" , composition ="" , company_name = "";

    String a = map[name]!['tab'];
    tab=a==null?"":a;

    List b = map[name]!['composition']==null?[]:map[name]!['composition'];

    if(b != null && b.isNotEmpty) {
      b.forEach((element) {

        composition = element.toString() + ' , ';
      });
    }






    company_name=map[name]!['company_name']==null?"": map[name]!['company_name'];






    return GestureDetector(
        onTap: () {
         if(delete)
           {

             print('ggg');


             print(map[name]);


             showDialog(
                 context: context,
                 builder: (context) => AddMedicine(

                     single_medicine_map: map[name],
                     medicine_name_list: all_medicine_data_name_map.keys.toList(),
                     all_medicine_data_doc_id_map: all_medicine_data_doc_id_map,
                     is_add_icon_tap: false,

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
                 result_map : result_map[name]!
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

                          all_medicine_data_doc_id_map.remove(map[name]!['doc_id'].toString());
                          updated=true;

                          all_medicine_data_name_map.remove(name);
                          search_medicine_list.remove(name);

                          setState(() {
                            all_medicine_data_name_map = all_medicine_data_name_map;

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
                            map[name]!['select'] = map[name]!['select'];

                          });



                          if(map[name]!['select'])
                            {

                              showDialog(context: context, builder: (context){

                                return AddData(
                                  color: color,
                                  map: map,
                                  medicine_name: name,
                                );
                              }).then((value) {



                               if(value != null)
                                 {
                                   result_map[name]  = value;
                                 }





                              });

                            }
                          else if(!map[name]!['select'])
                            {

                              result_map.remove(name);


                            }




                        },
                        icon: CircleAvatar(
                          backgroundColor: map[name]!['select']?AppTheme.green:Colors.grey,
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
                    title: Text('Medicine' ),
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
                          hintStyle:  AppTheme.k_search_text_style





                      ),
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
                              padding:  EdgeInsets.all(5.w),
                              child: Text('loading' ),
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
                              map: all_medicine_data_name_map,
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

            print('\ndbflbv');

            print(medicine_name);


            showDialog(
                context: context,
                builder: (context) => AddMedicine(

                  all_medicine_data_doc_id_map : all_medicine_data_doc_id_map,
                  medicine_name_list: medicine_name!,
                  is_add_icon_tap: true,
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
      ),
    );
  }
}
