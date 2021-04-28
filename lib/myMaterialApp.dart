import 'package:detalhe_parceiros_module_2/main.dart';
import 'package:detalhe_parceiros_module_2/secondscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget MyMaterialApp(){
  return MaterialApp(
    title: 'Named Routes Demo',
    initialRoute: '/',
    routes: {
      '/': (BuildContext context) => Screen(),
      '/second': (BuildContext context) => SecondRoute()
    },
  );
}