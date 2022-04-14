import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';


import '../default.dart';


class Service_Search_List extends StatefulWidget {

  Patient_name_data_list patient_data ;
  String date , group , Group;


  Service_Search_List({this.patient_data ,this.date , this.group , this.Group });

  @override
  _Service_Search_ListState createState() => _Service_Search_ListState();
}

class _Service_Search_ListState extends State<Service_Search_List> {

  Map<String , Map<String , dynamic>> service_list={};

  var _textController_group = TextEditingController();

  List all_service_list=[];
  List search_service_list=[];

  List group_updated_result=[];
  List group_result=[];


//  Future Add_GroupDataList_to_Patient(List group)async{
//
//    if(widget.date != null && group != [])
//    {
//      final doc =await FirebaseFirestore.instance.collection('Patient').doc(widget.patient_data.doc_id).collection('visits').doc(widget.date);
//
//// print(group_result==group);
//
//
//
//      if(group!=group_result)
//      {
//        // if removed from the list
//        doc.set({
//
//          widget.group : [],
//
//        } , SetOptions(merge: true) );
//
//
//        // to add
//        doc.set({
//          widget.group : FieldValue.arrayUnion(group)
//        } , SetOptions(merge: true));
//      }
//
//
//    }
//
//// print(group.isEmpty);
//
//
//  }




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

      if(widget.patient_data.doc_id != null && widget.date != null )
      {
        try{


          widget.patient_data.visits_mapData_list[widget.date].forEach((key, element) {

            print('Color');
            print(key);
            print(element);



            if(widget.group == key)
            {

              List a = element;

              a.forEach((element) {

                service_list.forEach((key, value) {
                  if(key == element)
                    {
                      value['color'] =true;




                    }
                });

                group_updated_result.add(element);
                group_result.add(element);
              });





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





      all_service_list = service_list.keys.toList();

      if(group_updated_result.isNotEmpty){
        group_updated_result.forEach((element) {

          all_service_list.remove(element);
          all_service_list.add(element);



        });
      }


      setState(() {
        search_service_list=all_service_list.reversed.toList();

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
                      leading: CircleAvatar(

                         backgroundColor: AppTheme.teal,

                          child: Icon(Icons.arrow_forward_ios_rounded, size: MediaQuery.of(context).size.height*0.03, color: AppTheme.white,)),

                     tileColor: m['color']?AppTheme.green:AppTheme.white,
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
                      },


                      trailing: Text('₹ ${m['charge']}' , style: TextStyle(fontSize: 20),),





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



