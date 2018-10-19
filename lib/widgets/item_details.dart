import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  final Function cleanData;
  final Function deleteItem;
  final String itemName;
  final Widget child;
  final FloatingActionButton floatingActionButton;

  ItemDetails(
      {@required this.deleteItem,
      this.cleanData,
      this.itemName,
      this.child,
      this.floatingActionButton});

  Future<Null> _buildDeleteItemDialog(BuildContext context) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar item'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você tem certeza que deseja excluir este item?')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Voltar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Excluir'),
              onPressed: () {
                deleteItem().then((_) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          cleanData();
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(itemName),
              actions: <Widget>[
                FlatButton(
                  child: Icon(Icons.delete),
                  onPressed: () {
                    _buildDeleteItemDialog(context);
                  },
                )
              ],
            ),
            floatingActionButton: floatingActionButton,
            body: child));
  }
}
