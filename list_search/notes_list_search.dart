
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/default.dart';


import 'package:flutter_app/storage/storage.dart';
import 'package:flutter/services.dart';

class Notes_List_Search extends StatefulWidget {

  List result;
  Notes_List_Search({this.result});

  @override
  _Notes_List_SearchState createState() => _Notes_List_SearchState();
}

class _Notes_List_SearchState extends State<Notes_List_Search> {


  List group_all_data_list =[] ;
  List group_updated_result = [];
  Map<String , Map<String , dynamic >> all_data_map={};

  bool updated = false;


  List group_search_data_list = [];

  Map<String, bool> select = {};



  Future f;


  var search_edit = TextEditingController();



  Future<void> get() async {


    group_updated_result=[];
    group_search_data_list=[];
    group_all_data_list=[];
    all_data_map={};



    var a = await Storage.get_notes();

    print(a);

    all_data_map = a==null?{}:a;

    print(all_data_map);


    setState(() {

      all_data_map = all_data_map;


      all_data_map.forEach((key, value) {
        group_all_data_list.add(value['notes'].toString());
      });
      group_search_data_list=group_all_data_list;

      group_all_data_list.forEach((element) {
        select[element] = false;
      });

    });

    if(widget.result.isNotEmpty)
    {

      print('\n Widget.result ');
      print(widget.result);




      setState(() {
        widget.result.forEach((element) {

          print(group_updated_result);


          group_all_data_list.forEach((e) {

            if(e==element)
            {


              select[e] = true;
              group_updated_result.add(e);







            }
          });
        });

      });

      //Bug Appeared & Removed !!

      group_updated_result.forEach((e) {
        group_search_data_list.remove(e);

      });

      group_updated_result.forEach((e) {
        group_search_data_list.add(e);

      });

      group_search_data_list=group_search_data_list.reversed.toList();

      setState(() {

        group_search_data_list=group_search_data_list;
      });

    }




  }

  void set() async {

    print('aassd');




    print(all_data_map);










    await Storage.set_notes(value: all_data_map , updated:  updated );
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
                child: Text(group_all_data_list!=null?group_all_data_list.length.toString() :'0' , style: TextStyle(color: Colors.white),),
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
                        .map<Widget>((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 2,

                        child: ListTile(

                          onTap: (){

                            select[e] = !select[e];

                            if (select[e] == true) {
                              group_updated_result.add(e);




                            }
                            if (select[e] == false) {
                              group_updated_result.remove(e);

                            }

                            setState(() {

                              select[e]= select[e];


                            });


                          },
                          title: SelectableText(
                            e,
                          ),

                          leading: CircleAvatar(
                            backgroundColor:
                            select[e] ? AppTheme.teal : AppTheme.light_black,
                            child: Icon(
                              Icons.done,
                              color: AppTheme.white,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              IconButton(onPressed: (){

                                Clipboard.setData(ClipboardData(text: e)).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied to your clipboard !')));
                                });

                              }, icon: Icon(Icons.copy ,)),

                              IconButton(
                                icon: Icon(Icons.delete_outline_outlined),
                                onPressed: (){
                                  setState(() {

                                    String s;


                                    all_data_map.forEach((key, value) {
                                      if(value['notes'] ==e)
                                      {
                                        s=key;

                                      }
                                    });

                                    all_data_map.remove(s);

                                    updated=true;


                                    group_all_data_list.remove(e);
                                    group_search_data_list.remove(e);
                                    group_updated_result.remove(e);



                                  });

                                },
                              ),
                            ],
                          ),
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

                      var doc = await FirebaseFirestore.instance.collection('Notes').doc();


                      setState(() {

                        Map<String , dynamic> map={};

                        map['doc_id'] = doc.id;
                        map['notes'] = search_edit.text;

                        updated=true;



                        all_data_map[doc.id]=map;



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
      ),
    );
  }
}

