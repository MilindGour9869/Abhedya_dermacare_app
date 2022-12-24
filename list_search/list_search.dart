import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/default.dart';

import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class List_Search extends StatefulWidget {

  List? result;

  Function get;
  Function set;
  Function? delete;

  String ky ;


  String group , Group ;
  bool one_select ;





  List_Search({  this.result , required this.get , required this.set , this.delete ,  required this.group ,  required this.Group  ,  required  this.one_select , required this.ky});

  @override
  _List_SearchState createState() => _List_SearchState();
}

class _List_SearchState extends State<List_Search> {

  //state var
  late List<String>  group_all_data_list ; //{'name1', 'name2'....}
  late List<String>  group_search_data_list ; //{'name1', 'name2'....}
  late Map<String, bool> select ;

  //info var
  Set<String>? group_updated_result= {} ;
  Map<String , Map<String , dynamic >>? all_data_map ={}; //{ doc_id1 :{'name':'xxx' , '} , doc_id2:{'name':} , }


  late Future f;

  var search_edit = TextEditingController();



  Future<void> get() async {


    group_updated_result={};
    group_search_data_list=[];
    group_all_data_list=[];
    all_data_map={};


    final a = await widget.get(key:widget.ky);

    if(a!=null)
      {
        all_data_map = a;

        setState(() {

          all_data_map!.forEach((key, value) {
            group_all_data_list.add(value[widget.group].toString());
          });
          group_search_data_list=group_all_data_list;

          group_all_data_list.forEach((element) {
            select[element] = false;
          });

        });

        if(widget.result !=null && widget.result!.isNotEmpty)
        {


            widget.result!.forEach((element) {

              group_all_data_list.forEach((e) {

                if(e==element)
                {
                  select[e] = true;
                  group_updated_result!.add(e);
                }
              });
            });



          //Bug Appeared & Removed !!
            group_updated_result!.forEach((e) {
            group_search_data_list.remove(e);

          });
          group_updated_result!.forEach((e) {
            group_search_data_list.add(e);

          });
          group_search_data_list=group_search_data_list.reversed.toList();

          //State update
          setState(() {
            group_search_data_list=group_search_data_list;
            select=select;

          });

        }
      }




  }

  void set() async {

   await widget.set(value: all_data_map , key : widget.ky );
  }

  void pop(){
   if(group_updated_result!=null)
     {
       Navigator.pop(context, group_updated_result!.toList());
     }
   else{
     Navigator.pop(context);

   }
  }

  void onChange(String s){

    group_all_data_list.add(s);
    select[s] = false;

  }

  onItemChanged(String value) {
    setState(() {
      group_search_data_list = group_all_data_list
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
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

    group_updated_result={};
    group_search_data_list=[];
    group_all_data_list=[];
    all_data_map={};


  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

        pop();
        return true;



      },
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 6.w ,vertical: 4.w ),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
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


                                if(widget.one_select)
                                  {
                                    select[e] = !select[e]!;

                                    select.forEach((key, value) {
                                      if(key!=e)
                                        {
                                          select[key]=false;
                                        }
                                    });

                                    group_updated_result={};

                                    if (select[e] == true) {
                                      group_updated_result!.add(e);

                                    }
                                    if (select[e] == false) {
                                      group_updated_result = {};

                                    }

                                    setState(() {
                                      select[e]= select[e]!;
                                    });
                                  }
                                else
                                  {
                                    select[e] = !select[e]!;

                                    if (select[e] == true) {
                                      group_updated_result!.add(e);
                                    }
                                    if (select[e] == false) {
                                      group_updated_result!.remove(e);

                                    }

                                    setState(() {

                                      select[e]= select[e]!;


                                    });

                                  }







                              },
                              title: SelectableText(
                                e,
                                textScaleFactor: AppTheme.list_tile_subtile,
                              ),

                              leading: CircleAvatar(
                                backgroundColor:
                                select[e]! ? AppTheme.teal : AppTheme.light_black,
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


                                        all_data_map!.forEach((key, value) {

                                          if(value[widget.group] == e)
                                          {
                                            s=key;

                                          }
                                        });

                                        if(s!=null)
                                          {
                                            all_data_map!.remove(s);
                                          }



                                        group_all_data_list.remove(e);
                                        group_search_data_list.remove(e);
                                        group_updated_result!.remove(e);



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

                          var doc =  FirebaseFirestore.instance.collection(widget.Group).doc(); //no net needed !! 🤯

                          setState(() {

                            Map<String , dynamic> map={};

                            map['doc_id'] = doc.id;
                            map[widget.group] = search_edit.text;

                            all_data_map![doc.id]=map;
                            onChange(search_edit.text);

                            group_search_data_list
                                .add(search_edit.text);

                          });

                          search_edit.clear();
                          onItemChanged('');

                          },
                        icon: Icon(Icons.add , color: AppTheme.teal,),
                        label: Text(search_edit.text ,style: TextStyle(
                          color: AppTheme.teal
                        ), )),
                  );


                }
                else{
                  ('in future builder , else');

                  return Center(child:CircularProgressIndicator(
                    color: AppTheme.teal,
                  ) );
                }

              },
            ),
          ),
        ),
      ),
    );
  }
}

