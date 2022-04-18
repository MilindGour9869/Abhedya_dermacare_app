import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';
import 'package:flutter_app/storage/storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import '../default.dart';


class Service_Search_List extends StatefulWidget {


  List result ;



  Service_Search_List({this.result });

  @override
  _Service_Search_ListState createState() => _Service_Search_ListState();
}

class _Service_Search_ListState extends State<Service_Search_List> {

  Map<String , Map<String , dynamic>> service_list={};


  Map<String , Map<String , dynamic >> all_data_map={};

  bool updated = false;

  var _textController_group = TextEditingController();

  List all_service_list=[];
  List search_service_list=[];

  List group_updated_result=[];
  List group_result=[];







  Future getServiceData()async{


       var a = await Storage.get_services();

       all_data_map = a==null?{}:a;

       print(all_data_map);


       all_data_map.forEach((key, element) {
         service_list[element['service']] = {
           'service_id' : element['id'],
           'doc_id' : element['doc_id'],
           'charge' : element['charge'].toString(),
           'service' : element['service'],
           'color':  false,

         };
       });

       if(widget.result != null)
         {
           if(widget.result.isNotEmpty)
             {
               widget.result.forEach((element) {

                 if(service_list.containsKey(element))
                   {
                     service_list[element]['color'] = true;
                     group_updated_result.add(element);

                   }
               });
             }
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
      padding:  EdgeInsets.all(4.h),
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios , color: Colors.black, size: AppTheme.icon_size,), onPressed: (){

            print(group_updated_result);

            Navigator.pop(context , group_updated_result );
          },),
          title: Padding(
            padding:  EdgeInsets.all(0),
            child: TextField(
              controller: _textController_group,
              style: AppTheme.black_22,
              decoration: InputDecoration(
                hintText: 'Search / Add ',
                hintStyle: AppTheme.main_grey_25


              ),
              onChanged: onItemChanged,
            ),
          ),
          actions: [
            Padding(
              padding:  EdgeInsets.only(right: 1.w),
              child: CircleAvatar(child: Text(all_service_list.length==null?"":all_service_list.length.toString()),),
            )
          ],
        ),


        body: Container(

          child: Padding(
            padding:  EdgeInsets.all(2.w),
            child: Material(
              elevation: 2,

              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                child: Column(


                  children: search_service_list.map<Widget>((e){

                    print('sdsdv');
                    print(service_list);





                    Map<String,dynamic> m = service_list[e];

                    print(m);

                    String service_name , doc_id  ;
                    bool color;

                    var charge = TextEditingController();
                    var service = TextEditingController();

                    service.text = m['service'].toString();
                    doc_id = m['doc_id'].toString();
                    charge.text = m['charge'].toString();
                    service_name= m['service_id'].toString();













                    return  ListTile(
                      title: Text(e.toString() , style: AppTheme.black_22,),
                      leading: CircleAvatar(

                          backgroundColor: m['color']?AppTheme.teal:AppTheme.light_black,


                          child: Icon(Icons.arrow_forward_ios_rounded, size: AppTheme.icon_size, color: AppTheme.white,)),

                      tileColor: AppTheme.white,
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



                      trailing: Text('₹ ${m['charge']}' , style: AppTheme.black_22,),





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



