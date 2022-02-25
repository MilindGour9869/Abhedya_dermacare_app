import 'package:flutter/material.dart';

import 'package:flutter_app/default.dart';
import 'package:flutter_app/widgets/add_medicines.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:math' as math;


class Medicines extends StatefulWidget {
@override
_State createState() => _State();
}

class _State extends State<Medicines> {




  var textcontroller = TextEditingController();

  Future f;


  List all_medicine_map_list=[];
  List search_medicine_list=[];

  List medicine_name=[];
  List medicine_composition=[];

  Map<String , Map<String,String>> all_medicine_name_map_data={};
  Map<String , String > map={};







  Future getMedicineData()async{
    await FirebaseFirestore.instance.collection('Medicines').get().then((QuerySnapshot querySnapshot) {


      querySnapshot.docs.forEach((element) {

        all_medicine_map_list.add(element.data());



      });

      print(all_medicine_map_list);

      medicine_name= all_medicine_map_list.map((e) {

        map['composition']=e['composition'];
        map['company_name']=e['company_name'];
        map['medicine_name']=e['medicine_name'];
        map['tab']=e['tab'];





        all_medicine_name_map_data[e['medicine_name'].toString()]=map;

        map={};





        return e['medicine_name'];

      }).toList();

      print(medicine_name);

      print(all_medicine_name_map_data['aaa']['composition']);


      setState(() {
        search_medicine_list=medicine_name;
      });




    });
  }



  onItemChanged(String value) {
    setState(() {
      search_medicine_list= medicine_name
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if(search_medicine_list.isEmpty)
      {
        search_medicine_list=[];
      }
    });
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    f = getMedicineData();


  }



  Widget Tile({ Map<String , Map<String,String>> map , String name}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        child: ListTile(
          tileColor: AppTheme.green,
          

          leading: Container(
            height: 50,
            width: 50,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.primaries[math.Random().nextInt(Colors.primaries.length)]

            ),
            child: Center(child: Text(map[name]['tab'].toUpperCase())),
          ),


          title: Text(name , style: TextStyle(fontSize: 20),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${map[name]['composition']}'),
              Text('${map[name]['company_name']}' , style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),

            ],
          ),
          isThreeLine: true,
        ),
      ),
    );
  }


@override
Widget build(BuildContext context) {









return Scaffold(

  appBar: AppBar(
    title: Text('Medicines'),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(100),

      child:  Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(

            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 8.0),
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: textcontroller,
              onChanged: onItemChanged,
              decoration: InputDecoration(




                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,),
                    borderRadius: BorderRadius.circular(30),),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.teal,
                      width: 2,),
                    borderRadius: BorderRadius.circular(10),),

                  hintText:'Search',
                  prefixIcon: Icon(Icons.search)),


              keyboardType: TextInputType.name ,






            ),
          ),
        ),
      ),
    ),
  ),

  body: SingleChildScrollView(



    child:FutureBuilder(
        future: f,

        builder: (context,snapshot){

          print(snapshot.data);

          if(search_medicine_list.isEmpty)
          {return Center(child: Card(
              color: AppTheme.notWhite,

              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('loadin'),
              )));}







          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError) {
            return const Center(child: Text('Something Went Wrong'));
          }


          return Container(
            height: MediaQuery.of(context).size.height*0.727,
            child: ListView(
              children: search_medicine_list.map<Widget>((e)=>Tile(map: all_medicine_name_map_data , name: e.toString())).toList(),
            ),
          );
        }
    )


  ),

  floatingActionButton: FloatingActionButton(
    elevation: 15,

    splashColor: AppTheme.notWhite,
    onPressed: (){
      Navigator.push(context , MaterialPageRoute(builder: (context)=>AddMedicine()));
    },
    child: Icon(Icons.add , color: Colors.black,),
    backgroundColor: AppTheme.green,
  ),
  bottomNavigationBar: BottomAppBar(

    color: AppTheme.offwhite,
    child: Container(
      height:MediaQuery.of(context).size.height*0.08,


    ),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
);


}
}