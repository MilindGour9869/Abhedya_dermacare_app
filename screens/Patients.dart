import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/add_patient.dart';
import 'package:flutter_app/default.dart';

class Patient extends StatefulWidget {
@override
_State createState() => _State();
}

class _State extends State<Patient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton.icon(onPressed: (){
              print('fdf');
            }, icon: Icon(Icons.adjust, color: Colors.black,), label: Text('Today' , style: TextStyle(color: Colors.black),)),
            TextButton.icon(onPressed: (){
              print('fdf');
            }, icon: Icon(Icons.adjust , color: Colors.black,), label: Text('All' , style: TextStyle(color: Colors.black),)),



          ],
        ),
      ),

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
           color: Colors.white,
            child:SingleChildScrollView(

              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(


                      child: Patient_Tile( name:'Spidy', age: 21, mobile: 9828226511, date: '18/11/200',),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.notWhite,

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(


                      child: Patient_Tile( name:'Spidy', age: 21, mobile: 9828226511, date: '18/11/200',),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.notWhite,

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(


                      child: Patient_Tile( name:'Spidy', age: 21, mobile: 9828226511, date: '18/11/200',),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.notWhite,

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(


                      child: Patient_Tile( name:'Spidy', age: 21, mobile: 9828226511, date: '18/11/200',),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.notWhite,

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(


                      child: Patient_Tile( name:'Spidy', age: 21, mobile: 9828226511, date: '18/11/200',),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.notWhite,

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(


                      child: Patient_Tile( name:'Spidy', age: 21, mobile: 9828226511, date: '18/11/200',),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.notWhite,

                      ),
                    ),
                  ),




                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
                alignment: Alignment.bottomCenter,

                child: Material(
                  elevation: 5,
                  borderRadius:BorderRadius.circular(30) ,
                  child: TextButton.icon(onPressed: (){

                    print('add pateint');

                    Navigator.push(context , MaterialPageRoute(builder: (context)=>AddPatient()));


                  }, icon: Icon(Icons.add , color: Colors.red,), label: Text('Add Patient' , style: TextStyle(color: Colors.black),) ),
                )),
          )
        ],
      ),

      bottomNavigationBar: Container(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(onPressed: (){
              print('fdf');
            }, icon: Icon(Icons.home , color: Colors.white,), label: Text('Home' , style: TextStyle(color: Colors.white),)),
            TextButton.icon(onPressed: (){
              print('fdf');
            }, icon: Icon(Icons.home , color: Colors.white,), label: Text('Home' , style: TextStyle(color: Colors.white),)),
            TextButton.icon(onPressed: (){
              print('fdf');
            }, icon: Icon(Icons.home , color: Colors.white,), label: Text('Home' , style: TextStyle(color: Colors.white),)),



          ],
        ),
      ),


    );
}
}

class Patient_Tile extends StatelessWidget {
   Patient_Tile({
    Key key, this.name , this.age , this.mobile , this.date
  }) : super(key: key);

  String name , date  ;
  int mobile , age ;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(age.toString()),
              SizedBox(width: 10,),
              Text(mobile.toString())
            ],
          ),


          SizedBox(height: 10,),
          Text('last visited on : ${date}' , style: TextStyle(fontStyle: FontStyle.italic),),

          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){}, child: Text('Visits')),
              TextButton(onPressed: (){}, child: Text('Payment')),
              TextButton(onPressed: (){}, child: Text('Documents')),
            ],
          )

        ],
      ),

      leading: CircleAvatar(
        child: Text(name[0].toUpperCase()),

      ),




    );
  }
}