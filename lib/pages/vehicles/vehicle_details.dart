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
                Card(
                  child: Column(
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.gps_fixed),
                        title: Text('Localizado última vez em 23/04/2018 10:45'),
                      ),
                      ButtonTheme.bar(
                        // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('VER HISTÓRICO'),
                              onPressed: () {/* ... */},
                            ),
                            FlatButton(
                              child: const Text('LOCALIZAR AGORA'),
                              onPressed: () {/* ... */},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      const ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Bloqueio de combustível'),
                      ),
                      ButtonTheme.bar(
                        // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('BLOQUEAR'),
                              onPressed: () {/* ... */},
                            ),
                            FlatButton(
                              child: const Text('DESBLOQUEAR'),
                              onPressed: () {/* ... */},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                /* Card(
                    child: Container(
                        child: Row(children: <Widget>[
                          Icon(Icons.gps_fixed),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            vehicle.lastLatitude != null
                                ? "Última localização: ${vehicle.lastLatitude}, ${vehicle.lastLongitude}"
                                : "Localização indefinida",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )
                        ]),
                        padding: EdgeInsets.all(15.0))),
                Card(
                    child: Container(
                        child: Row(children: <Widget>[
                          Icon(Icons.phone),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            vehicle.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )
                        ]),
                        padding: EdgeInsets.all(15.0))),
                Card(
                    child: Container(
                        child: Row(children: <Widget>[
                          Icon(Icons.vpn_key),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            vehicle.password,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )
                        ]),
                        padding: EdgeInsets.all(15.0))), */
              ]);
            } else {
              return Loading();
            }
          },
        ),
        /* floatingActionButton: FloatingActionButton(
          child: Icon(Icons.edit),
          onPressed: () => Navigator.pushNamed(context, '/vehicles/form'),
        ), */
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
