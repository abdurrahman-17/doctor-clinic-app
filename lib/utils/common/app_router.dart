import 'package:doctor_clinic_token_app/View/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class AppRouter {
  AppRouter._internal();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case OnboardingScreen.ROUTE_NAME:
      //   return buildPageRoute(OnboardingScreen(), settings);


      default:
        return MaterialPageRoute(builder: (_) => Login());
    }
  }

  static MaterialPageRoute buildPageRoute(
      Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => widget, settings: settings);
  }

//static String get initialRoute => SplashScreen.ROUTE_NAME;
}
