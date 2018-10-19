import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          CircularProgressIndicator(),
          Padding(padding: EdgeInsets.all(10.0), child: Text("Carregando..."))
        ]));
  }
}
