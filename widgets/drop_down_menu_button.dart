import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {

  List menu;

  DropDown({this.menu});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: DropdownButton(


          items: widget.menu.map((e)=>Menu(e)).toList(), onChanged: (var a){}),
    );
  }
}


DropdownMenuItem<String> Menu(String item)
{

  return DropdownMenuItem(
      value: item,
      child: Text('sss'));

}
