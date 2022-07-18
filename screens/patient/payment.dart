import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/classes/Patient_name_list.dart';
import 'package:flutter_app/default.dart';
import '../services/service_search_list.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class Payment extends StatefulWidget {

  String visit_date;
  Patient_name_data_list patient_data;
  bool icon_tap;
  Map<String, dynamic> map;

  Payment({@required this.visit_date , @required this.patient_data , @required this.map , @required this.icon_tap});

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {


  String visit_date;
  Map<String , Map<String,dynamic>> service_result ={};

  List Services =[];

  int total_charge=0;






  Future f (){




  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    visit_date = formatDate(widget.visit_date.toDate(), [ dd, '-', mm, '-', yyyy]).toString();

    service_result = widget.patient_data.visits_mapData_list[visit_date]!=null?Map<String, Map<String, dynamic>>.from(widget.patient_data.visits_mapData_list[visit_date]['service']):{};
    if(service_result.isNotEmpty)
      {
        print(widget.patient_data.visits_mapData_list[visit_date]['service']);

        Services = service_result.keys.toList();
        service_result.forEach((key, value) {

          total_charge +=  value['charge'];


        });
      }






  }




  @override
  Widget build(BuildContext context) {
    int i=0;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Payment'),
          backgroundColor: AppTheme.teal,
          actions: [

            IconButton(onPressed: ()async{
              Map<String, dynamic> map = {};

              var visit_doc = await FirebaseFirestore.instance
                  .collection('Patient')
                  .doc(widget.patient_data.doc_id)
                  .collection('visits')
                  .doc(visit_date);


                  map['service'] = service_result;
                  map['total_charge'] = total_charge;

                 await   visit_doc.update(map);

                  Navigator.pop(context , 'save');











      }, icon: Icon(Icons.save)
            )]

        ),
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(

            children: [

          Padding(
            padding:  EdgeInsets.symmetric(vertical: 2.w),
            child: Card(
              elevation: 2,
              child: TextButton(
                child: Text(
                  '${visit_date}',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1947),
                      lastDate: DateTime(2050))
                      .then((value) {
                    print(value);
                    setState(() {


                      visit_date = formatDate(
                          Timestamp.fromDate(value).toDate(),
                          [dd, '-', mm, '-', yyyy]).toString();


                    });
                  });
                },
              ),
            ),
          ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 1.w),
                child: Card(
                  elevation: 4,
                  color: AppTheme.green,
                  child: TextButton(
                    child: Text(
                      'Total Charges : ₹ ${total_charge}',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1947),
                          lastDate: DateTime(2050))
                          .then((value) {
                        print(value);
                        setState(() {


                          visit_date = formatDate(
                              Timestamp.fromDate(value).toDate(),
                              [dd, '-', mm, '-', yyyy]).toString();


                        });
                      });
                    },
                  ),
                ),
              ),



              ListView(
                shrinkWrap: true,


                children: service_result.isNotEmpty?service_result.keys.map((e){
                  i++;
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: 2.w),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(5),

                      child: ListTile(

                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${i.toString()}.'),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(e),
                          ],
                        ),
                        trailing:  Text('₹ ${service_result[e]['charge'].toString()}' ),
                      ),
                    ),
                  );



                }).toList():[],
              ),




            ],
          ),
        ),
        floatingActionButton: FittedBox(
          child: FloatingActionButton.extended(

            elevation: 15,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),

            splashColor: AppTheme.notWhite,
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return Service_Search_List(
                      result: Services,
                    );
                  }).then((value) async {


                if (value != null) {
                  setState(() {

                    print('fff');

                    Services = value.keys.toList();
                    service_result = value;

                    total_charge = 0;


                    service_result.forEach((key, value) {


                      print(total_charge);







                      total_charge += value['charge'];



                    });





                  });
                }
              });





            },
           icon: Icon(Icons.add),
            label: Text('Add Charges'),
            backgroundColor: AppTheme.teal,
          ),
        ),

        bottomNavigationBar: BottomAppBar(

          color: AppTheme.white,
          child: Container(
            height:MediaQuery.of(context).size.height*0.08,


          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
