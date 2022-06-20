import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding:  EdgeInsets.all(2.w),
      child: CircularProgressIndicator(),
    ));
  }
}
