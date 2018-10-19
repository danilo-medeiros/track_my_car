import 'package:flutter/material.dart';

class ProfilesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Perfis")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/vehicles/form');
        },
      ),
      body: Center(child: Text('Tela de perfis'),),
    );
  }

}