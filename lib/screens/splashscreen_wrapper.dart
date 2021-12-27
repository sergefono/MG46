import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:gcp/models/user.dart';
import 'package:gcp/screens/authentificate/authentificate_screen.dart';
import 'package:gcp/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class SplashscreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return AuthentificateScreen();
    }
    return HomeScreen();
  }
}
