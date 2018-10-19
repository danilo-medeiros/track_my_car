import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
        child: Text("Escolha uma opção"),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      ),
      ListTile(
        leading: Icon(Icons.add),
        title: Text("Veículos"),
        onTap: () {
          Navigator.pushNamed(context, '/vehicles');
        },
      ),
      ListTile(
        leading: Icon(Icons.create_new_folder),
        title: Text("Perfis"),
        onTap: () {
          Navigator.pushNamed(context, '/profiles');
        },
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(title: Text("Track my Car")),
        body: new GridView.count(
          primary: true,
          padding: const EdgeInsets.all(10.0),
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: <Widget>[
            _buildMenuCard(context, "Veículos", "/vehicles", "assets/car.png"),
            _buildMenuCard(context, "Perfis", "/profiles", "assets/tools.png")
          ],
        ));
  }

  Widget _buildMenuCard(
      BuildContext context, String text, String route, String image) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: RaisedButton(
          color: Colors.black12,
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          elevation: 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Image.asset(
                image,
                height: 90.0,
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(child: new Text(text)))
            ],
          ),
        ));
  }
}
