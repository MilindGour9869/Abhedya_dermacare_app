
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/default.dart';

import 'package:flutter_app/classes/Patient_name_list.dart';

class ListSearch extends StatefulWidget {

  String Group , group , patient_doc_id;

  String date;






  ListSearch({@required this.group , @required this.Group ,  this.patient_doc_id , this.date , });


  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {




  TextEditingController _textController_group = TextEditingController();
  var text = TextEditingController();

  List group_mapData_list = [];
  List group_all_data_list =[] ;
  List group_search_data_list=[];

  Map<String , Map<String , dynamic>> all_map_list={};

  int group_size=0;


  Map<String,bool> group_search_color_map={};
  Map<String,String> all_data_doc_id ={};


  List<String> group_updated_result=[];
  List group_result=[];



  Future f;










  Future GroupDataAdd(@required String group) async{

    final doc = await FirebaseFirestore.instance.collection(widget.Group).doc();



    final json = {
      widget.group : group,
      'id': doc.id ,    //group_size

    };

    await doc.set(json);

  }

  Future GroupDataUpdate(@required String group , @required String id) async{

    final doc = await FirebaseFirestore.instance.collection(widget.Group).doc(id.toString());



    
    doc.update({
      widget.group:group,

    });


    

  }

  Future GroupDataDelete (@required String group)async{
    final doc = await FirebaseFirestore.instance.collection(widget.Group).doc(group);

    doc.delete();


  }

  Future Add_GroupDataList_to_Patient(List group)async{

 if(widget.date != null && group != [])
   {
     final doc =await FirebaseFirestore.instance.collection('Patient').doc(widget.patient_doc_id).collection('visits').doc(widget.date);

// print(group_result==group);



     if(group!=group_result)
     {
       // if removed from the list
       doc.set({

         widget.group : [],

       } , SetOptions(merge: true) );


       // to add
       doc.set({
         widget.group : FieldValue.arrayUnion(group)
       } , SetOptions(merge: true));
     }

   }

// print(group.isEmpty);


  }

  Future<dynamic> group_data() async{

//    print(group_updated_result);
//    print(widget.date);




      await FirebaseFirestore.instance
          .collection(widget.Group)
          .get()
          .then((QuerySnapshot querySnapshot) async {

            setState(() {
              group_size=querySnapshot.size;

            });

            await querySnapshot.docs.forEach((doc) {

             group_mapData_list.add(doc.data());
             all_map_list[doc.id]= doc.data();



           });

            print('\nfff');

            print(all_map_list);


            group_all_data_list = group_mapData_list.map((d) {
             return d[widget.group];
           }).toList();




            group_mapData_list.forEach((element) {

              print('bgf');

              print(element[widget.group]);

              all_data_doc_id[element[widget.group]] = element['id'].toString();







            });






            print('\n\naaa');


            print(all_data_doc_id);





           try{
            group_all_data_list.forEach((element) {




              group_search_color_map[element.toString()]=false;

            });
          }
          catch(e){
            print(e);

          }





            if(widget.patient_doc_id != null && widget.date != null )
              {
                try{
                  await FirebaseFirestore.instance.collection('Patient').doc(widget.patient_doc_id).collection('visits').doc(widget.date).get().then((value) {


                    if(value.data()!=null)
                    {
                      print(value);

                      if(value.data().containsKey(widget.group))
                      { print('qq');
                        if(value.data()[widget.group]!=[])
                        { print('ww');
                          List a = value.data()[widget.group];
                          print('Color change');
                          a.forEach((element) {
                            group_search_color_map[element]=true;
                            group_updated_result.add(element);
                            group_result.add(element);



                          });
                        }
                      }
                    }
                    else
                    {
                      print('Patient doc called , in else');

                    }
                  });
                }
                catch (e){
                  print('error in Color change');
                  print(e);
                }
              }
            else{
              print('widget.patient_doc_id is null');
            }


            if(group_updated_result.isNotEmpty){
              group_updated_result.forEach((element) {
                group_all_data_list.remove(element);
                group_all_data_list.add(element);

              });
            }

            group_search_data_list = group_all_data_list.reversed.toList();
          });


      var a;
      return a;
  }



  onItemChanged(String value) {
    setState(() {
      group_search_data_list = group_all_data_list
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if(group_search_data_list.isEmpty)
      {
        group_search_data_list=[];
      }
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    f = group_data();

  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();

   // print(widget.date);


     group_search_data_list=[];
     group_all_data_list=[];
     group_mapData_list=[];
     group_size=0;


//     if(widget.patient_doc_id != null)
//       {
//         await Add_GroupDataList_to_Patient(group_updated_result);
//
//       }






    group_updated_result=[];
    group_search_color_map={};










  }



  @override
  Widget build(BuildContext context) {





    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios , color: Colors.black,), onPressed: (){
            Navigator.pop(context , group_updated_result);
          },),
          title: Padding(
            padding: const EdgeInsets.all(0),
            child: TextField(
              controller: _textController_group,
              decoration: InputDecoration(
                  hintText: 'Search / Add ',


              ),
              onChanged: onItemChanged,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: CircleAvatar(child: Text(group_size==null?"":group_size.toString()),),
            )
          ],
        ),
        body: FutureBuilder(
          future: f,
          builder: (context,snapshot){


            if(group_search_data_list.isNotEmpty)
              {
                return Container(
                  height: MediaQuery.of(context).size.height*0.81,
                  color: Colors.transparent,
                  child: ListView(

                    children: group_search_data_list.isNotEmpty ?
                    group_search_data_list.map(

                        (data){

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: ListTile(
                                selectedColor: Colors.white,
                                selectedTileColor: Colors.blue,
                                selected: group_search_color_map[data]==null?false:group_search_color_map[data.toString()],
                                onTap: (){

                                  setState(() {

                                    group_search_color_map[data.toString()]=!group_search_color_map[data.toString()];

                                    if(group_search_color_map[data.toString()]==true)
                                      {
                                        group_updated_result.add(data.toString());

                                      }
                                    else if(group_search_color_map[data.toString()]==false)
                                    {
                                      group_updated_result.remove(data.toString());

                                    }


                                  });





                                },

                                leading: CircleAvatar(
                                  child: Text(data==""?"":data[0].toString().toUpperCase()),

                                ),

                                title: Container(

                                    child: Text(data, style: TextStyle(fontSize: 15),)) ,

                                trailing: Container(

                                  width: MediaQuery.of(context).size.width*0.25,
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: (){

                                        String i;


                                     group_mapData_list.forEach((element) {
                                       if(element[widget.group]==data.toString())
                                         {

                                           i  = all_data_doc_id[data.toString()];



                                         }



                                     });


                                     GroupDataDelete(i.toString());
                                    setState(() {

                                      group_search_data_list.remove(data.toString());
                                      group_all_data_list.remove(data.toString());
                                      --group_size;
                                      group_updated_result.remove(data.toString());




                                    });






                                      }, icon: Icon(Icons.delete_outline)),
                                      IconButton(onPressed: (){


                                        String i;
                                        group_mapData_list.forEach((element) {
                                          if(element[widget.group]==data.toString())
                                          {
                                            i=element['id'];

                                          }
                                        });


                                        showDialog(context: context, builder: (context){

                                          text.text=data.toString();

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 40.0 , vertical: 220),
                                            child: Container(
                                              child: Material(
                                                child: TextField(
                                                  controller: text,
                                                  autofocus: true,
                                                  onEditingComplete: (){

                                                    String i;


                                                    group_mapData_list.forEach((element) {
                                                      if(element[widget.group]==data.toString())
                                                      {
                                                        i=element['id'];

                                                      }

                                                    });


                                                    setState(() {
                                                   group_search_data_list.remove(data.toString());
                                                   group_search_data_list.add(text.text);

                                                   group_all_data_list.remove(data);
                                                   group_all_data_list.add(text.toString());

                                                   group_search_color_map.remove(data.toString());
                                                   group_search_color_map[text.text]=false;

                                                   GroupDataUpdate(text.text, all_data_doc_id[data.toString()]);
                                                               });



                                                    Navigator.pop(context);

                                                    },

                                                )
                                              ),
                                            ),
                                          );
                                        });

                                      }, icon: Icon(Icons.edit_outlined)),

                                    ],
                                  ),
                                ),

                                tileColor: AppTheme.notWhite ,
                                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              ),
                            ),
                          );


                        }
                    ).toList():Text('List is empty')),
                );

              }
            if(_textController_group.text.isNotEmpty )
              {
                return Center(
                  child: TextButton.icon(onPressed: (){

                    setState(() {

                      ++group_size;


                      GroupDataAdd(_textController_group.text);
                      group_all_data_list.add(_textController_group.text);
                      group_search_data_list.add(_textController_group.text);
                     // print(group_search_data_list);

                      group_search_color_map[_textController_group.text]=false;
                      // print(group_search_color_map);



                      _textController_group.clear();







                    });



                  }, icon: Icon(Icons.add), label: Text(_textController_group.text)),
                );

              }
            else{
              print('in future builder , else');

              return Center(child:CircularProgressIndicator() );
            }

          },
        ),
      ),
    );

  }



}

