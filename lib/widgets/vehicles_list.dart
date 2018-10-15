import 'package:flutter/material.dart';
import 'package:track_my_car/models/vehicle.dart';

class VehiclesList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return VehiclesListState();
  }

}

class VehiclesListState extends State<VehiclesList> {

  List<Vehicle> vehicles = [];

  VehiclesListState() {
    
  }

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
    return vehicles.length > 0 
      ? ListView.builder(
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
      )
    : Center(child: Text("Nenhum veículo cadastrado"),);
  }

}