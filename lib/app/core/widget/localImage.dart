import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../values/app_values.dart';

class Localimage extends StatelessWidget{
  final String? localImage;
  Localimage({
    super.key,

    this.localImage,

  }) ;
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
         child:localImage!=null? Image.file(
            File(localImage ?? ""),
            fit: BoxFit.cover,
            width: height_120,
            height: height_120,
          ):Text("hjkdfhfhhfhjkhjkfhjfhj",style: TextStyle(color: Colors.red),),
        ),
      );
  }

}