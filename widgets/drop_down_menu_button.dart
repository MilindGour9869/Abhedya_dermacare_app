import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  Map<String , int> menu={};
  Color color;




  DropDown({this.menu, this.color });

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {

    List service = widget.menu.keys.toList();
    List charge = widget.menu.values.toList();



    return ListView.builder(
        shrinkWrap: true,
        itemCount: service.length,
        itemBuilder: (context, index) => Container(
              height: MediaQuery.of(context).size.height * 0.05,
              color: Colors.transparent,
              child: Center(
                child: ListTile(
                  tileColor: Colors.transparent,
                  dense: true,
                  title: Text(
                    service[index],
                    style: TextStyle(color: widget.color),
                  ),
                  leading: Icon(
                    Icons.double_arrow,
                    size: MediaQuery.of(context).size.height * 0.025,
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(charge[index].toString()),
                  ),
                ),
              ),
            ));
  }
}
