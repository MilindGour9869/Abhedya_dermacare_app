import 'package:flutter/material.dart';

import '../classes/add_info.dart';
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
    String time ;
    String duration;

    print(result_map['aa']);

    map2.forEach((key, v) {
      if(v)
      {
        time = key ;
      }
    });

    duration = duration_edit.text;

    Map<String , String> tenure={};

    map3.forEach((key, v) {
      if(v)
      {
        tenure[duration] = key ;
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


  DropdownMenuItem<String> Menu(String item)
  {
    return DropdownMenuItem(

      value: item,
      child: Text(item),

    );

  }



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
          duration_edit.text = widget.result_map['duration'];
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

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0  , vertical: 170),
            child:Card(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     ListTile(
                       tileColor: AppTheme.notWhite,
                       leading: Container(
                         height: MediaQuery.of(context).size.height * 0.08,
                         width: MediaQuery.of(context).size.width * 0.15,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(5), color: widget.color),
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
                                 print(key);
                                 map2[key] = false;

                               });




                               map2[e] = !map2[e];




                             });




                           },
                           child: CircleAvatar(
                             backgroundColor: map2[e]?AppTheme.teal:Colors.grey,
                             child: Text(e[0] , style: TextStyle(color: Colors.white),),
                           ),
                         ), ).toList()
                     ),
                     SizedBox(height: 20,),

                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                       children: [
                         SizedBox(
                           width: 140,

                           child: TextField(
                             controller: duration_edit,
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
                        GestureDetector(onTap: (){

                          setState(() {
                            map3.forEach((key, value) {
                              map3[key] = false;

                            });

                            map3['Days'] = true;

                          });
                        }, child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: map3['Days']?Colors.grey:Colors.transparent

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('Days' , style: TextStyle(
                                  fontSize: 20,
                                  color: map3['Days']?Colors.white:Colors.grey
                              ),),
                            ))),

                        GestureDetector(onTap: (){

                          setState(() {
                            map3.forEach((key, value) {
                              map3[key] = false;

                            });

                            map3['Weeks'] = true;

                          });

                        }, child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: map3['Weeks']?Colors.grey:Colors.transparent

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('Weeks' , style: TextStyle(
                                  fontSize: 20,
                                  color: map3['Weeks']?Colors.white:Colors.grey
                              ),),
                            ))),

                        GestureDetector(onTap: (){

                          setState(() {
                            map3.forEach((key, value) {
                              map3[key] = false;

                            });

                            map3['Months'] = true;

                          });
                        }, child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: map3['Months']?Colors.grey:Colors.transparent

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('Months' , style: TextStyle(
                                  fontSize: 20,
                                  color: map3['Months']?Colors.white:Colors.grey
                              ),),
                            )))



                       ],
                     ),

                     SizedBox(height: 10,),

                     Padding(
                       padding: const EdgeInsets.only(left: 20.0),
                       child: Text('Additional Info : ' , style: TextStyle(
                           fontSize: 20
                       ),),
                     ),

                     SizedBox(height: 5,),


                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20.0 ),
                       child: Visibility(
                           visible: all_data_english_list!=null?true:false,
                           child: Wrap(
                             spacing: 10,runSpacing: 5,
                             children: all_data_english_list.map<Widget>((e) => Row(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 Text(e , style: TextStyle(
                                     fontSize: 20
                                 ),),
                                 Text(' ,'),
                               ],
                             )).toList(),
                           )),
                     ),
                   ],
                 ),


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(onPressed: (){

                        showDialog(context: context, builder: (context)=>Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 40),
                            child: Add_Info(result: all_data_english_list,),
                          ),
                        )).then((value) {



                        setState(() {
                          print('rr');


                          print(value);
                          all_data_english_list=[];



                          all_data_english_list = value;
                        });





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
    );
  }
}
