import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:track_my_car/scoped_models/vehicles.dart';

class VehiclesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VehiclesListState();
  }
}

class VehiclesListState extends State<VehiclesList> {
  Widget _buildPositionButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.gps_fixed),
      onPressed: () {
        print("Locate vehicle");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VehicleModel>(
      builder: (BuildContext context, Widget child, VehicleModel model) {
        if (model.isLoading) {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Carregando veículos"))
              ]));
        } else {
          return model.vehicles.length > 0
              ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: Column(children: <Widget>[
                      ListTile(
                        onTap: () {
                          print("Abrir detalhes do veículo");
                        },
                          title: Text(
                            model.vehicles[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(model.vehicles[index].number),
                          trailing: _buildPositionButton(context, index))
                    ]));
                  },
                  itemCount: model.vehicles.length,
                )
              : Center(
                  child: Text("Nenhum veículo cadastrado"),
                );
        }
      },
    );
  }
}
