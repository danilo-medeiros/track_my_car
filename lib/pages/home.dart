import 'package:flutter/material.dart';

import './../widgets/main_menu.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainMenu(),
      appBar: AppBar(title: Text("Track my Car")),
      body: Container(child: Center(child: Text("Home page"))),
    );
  }
}
