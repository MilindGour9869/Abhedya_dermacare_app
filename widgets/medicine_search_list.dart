import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../default.dart';

class Medicine_Search_List extends StatefulWidget {
  @override
  _Medicine_Search_ListState createState() => _Medicine_Search_ListState();
}

class _Medicine_Search_ListState extends State<Medicine_Search_List> {


  Map<String , Map<String , dynamic>> service_list={};

  var _textController_group = TextEditingController();

  List all_group_list=[];
  List search_group_list=[];

  List group_updated_result=[];
  List group_result=[];

  onItemChanged(String value) {
    setState(() {
      search_group_list= all_group_list
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if(search_group_list.isEmpty)
      {
        search_group_list=[];
      }
    });
  }

  Future getServiceData()async{

    await FirebaseFirestore.instance.collection('Medicine').get().then((QuerySnapshot querySnapshot) {

      querySnapshot.docs.forEach((element) {

        service_list[element['service']] = {
          'service_id' : element['id'],
          'doc_id' : element['doc_id'],
          'charge' : element['charge'].toString(),
          'service' : element['service'],
          'color':  false,

        };

      });







      all_group_list = service_list.keys.toList();

      if(group_updated_result.isNotEmpty){
        group_updated_result.forEach((element) {

          all_group_list.remove(element);
          all_group_list.add(element);



        });
      }


      setState(() {
        search_group_list=all_group_list.reversed.toList();

      });

    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios , color: Colors.black,), onPressed: (){
          Navigator.pop(context , group_updated_result );
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
            child: CircleAvatar(child: Text(all_group_list.length==null?"":all_group_list.length.toString()),),
          )
        ],
      ),
      body: Container(

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 2,

            borderRadius: BorderRadius.circular(10),
            child: SingleChildScrollView(
              child: Column(


                children: search_group_list.map<Widget>((e){

                  Map<String,dynamic> m=service_list[e];
                  String service_name , doc_id  ;


                  var charge = TextEditingController();
                  var service = TextEditingController();

                  service.text = m['service'];
                  doc_id = m['doc_id'];
                  charge.text = m['charge'];
                  service_name= m['service_id'];













                  return  ListTile(
                    title: Text(e.toString()),
                    leading: CircleAvatar(child: Icon(Icons.arrow_forward_ios , size: MediaQuery.of(context).size.height*0.03, color: AppTheme.white,)),
                    onTap: (){



                      setState(() {
                        m['color'] = ! m['color'];
                        if(m['color'] == true)
                        {
                          group_updated_result.add(e);
                          print(group_updated_result);




                        }
                        else if(m['color'] == false)
                        {
                          group_updated_result.remove(e);
                        }

                      });


                      print(m['color']);



                    },
                    tileColor: m['color']==true?AppTheme.green:AppTheme.white,







                  );

                }).toList(),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
