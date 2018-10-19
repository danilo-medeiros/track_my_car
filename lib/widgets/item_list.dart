import 'package:flutter/material.dart';
import 'package:track_my_car/models/list_item.dart';

class ItemList extends StatelessWidget {
  final List<ListItem> itens;
  final Function(Map<int, dynamic>) selectItem;
  final String detailsRoute;

  ItemList(
      {@required this.itens, this.selectItem, @required this.detailsRoute});

  Card _buildItem(BuildContext context, ListItem item) {
    return Card(
        child: Column(children: <Widget>[
      ListTile(
        onTap: () {
          selectItem(item.toMap());
          Navigator.pushNamed(context, detailsRoute);
        },
        title: Text(
          item.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(item.detail),
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return itens.length > 0
        ? ListView(
            children: itens.map((item) => _buildItem(context, item)).toList())
        : Center(
            child: Text('Nenhum registro encontrado'),
          );
  }
}
