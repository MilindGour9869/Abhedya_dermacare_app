
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/default.dart';

import 'package:flutter_app/classes/Patient_name_list.dart';

import 'package:flutter_app/storage/storage.dart';

class Try extends StatefulWidget {

  List<String> result;
  Try({this.result});

  @override
  _TryState createState() => _TryState();
}

class _TryState extends State<Try> {


  List<String> group_all_data_list =[] ;
  List<String> group_updated_result = [];
  Map<String , Map<String , dynamic >> all_data_english_list={};

  List group_search_data_list = [];

  Map<String, bool> select = {};



  Future f;


  var search_edit = TextEditingController();
  var text_edit = TextEditingController();


   Future<void> get() async {


      group_updated_result=[];
      group_search_data_list=[];
      group_all_data_list=[];
      all_data_english_list={};



   var a = await Storage.get_tab();

   print(a);

   all_data_english_list = a==null?{}:a;

    print(all_data_english_list);


    setState(() {

      all_data_english_list = all_data_english_list;


     all_data_english_list.forEach((key, value) {
       group_all_data_list.add(value['tab'].toString());
     });
      group_search_data_list=group_all_data_list;

      group_all_data_list.forEach((element) {
        select[element] = false;
      });

    });

    if(widget.result != null)
    {



      setState(() {
        widget.result.forEach((element) {

          (all_data_english_list);

          group_all_data_list.forEach((e) {



            if(e==element)
            {
              (e);

              select[e] = true;
              group_updated_result.add(e);


            }
          });
        });

      });

    }




  }

  void set() async {

    print('aassd');


    print(all_data_english_list);










    await Storage.set_tab(tab_map: all_data_english_list );
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context, group_updated_result);
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
              child: Text(group_all_data_list!=null?group_all_data_list.length.toString() :'0'),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: f,
        builder: (context,snapshot){


          if(group_search_data_list.isNotEmpty)
          {
            return  SizedBox(

                width: double.infinity,
                child:  ListView(
                  shrinkWrap: true,
                  children: group_search_data_list
                      .map<Widget>((e) => GestureDetector(
                    onTap: (){
                      setState(() {
                        select[e] = !select[e];
                        if (select[e] == true) {
                          group_updated_result.add(e);
                        }
                        if (select[e] == false) {
                          group_updated_result.remove(e);
                        }
                      });
                    },
                    child: ListTile(
                      title: Text(e),
                      leading: CircleAvatar(
                        backgroundColor:
                        select[e] ? AppTheme.green : Colors.grey,
                        child: Icon(
                          Icons.done,
                          color: AppTheme.white,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){
                            text_edit.text =e;

                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                title:  TextField(
                                  autofocus: false,

                                  controller: text_edit,
                                  decoration: InputDecoration(
                                      labelText: 'Edit',
                                      focusColor: AppTheme.green,

                                      border: OutlineInputBorder(

                                      )
                                  ),
                                ),
                               content: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 children: [
                                   GestureDetector(
                                     onTap: (){
                                       Navigator.pop(context);
                                     },
                                     child: Text('Cancel'),

                                   ),
                                   GestureDetector(
                                     onTap: (){
                                       Navigator.pop(context , text_edit.text);
                                     },
                                     child: Text('Done')
                                   ),
                                 ],
                               ),

                              );
                            }).then((value) {
                              setState(() {
                               if(value !=null)
                                 {

                                  setState(() {
                                    String s;


                                    all_data_english_list.forEach((key, value) {
                                      if(value['tab'] ==e)
                                      {
                                        s=key;

                                      }
                                    });



                                    all_data_english_list[s]['tab'] = value;


                                    group_all_data_list.remove(e);
                                    onChange(value);

                                    group_search_data_list.remove(e);
                                    group_search_data_list.add(value);

                                    group_updated_result.remove(e);
                                    group_updated_result.add(value);


                                    print(all_data_english_list);

                                  });

                                 }
                              });
                            });

                          }, icon: Icon(Icons.edit_outlined)),
                          IconButton(
                            icon: Icon(Icons.delete_outline_outlined),
                            onPressed: (){
                              setState(() {

                                String s;


                                all_data_english_list.forEach((key, value) {
                                  if(value['tab'] ==e)
                                    {
                                      s=key;

                                    }
                                });

                                all_data_english_list.remove(s);


                                group_all_data_list.remove(e);
                                group_search_data_list.remove(e);
                                group_updated_result.remove(e);

                                print(all_data_english_list);


                              });

                            },
                          ),
                        ],
                      ),
                    ),
                  ))
                      .toList(),
                ));

          }
          if(search_edit.text.isNotEmpty )
          {
            return Center(
              child: TextButton.icon(
                  onPressed: ()async {

                    var doc = await FirebaseFirestore.instance.collection('Tab').doc();


                        setState(() {

                          Map<String , dynamic> map={};

                          map['doc_id'] = doc.id;
                          map['tab'] = search_edit.text;


                          all_data_english_list[doc.id]=map;



                          onChange(search_edit.text);

                          ('ggg');


                          group_search_data_list
                              .add(search_edit.text);



                        });

                        search_edit.clear();
                        onItemChanged('');





                  },
                  icon: Icon(Icons.add),
                  label: Text(search_edit.text)),
            );


          }
          else{
            ('in future builder , else');

            return Center(child:CircularProgressIndicator() );
          }

        },
      ),
    );
  }
}

