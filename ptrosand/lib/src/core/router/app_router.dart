import 'package:flutter/material.dart';
import 'package:ptrosand/src/features/introduction/presentation/intro_view.dart';

class AppRouter {
  static const initialRoute = '/';

  static final routes = <String, WidgetBuilder>{
    '/': (context) => const IntroView(),
  };
}