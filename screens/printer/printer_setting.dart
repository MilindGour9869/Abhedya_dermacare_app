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


    setState(() {
      dr_name = dr_name;
    });

  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    f();




  }
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
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
      ),
    );
  }
}
