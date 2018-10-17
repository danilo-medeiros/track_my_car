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

  Future<Null> _buildDeleteVehicleDialog(Function delete) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar veículo'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você tem certeza que deseja excluir este veículo?')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Voltar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Excluir'),
              onPressed: () {
                /// TODO: Delete vehicle!!!
                delete();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VehicleModel>(
        builder: (BuildContext context, Widget child, VehicleModel model) {
      return WillPopScope(
          onWillPop: () {
            model.selectedVehicle = null;
            Navigator.pop(context, false);
            return Future.value(false);
          },
          child: !model.isLoading && model.selectedVehicle.id != null
              ? Scaffold(
                  appBar: AppBar(
                    title: Text(model.selectedVehicle.name),
                    actions: <Widget>[
                      FlatButton(
                        child: Icon(Icons.delete),
                        onPressed: () {
                          _buildDeleteVehicleDialog(model.delete);
                        },
                      )
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(context, '/vehicles/form');
                    },
                  ),
                  body: ListView(children: <Widget>[
                    Container(
                        color: Colors.blue,
                        height: MediaQuery.of(context).size.height / 2,
                        // Dummy text
                        child: Center(child: Text("O mapa vai aqui"))),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                            model.selectedVehicle.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        )),
                    Center(
                        child: Text(model.selectedVehicle.lastLatitude != null
                            ? "Última localização: ${model.selectedVehicle.lastLatitude}, ${model.selectedVehicle.lastLongitude}"
                            : "Localização indefinida"))
                  ]))
              : Center(
                  child: Text("Nenhum veículo cadastrado"),
                ));
    });
  }
}
