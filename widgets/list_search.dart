import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/default.dart';

class ListSearch extends StatefulWidget {

  String Group , group , name;


  ListSearch({@required this.group , @required this.Group , @required this.name});


  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {




  TextEditingController _textController_group = TextEditingController();
  var text = TextEditingController();

  List group_mapData_list = [];
  List group_all_data_list =[] ;
  List group_search_data_list=[];

  int group_size=0;

  Map<String,bool> group_search_color_map={};

  List group_result=[];

  Future f;










  Future GroupDataAdd(@required String group) async{

    final doc = await FirebaseFirestore.instance.collection(widget.Group).doc(group_size.toString());



    final json = {
      widget.group : group,
      'id': group_size,

    };

    await doc.set(json);

  }

  Future GroupDataUpdate(@required String group , @required int id) async{

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

    final doc =await FirebaseFirestore.instance.collection('Patients').doc(widget.name);



    doc.update({

      widget.group : [],

    });

    doc.update({
      widget.group : FieldValue.arrayUnion(group)
    });

  }

  Future<dynamic> group_data() async{

    print(group_result);



      await FirebaseFirestore.instance
          .collection(widget.Group)
          .get()
          .then((QuerySnapshot querySnapshot) async {

            setState(() {
              group_size=querySnapshot.size;

            });

            await querySnapshot.docs.forEach((doc) {
             group_mapData_list.add(doc.data());

           });

            group_all_data_list = group_mapData_list.map((d) {
             return d[widget.group];
           }).toList();


           try{
            group_all_data_list.forEach((element) {




              group_search_color_map[element.toString()]=false;

            });
          }
          catch(e){
            print(e);

          }



            try{
             await FirebaseFirestore.instance.collection('Patients').doc(widget.name).get().then((value) {


                if(value.data()!=null)
                  {
                    if(value.data().containsKey(widget.group))
                      {
                        if(value.data()[widget.group]!=[])
                          {
                            List a = value.data()[widget.group];
                            a.forEach((element) {
                              group_search_color_map[element]=true;
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
              print(e);
            }


            if(group_result.isNotEmpty){
              group_result.forEach((element) {
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

     group_search_data_list=[];
     group_all_data_list=[];
     group_mapData_list=[];
     group_size=0;


     await  Add_GroupDataList_to_Patient(group_result);

    group_result=[];
    group_search_color_map={};










  }



  @override
  Widget build(BuildContext context) {





    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Icon(Icons.search , color: Colors.black,),
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
                                        group_result.add(data.toString());

                                      }
                                    else if(group_search_color_map[data.toString()]==false)
                                    {
                                      group_result.remove(data.toString());

                                    }


                                  });





                                },

                                leading: CircleAvatar(
                                  child: Text(data==""?"":data[0].toString().toUpperCase()),

                                ),

                                title: Text(data, overflow: TextOverflow.ellipsis,) ,

                                trailing: Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width*0.27,
                                  child: Row(
                                    children: [
                                      IconButton(onPressed: (){

                                        int i;


                                     group_mapData_list.forEach((element) {
                                       if(element[widget.group]==data.toString())
                                         {
                                           i=element['id'];

                                         }



                                     });


                                     GroupDataDelete(i.toString());
                                    setState(() {

                                      group_search_data_list.remove(data.toString());
                                      group_all_data_list.remove(data.toString());
                                      --group_size;
                                      group_result.remove(data.toString());




                                    });






                                      }, icon: Icon(Icons.delete_outline)),
                                      IconButton(onPressed: (){


                                        int i;
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

                                                    int i;


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

                                                   GroupDataUpdate(text.text, i);
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
                      print(group_search_data_list);

                      group_search_color_map[_textController_group.text]=false;
                      print(group_search_color_map);



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

