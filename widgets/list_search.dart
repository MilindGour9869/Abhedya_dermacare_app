import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/classes/Group_data_list.dart';

class ListSearch extends StatefulWidget {
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {




  TextEditingController _textController_group = TextEditingController();
  var edit = TextEditingController();

  Widget Tile(Group_data_list data){




    return ListTile(
      leading: ChoiceChip(

        label: Icon(Icons.adjust),
        selectedColor: Colors.teal,
        selected: false,
        onSelected: (bool a){
          setState(() {




          });
        },


      ),
      title: Text(data.group),
      trailing: IconButton(
        icon: Icon(Icons.edit_outlined),
        onPressed: (){
          showDialog(context: context, builder: (context)=>Padding(
            padding: const EdgeInsets.symmetric(vertical: 220.0 , horizontal: 50),
            child: TextField(
              controller: edit,
              autofocus: true,
              onEditingComplete: (){
                setState(() {
                  this.fileContent.remove(data);
                  groupDataList.remove(data);
                  this.newDataList.remove(data);
                  this.newDataList.add(edit.text);

                  groupDataList.add(edit.text);
                  //writeToFile(_editing_controller.text);

                  Navigator.pop(context);

                });

              },









            ),
          ));
        },
      ),
    );
  }


  File jsonFile;
  Directory dir;
  var fileName = "group.json";
  bool fileExists = false;
  List fileContent;

  static List groupDataList = [];

  static List grouplist=[];



  Future GroupData(@required String group) async{

    final doc = await FirebaseFirestore.instance.collection("Group").doc();

    final json = {
      'group' : group,
    };

    await doc.set(json);

  }


  Stream<List<Group_data_list>> group_data() =>  FirebaseFirestore.instance.collection('Group').snapshots().map(

          (snapshot) {
            print('dfb');



              groupDataList = snapshot.docs.map((doc) => Group_data_list.fromJson(doc.data()) ).toList();
           // grouplist=groupDataList.map( (d)=> d.group);




            print(groupDataList);
            print(grouplist);







            return groupDataList;

          } );





  // Copy Main List into New List.
  List newDataList = List.from(grouplist);

  onItemChanged(String value) {
    setState(() {
      newDataList = groupDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if(newDataList.isEmpty)
      {
        newDataList=[];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    group_data();

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController_group,
              decoration: InputDecoration(
                  hintText: 'Search / Add ',
                  prefixIcon: Icon(Icons.search)
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12.0),
              children: newDataList.isNotEmpty==true?newDataList.map((data) {


                return SizedBox(
                  height: 500,
                  child: StreamBuilder(
                    stream: group_data(),
                    builder: (context,snapshot){



                      if(snapshot.hasData)
                      {
                        return ListView(
                          children: snapshot.data.map<Widget>(Tile).toList(),
                        );
                      }

                      if(snapshot.data==null)
                      {
                        return Center(child: CircularProgressIndicator());

                      }
                    },
                  ),
                );
              }).toList()

                  : [


                TextButton.icon(onPressed: (){

                  setState(() {
                    group_data();

                    var data = _textController_group.text;

                    this.newDataList.add(data);

                    grouplist.add(data);

                    GroupData(_textController_group.text);






                    _textController_group.clear();

                    // writeToFile(data);




                  });




                }, icon: Icon(Icons.add), label: Text(_textController_group.text))
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Search bar in app bar flutter
class SearchAppBar extends StatefulWidget {
  @override
  _SearchAppBarState createState() => new _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  Widget appBarTitle = new Text("AppBar Title");
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          centerTitle: true,
          title:appBarTitle,
          actions: <Widget>[
            new IconButton(icon: actionIcon,onPressed:(){
              setState(() {
                if ( this.actionIcon.icon == Icons.search){
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.white,

                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search,color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)
                    ),
                  );}
                else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("AppBar Title");
                }


              });
            } ,),]
      ),
    );
  }
}
