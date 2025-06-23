import 'package:flutter/material.dart';
import 'package:ptrosand/src/features/introduction/presentation/intro_view.dart';
import 'package:ptrosand/src/features/pyrosand/presentation/pyrosand_view.dart';

class AppRouter {
  static const initialRoute = '/';

  static final routes = <String, WidgetBuilder>{
    '/': (context) => const IntroView(),
    'pyrosand': (context) => const PyrosandView()
  };
}