import 'package:flutter/material.dart';

import 'package:flutter_app/widgets/drop_down_menu_button.dart';

class Services extends StatefulWidget {
@override
_State createState() => _State();
}

class _State extends State<Services> {
@override
Widget build(BuildContext context) {
return Container(
  child: DropDown(menu: ['aaa','wer'],),
);
}
}