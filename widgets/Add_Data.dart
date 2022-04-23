import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../list_search/add_info_list_search.dart';
import '../default.dart';

class AddData extends StatefulWidget {

  String medicine_name ;

  Map<String , Map<String , dynamic>> map;
  Map<String , dynamic>result_map;

  Color color;


  AddData({this.medicine_name  , this.color , this.map , this.result_map });

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  Map<String , Map<String , dynamic>> map;
  String name;
  Color color;

  Map<String , dynamic> result_map={

  };



  void pop(){
    List<String> time ;
    String duration;

    print(result_map['aa']);

    map2.forEach((key, v) {
      if(v)
      {
        time.add(key) ;
      }
    });

    duration = duration_edit.text;

    Map<String , String> tenure={};

    map3.forEach((key, v) {
      if(v)
      {
        tenure['tenure'] =  duration ;
        tenure['Duration'] = key;
      }
    });



    if(time !=null && duration !=null)
    {
      result_map['time'] = time;


      result_map['duration'] = tenure;

      result_map['add_info'] = all_data_english_list;

      print(result_map);



      Navigator.pop(context , result_map);
    }
    else{
      Navigator.pop(context);

    }
  }







  List<String> all_data_english_list =[] ;

  var duration_edit = TextEditingController();




  Map<String , bool> map2={
    'Morning' : false,
    'Afternoon' : false,
    'Evening' : false,
    'Night' : false,

  };

  Map<String , bool> map3={
    'Days' : true,
    'Weeks' : false,
    'Months' : false,
  };



  String value;






  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    map = widget.map;
    name = widget.medicine_name;
    color = widget.color;




      if(widget.result_map != null)
      {
        print('sssss');



        if(widget.result_map['time'] != null)
        {
          map2[widget.result_map['time']] = true;
        }
        if(widget.result_map['duration'] != null)

        {


          duration_edit.text = widget.result_map['duration']['tenure'];
          map3.forEach((key, value) {
            map3[key] = false;

          });
          map3[widget.result_map['duration']['Duration']]=true;

        }
        if(widget.result_map['add_info'] != null)
        {
          all_data_english_list = widget.result_map['add_info'];


        }


      }





  }
  @override
  Widget build(BuildContext context) {

    print(widget.result_map);

    String tab="" , composition ="" , company_name = "";

    List a = map[name]['tab'];
    tab=a==null?"":a[0].toString();

    List b = map[name]['composition'];
    if(b != null) {
      b.forEach((element) {
        composition = element.toString() + ' , ';
      });
    }

    print(map[name]['company_name']);




    List c = map[name]['company_name'];
    company_name=c==null?"":c[0].toString();





    return GestureDetector(
      onTap: (){

        pop();



      },
      child: WillPopScope(
        onWillPop: (){
         pop();


          return;
        },
        child: Container(
          color: Colors.transparent,
          height: double.infinity,

          child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 2.w),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.white,
                      child: ListTile(
                        tileColor: AppTheme.notWhite,
                        leading: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5), color: widget.color),
                          child: Center(child: Text(tab.toUpperCase())),
                        ),
                        title: Text(
                          name,
                          textScaleFactor: AppTheme.list_tile_subtile,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(composition , textScaleFactor: AppTheme.list_tile_subtile,),
                            Text(
                              company_name, textScaleFactor: AppTheme.list_tile_subtile,
                            ),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    ),
                    SizedBox(

                      height: 2.h,
                    ),

                    Container(
                      color: Colors.white,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: map2.keys.map<Widget>((e) =>GestureDetector(
                            onTap: (){

                              setState(() {

                                




                                map2[e] = !map2[e];




                              });




                            },
                            child: CircleAvatar(
                              backgroundColor: map2[e]?AppTheme.teal:Colors.grey,
                              child: Text(e[0] , style: TextStyle(color: Colors.white), textScaleFactor: AppTheme.list_tile_subtile,),
                            ),
                          ), ).toList()
                      ),
                    ),
                    SizedBox(

                      height: 2.h,
                    ),

                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [

                          Flexible(
                            flex: 2,
                            child: SizedBox(


                              child: Material(
                                child: TextField(
                                  controller: duration_edit,
                                  style: TextStyle(
                                      fontSize: 3.w
                                  ),

                                  decoration: InputDecoration(


                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 2,),
                                        borderRadius: BorderRadius.circular(10),),

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.teal,
                                          width: 2,),
                                        borderRadius: BorderRadius.circular(10),),

                                      labelText: 'Duration',

                                      prefixIcon: Icon(Icons.access_time),
                                      suffix: Text(map3['Days']?'Days' :

                                      map3['Weeks']?'Weeks' :
                                      'Months'
                                      )


                                  ),


                                  keyboardType: TextInputType.number ,






                                ),
                              ),
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            child: GestureDetector(onTap: (){

                              setState(() {
                                map3.forEach((key, value) {
                                  map3[key] = false;

                                });

                                map3['Days'] = true;

                              });
                            }, child: Material(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: map3['Days']?Colors.grey:Colors.transparent

                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all( 1.0),
                                    child: Text('Days' , style: TextStyle(

                                        color: map3['Days']?Colors.white:Colors.grey
                                    ),
                                      textScaleFactor: AppTheme.list_tile_subtile,



                                    ),
                                  )),
                            )),
                          ),

                          Flexible(
                            flex: 1,
                            child: GestureDetector(onTap: (){

                              setState(() {
                                map3.forEach((key, value) {
                                  map3[key] = false;

                                });

                                map3['Weeks'] = true;

                              });

                            }, child: Material(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: map3['Weeks']?Colors.grey:Colors.transparent

                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text('Weeks' , style: TextStyle(

                                        color: map3['Weeks']?Colors.white:Colors.grey
                                    ),
                                      textScaleFactor: AppTheme.list_tile_subtile,
                                    ),
                                  )),
                            )),
                          ),

                          Flexible(
                            flex: 1,
                            child: GestureDetector(onTap: (){

                              setState(() {
                                map3.forEach((key, value) {
                                  map3[key] = false;

                                });

                                map3['Months'] = true;

                              });
                            }, child: Material(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      color: map3['Months']?Colors.grey:Colors.transparent

                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Text('Months' , style: TextStyle(

                                        color: map3['Months']?Colors.white:Colors.grey
                                    ),

                                      textScaleFactor: AppTheme.list_tile_subtile,


                                    ),
                                  )),
                            )),
                          )



                        ],
                      ),
                    ),

                    SizedBox(

                      height: 2.h,
                    ),


                    Material(
                        color: Colors.white,
                        child: Padding(
                      padding:  EdgeInsets.only(left: 3.w),
                      child: Text('Additional Info : ' ,),
                    )),

                    SizedBox(

                      height: 2.h,
                    ),





                    Material(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        color: Colors.white,
                        child: Visibility(
                            visible: all_data_english_list!=null?true:false,
                            child: Wrap(
                              spacing: 2.w,runSpacing: 2.h,
                              children: all_data_english_list.map<Widget>((e) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(e , ),
                                  Text(' ,'),
                                ],
                              )).toList(),
                            )),
                      ),
                    ),

                    SizedBox(

                      height: 2.h,
                    ),

                    Material(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        color: Colors.white,

                        child: IconButton(onPressed: (){

                          showDialog(context: context, builder: (context)=>Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 7.w , vertical: 8.h),
                            child: Add_Info_List_Search(result: all_data_english_list,),
                          )).then((value) {

                            if(value != null)
                            {
                              setState(() {
                                print('rr');


                                print(value);
                                all_data_english_list=[];



                                all_data_english_list = value;
                              });


                            }







                          });

                        }, icon: Icon(Icons.add)),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
