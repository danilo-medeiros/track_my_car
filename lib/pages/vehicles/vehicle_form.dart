import 'package:flutter/material.dart';
import 'package:track_my_car/models/vehicle.dart';

class VehicleFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VehicleFormPageState();
  }
}

class VehicleFormPageState extends State<VehicleFormPage> {

  final Vehicle _vehicle = new Vehicle();
  

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    FocusScope.of(context).requestFocus(new FocusNode());
    
    //Navigator.pushReplacementNamed(context, '/vehicles');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: Icon(Icons.check),
      ),
      appBar: AppBar(title: Text("Adicionar veículo")),
      body: Container(
        margin: EdgeInsets.all(20.0),
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Nome do veículo"),
              textCapitalization: TextCapitalization.words,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Informe o nome do veículo";
                }
              },
              onSaved: (String value) {
                this._vehicle.name = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Número do chip"),
              keyboardType: TextInputType.number,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Informe o número do chip";
                }
              },
              onSaved: (String value) {
                this._vehicle.number = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Senha do rastreador"),
              obscureText: true,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Informe a senha do rastreador";
                }
              },
              onSaved: (String value) {
                this._vehicle.password = value;
              },
            ),
            Center(child: Text("${_vehicle.name}"),)
          ],
        ),
      )),
    );
  }
}
