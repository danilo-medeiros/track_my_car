import 'package:flutter/material.dart';
import './pages/home.dart';

import './pages/vehicles/vehicles.dart';
import './pages/vehicles/vehicle_form.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Track my Car',
      theme: new ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/vehicles': (BuildContext context) => VehiclesPage(),
        '/vehicles/new': (BuildContext context) => VehicleFormPage()
      }
    );
  }
}
