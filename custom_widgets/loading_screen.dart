import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/loading_indicator.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: SizedBox(
          height: 70,
          width: 70,
          child: LoadingIndicator())),
    );
  }
}
