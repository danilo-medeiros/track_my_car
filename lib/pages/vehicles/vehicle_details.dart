import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:track_my_car/models/vehicle.dart';
import 'package:track_my_car/scoped_models/vehicles.dart';
import 'package:track_my_car/widgets/item_details.dart';
import 'package:track_my_car/widgets/loading.dart';

class VehicleDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VehicleModel>(
        builder: (BuildContext context, Widget child, VehicleModel model) {
      return ItemDetails(
        deleteItem: model.delete,
        cleanData: () => model.selectedVehicle = null,
        itemName: model.selectedVehicle.name,
        child: FutureBuilder(
          future: model.fetch(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Vehicle vehicle = snapshot.data;

              return ListView(children: <Widget>[
                Container(
                    color: Colors.blue,
                    height: MediaQuery.of(context).size.height / 2,
                    // Dummy text
                    child: Center(child: Text("O mapa vai aqui"))),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: _buildDataRow("Nome do veículo", vehicle.name)),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: _buildDataRow("Número do chip", vehicle.number)),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: _buildDataRow("Senha", vehicle.password)),
                Center(
                    child: Text(vehicle.lastLatitude != null
                        ? "Última localização: ${vehicle.lastLatitude}, ${vehicle.lastLongitude}"
                        : "Localização indefinida"))
              ]);
            } else {
              return Loading();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () => Navigator.pushNamed(context, '/vehicles/form'),
        ),
      );
    });
  }

  Widget _buildDataRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              )),
        ),
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(value,
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold))))
      ],
    );
  }
}
