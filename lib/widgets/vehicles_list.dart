import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:track_my_car/scoped_models/vehicles.dart';
import 'package:track_my_car/widgets/item_list.dart';
import 'package:track_my_car/widgets/loading.dart';

class VehiclesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<VehicleModel>(
      builder: (BuildContext context, Widget child, VehicleModel model) {
        return FutureBuilder(
            future: model.list(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ItemList(
                    detailsRoute: "/vehicles/details",
                    itens: snapshot.data,
                    selectItem: model.select);
              } else {
                return Loading();
              }
            });
      },
    );
  }
}
