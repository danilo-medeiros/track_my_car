import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
