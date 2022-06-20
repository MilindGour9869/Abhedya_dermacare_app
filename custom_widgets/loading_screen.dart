import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/loading_indicator.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child:LoadingIndicator()
        );
  }
}
