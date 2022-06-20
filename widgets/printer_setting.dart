import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/storage/storage.dart';

class PrinterSetting extends StatefulWidget {
  @override
  _PrinterSettingState createState() => _PrinterSettingState();
}

class _PrinterSettingState extends State<PrinterSetting> {


  bool dr_name = true;

  Future f()async{

    dr_name =await Storage.get_dr_name();

  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    f();




  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Text('Print Doctor Name'),
              CupertinoSwitch(
                value: dr_name,
                onChanged: (value) {
                  setState(() {
                    dr_name = value;
                  });
                },
              ),

            ],
          )
        ],
      ),
    );
  }
}
