import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      AppBar(
        title: Text("Escolha uma opção"),
        automaticallyImplyLeading: false,
      ),
      ListTile(
        leading: Icon(Icons.add),
        title: Text("Adicionar veículo"),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/vehicles');
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
      drawer: _buildDrawer(context),
      appBar: AppBar(title: Text("Track my Car")),
      body: Container(child: Center(child: Text("Home page"))),
    );
  }
}
