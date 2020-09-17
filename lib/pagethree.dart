import 'package:flutter/material.dart';

class PageThree extends StatefulWidget {
  // Here will be code
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageThree"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Page 3"),
            RaisedButton(
                child: Text('Retour'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
