import 'package:flutter/material.dart';

import './../../widgets/main_menu.dart';
import './../../models/vehicle.dart';

class VehiclesPage extends StatelessWidget {

  final List<Vehicle> vehicles = [
    Vehicle.fromVehicle("Camaro", "848465454", "123456", 2),
    Vehicle.fromVehicle("Corvette", "874546452", "123456", 2)
  ];

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        print("Edit vehicle");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainMenu(),
      appBar: AppBar(title: Text("Veículos")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/vehicles/new');
        },
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(vehicles[index].name),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.startToEnd) {
                print("Delete vehicle");
              }
            },
            background: Container(color: Colors.red,),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(vehicles[index].name),
                  subtitle: Text(vehicles[index].number),
                  trailing: _buildEditButton(context, index)
                ),
                Divider()
              ]
            )
          );
        },
        itemCount: vehicles.length,
      ),
    );
  }
}
