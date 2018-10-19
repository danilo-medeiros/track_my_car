import 'package:flutter/material.dart';
import 'package:track_my_car/widgets/vehicles_list.dart';

class VehiclesPage extends StatelessWidget {

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      AppBar(
        title: Text("Escolha uma opção"),
        automaticallyImplyLeading: false,
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text("Tela inicial"),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
      ListTile(
        leading: Icon(Icons.create_new_folder),
        title: Text("Adicionar perfil"),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/profiles');
        },
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Veículos")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/vehicles/form');
        },
      ),
      body: VehiclesList(),
    );
  }


}
