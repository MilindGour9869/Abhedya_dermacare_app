import 'package:flutter/material.dart';
import 'package:flutter_app/default.dart';

class Add_Info extends StatefulWidget {
  @override
  _Add_InfoState createState() => _Add_InfoState();
}

class _Add_InfoState extends State<Add_Info> {

  List group_updated_result=[];
  List all_data_english_list =[
    'Before Breakfast' , 'At Bed Time' ,
  ] ;
  List group_search_data_list =[];

  Map<String , bool> select={};






  var _textController_group = TextEditingController();



  onItemChanged(String value) {
    setState(() {
      group_search_data_list = all_data_english_list
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

    group_search_data_list =  all_data_english_list;
   all_data_english_list.forEach((element) {
     select[element] = false;

   });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
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
              child: CircleAvatar(child: Text('aa'),),
            )
          ],
        ),
        body: Expanded(
          child: Column(
            children: group_search_data_list.map<Widget>((e) => ListTile(

              title: Text(e),
              leading: CircleAvatar(
                backgroundColor: select[e]?AppTheme.green:Colors.grey,
                child: IconButton(
                  icon: Icon(Icons.done , color: AppTheme.white,),
                  onPressed: (){
                    setState(() {
                      select[e] = !select[e];
                      if(select[e]== true)
                        {
                          group_updated_result.add(e);
                        }
                      if(select[e]== false)
                      {
                        group_updated_result.remove(e);
                      }

                    });
                  },
                ),
              ),

            )).toList(),
          ),
        ),
      ),
    );
  }
}
