import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:track_my_car/scoped_models/vehicles.dart';

class VehicleDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VehicleDetailsPageState();
  }
}

class VehicleDetailsPageState extends State<VehicleDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VehicleModel>(
        builder: (BuildContext context, Widget child, VehicleModel model) {
      return Scaffold(
          appBar: AppBar(
            title: Text(model.selectedVehicle.name),
            actions: <Widget>[
              FlatButton(
                child: Icon(Icons.delete),
                onPressed: () {
                  model.deleteVehicle();
                },
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.delete),
            onPressed: () {
              model.deleteVehicle();
              Navigator.pop(context);
            },
          ),
          body: ListView(children: <Widget>[
            Container(
                color: Colors.blue,
                height: MediaQuery.of(context).size.height / 2,
                // Dummy text
                child: Center(child: Text("O mapa vai aqui"))),
            Center(
              child: Text(
                model.selectedVehicle.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Center(child: Text("Última localização: -45.23123, -56.04993"))
          ]));
    });
  }
}
