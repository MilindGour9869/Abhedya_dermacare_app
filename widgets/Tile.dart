import 'package:flutter/material.dart';
import 'package:flutter_app/list_search/list_search.dart';
import 'package:flutter_app/storage/storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../default.dart';

class AddVisiteTile extends StatefulWidget {


  String name  , group , Group , ky;
  List list ;
  bool one_select ;
  Widget widget;
  Function f;



  AddVisiteTile({
    @required this.name ,
    @required this.group ,
    @required this.Group ,
    @required this.one_select ,
    @required this.list ,
    @required this.ky ,
    @required this.widget,
    @required this.f

});

  @override
  _AddVisiteTileState createState() => _AddVisiteTileState();
}

class _AddVisiteTileState extends State<AddVisiteTile> {

  String img_complaint =  'images/complaint_color.webp';
  String img_clinical_finding_color =  'images/clinical_finding_color.png';
  String img_diagnosis =  'images/diagnosis.webp';
  String img_medicine_color =  'images/medicine_color.webp';
  String img_vital_color =  'images/vital_color.webp';
  String img_investigation_color =  'images/investigation_color.webp';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(1.w),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2,


        child: ListTile(

          title: Padding(
            padding:  EdgeInsets.only(top: 1.w),
            child: Text(widget.name, ),
          ),
          leading:  widget.widget,

          trailing: IconButton(onPressed: ()async{



            // print(formatDate(widget.data.visit_date.toDate(),[dd, '-', mm, '-', yyyy]).toString());


            showDialog(
                context: context,
                builder: (context)  {



                  return  List_Search(result: widget.list, get: Storage.get, set: Storage.set, group: widget.group, Group: widget.Group, one_select: false, ky: widget.ky);}

            ).then((value)async{

              print(value);

              if(value != null)
              {
                setState(() {

                  widget.list = value;

                });


              }
            });










          }, icon: Icon(Icons.arrow_drop_down_circle_outlined , color: Colors.black,)),

          subtitle: Padding(
            padding:  EdgeInsets.only(top: 1.w),
            child: Container(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.list.map<Widget>((e)=>DropDown(e) ).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget DropDown (String menu)
{
  return Text(menu , textScaleFactor: AppTheme.list_tile_subtile,);
}