import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTheme{

  static double aspectRatio = 100.w/100.h;






  static const Color notWhite = Color.fromRGBO(252, 252, 252 , 1);
    //00FEA3

  static const Color orange = Colors.deepOrangeAccent;

  static const Color green1 = Color(0xff42FFBB);



  static const royal_blue = Color(0xff2CA3FA);
  static const diff_blue = Color(0xff5BA2F4);




  static const dark_teal = Color(0xff17352E);
  static const blue_grey = Colors.blueGrey;


  static const Color green = Color(0xff019874);
  static const teal = Color(0xff017D98);
  static const Color offwhite = Color.fromRGBO(232, 231, 230,1);
  static const black = Colors.black;
  static const Color white = Colors.white;
  static const Color light_black = Colors.black12;
  static const Color grey = Colors.grey;
  static const Color yellow = Colors.yellowAccent;



   static double size = 20.sp;
   static double circle = 10.h;

   static final icon_size = AppTheme.aspectRatio*40;


   static final main_black_25 = TextStyle(
     fontSize: aspectRatio*25,


     color: AppTheme.black,



   );
  static final main_grey_25 = TextStyle(
    fontSize: aspectRatio*25,


    color: AppTheme.grey,



  );

  static final main_white_25 = TextStyle(
    fontSize: aspectRatio*25,

    color: AppTheme.white,



  );

  static final main_white_30 = TextStyle(
    fontSize: aspectRatio*30,

    color: AppTheme.white,



  );

   static final grey_20 = TextStyle(
     fontSize: aspectRatio*20,
     color: Colors.grey

   );



   static final grey_italic_20 = TextStyle(fontStyle: FontStyle.italic , fontSize: aspectRatio*20);

  static final grey_22 = TextStyle(
    fontSize: aspectRatio*22,
    color: Colors.grey,
  );


  static final black_35 = TextStyle(
    fontSize: aspectRatio*35,
    color: Colors.black,
  );

  static final ksearchBar = TextStyle(
    fontSize: aspectRatio*22,
    color: Colors.black,
  );

  static final black_22 = TextStyle(
    fontSize: aspectRatio*22,
    color: Colors.black,
  );


  static final subtile_22 = TextStyle(
    fontSize: aspectRatio*22,

  );










}