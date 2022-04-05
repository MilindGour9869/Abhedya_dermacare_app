import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/classes/service_dialogue.dart';

import '../default.dart';


class Service_Search_List extends StatefulWidget {
  @override
  _Service_Search_ListState createState() => _Service_Search_ListState();
}

class _Service_Search_ListState extends State<Service_Search_List> {

  Map<String , Map<String , dynamic>> service_list={};

  var _textController_group = TextEditingController();

  List all_service_list=[];
  List search_service_list=[];




  Future getServiceData()async{

    await FirebaseFirestore.instance.collection('Services').get().then((QuerySnapshot querySnapshot) {

      querySnapshot.docs.forEach((element) {

        service_list[element['service']] = {
          'service_id' : element['id'],
          'doc_id' : element['doc_id'],
          'charge' : element['charge'].toString(),
          'service' : element['service'],
          'color':  false,

        };

      });



      all_service_list = service_list.keys.toList();


      setState(() {
        search_service_list=all_service_list;

      });

    });

  }




  onItemChanged(String value) {
    setState(() {
      search_service_list= all_service_list
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if(search_service_list.isEmpty)
      {
        search_service_list=[];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServiceData();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios , color: Colors.black,), onPressed: (){
            Navigator.pop(context );
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
              child: CircleAvatar(child: Text(all_service_list.length==null?"":all_service_list.length.toString()),),
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


                  children: search_service_list.map<Widget>((e){

                    Map<String,dynamic> m=service_list[e];
                    String service_name , doc_id  ;
                    bool color;

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
                       });


                        print(m['color']);



                      },
                     tileColor: m['color']==true?AppTheme.green:AppTheme.white,


                      trailing: IconButton(
                        icon: Icon(Icons.edit_outlined , color: AppTheme.teal,),
                        onPressed: ()async{



                          showDialog(context: context, builder: (context)=>ServiceDialogue.Dialogue(
                            service: service,
                            charges: charge,
                            service_name:service_name,
                            doc_id:doc_id,
                            context: context,

                          ));













                        },
                      ),





                    );

                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
