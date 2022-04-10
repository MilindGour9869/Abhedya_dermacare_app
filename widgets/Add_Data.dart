import 'package:flutter/material.dart';

import '../classes/add_info.dart';
import '../default.dart';

class AddData extends StatefulWidget {

  String medicine_name ;

  Map<String , Map<String , dynamic>> map;

  Color color;


  AddData({this.medicine_name  , this.color , this.map});

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  Map<String , Map<String , dynamic>> map;
  String name;
  Color color;



  List<String> all_data_english_list =[] ;

  Map<String , bool> map2={
    'Morning' : false,
    'Afternoon' : false,
    'Evening' : false,
    'Night' : false,

  };

  String value;


  DropdownMenuItem<String> Menu(String item)
  {
    return DropdownMenuItem(

      value: item,
      child: Text(item),

    );

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    map = widget.map;
    name = widget.medicine_name;
    color = widget.color;

  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0  , vertical: 200),
      child:GestureDetector(
        onTap: (){
          showDialog(context: context, builder: (context)=>Add_Info());
        },
        child: Card(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                tileColor: AppTheme.notWhite,
                leading: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: widget.color),
                  child: Center(child: Text(map[name]['tab'].toUpperCase())),
                ),
                title: Text(
                  name,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${map[name]['composition']}'),
                    Text(
                      '${map[name]['company_name']}',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                isThreeLine: true,
              ),
              SizedBox(height: 10,),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: map2.keys.map<Widget>((e) =>GestureDetector(
                    onTap: (){

                      setState(() {

                        map2.forEach((key, value) {
                          print(key);
                          map2[key] = false;

                        });




                        map2[e] = !map2[e];




                      });




                    },
                    child: CircleAvatar(
                      backgroundColor: map2[e]?AppTheme.teal:Colors.grey,
                      child: Text(e[0] , style: TextStyle(color: Colors.white),),
                    ),
                  ), ).toList()
              ),
              SizedBox(height: 10,),

              Visibility(
                  visible: all_data_english_list!=null?true:false,
                  child: Wrap(
                    spacing: 20,runSpacing: 10,
                children: all_data_english_list.map<Widget>((e) => Text(e , style: TextStyle(
                  fontSize: 20
                ),)).toList(),
              )),

              IconButton(onPressed: (){

                showDialog(context: context, builder: (context)=>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 40),
                    child: Add_Info(result: all_data_english_list,),
                  ),
                )).then((value) {

                setState(() {
                  all_data_english_list=[];

                  all_data_english_list = value;
                });





                });

              }, icon: Icon(Icons.add))


            ],
          ),



        ),
      ),
    );
  }
}
