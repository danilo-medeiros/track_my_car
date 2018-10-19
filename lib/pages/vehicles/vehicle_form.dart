import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:track_my_car/models/vehicle.dart';
import 'package:track_my_car/scoped_models/vehicles.dart';

class VehicleFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VehicleFormPageState();
  }
}

class VehicleFormPageState extends State<VehicleFormPage> {
  final Vehicle _vehicle = new Vehicle();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  /// Build the vehicle's name field
  Widget _buildNameField(String name) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          decoration: InputDecoration(hintText: "Nome do veículo"),
          initialValue: name != null ? name : "",
          textCapitalization: TextCapitalization.words,
          validator: (String value) {
            if (value.isEmpty) {
              return "Informe o nome do veículo";
            }
          },
          onSaved: (String value) {
            this._vehicle.name = value;
          },
        ));
  }

  Widget _buildNumberField(String number) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: "Número do chip"),
        initialValue: number != null ? number : "",
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
    );
  }

  Widget _buildPasswordField(String password) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          decoration: InputDecoration(hintText: "Senha do rastreador"),
          obscureText: true,
          initialValue: password != null ? password : "",
          validator: (String value) {
            if (value.isEmpty) {
              return "Informe a senha do rastreador";
            }
          },
          onSaved: (String value) {
            this._vehicle.password = value;
          },
        ));
  }

  /// save: The method that will be executed when the user submits the form.
  void _submitForm(Function(Vehicle vehicle) persist, Function callback) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    persist(_vehicle).then((_) {
      callback();
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VehicleModel>(
      builder: (BuildContext context, Widget child, VehicleModel model) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (model.selectedVehicle != null) {
                _submitForm(model.update, () => Navigator.pop(context));
              } else {
                _submitForm(model.save, () => Navigator.popAndPushNamed(context, '/vehicles/details'));
              }
            },
            child: Icon(Icons.check),
          ),
          appBar: AppBar(
              title: Text(model.selectedVehicle != null
                  ? "Editar veículo"
                  : "Adicionar veículo")),
          body: Container(
              child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: <Widget>[
                  _buildNameField(model.selectedVehicle?.name),
                  _buildNumberField(model.selectedVehicle?.number),
                  _buildPasswordField(model.selectedVehicle?.password),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
