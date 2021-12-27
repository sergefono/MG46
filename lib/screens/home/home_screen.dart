import 'package:flutter/material.dart';
import 'package:gcp/services/authentification.dart';

class HomeScreen extends StatelessWidget {
  final AuthentificationService _authentificationService =
      AuthentificationService();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        title: Text("Health Sector"),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              await _authentificationService.singOut();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
