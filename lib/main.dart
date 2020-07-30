import 'package:flutter/material.dart';
import 'package:payment_app/constants.dart';
import 'package:payment_app/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case (homeRoute):
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);

      default:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
    }
  }
}
