import 'package:flutter/material.dart';
import 'package:gcp/common/constants.dart';
import 'package:gcp/common/loading.dart';
import 'package:gcp/services/authentification.dart';

class AuthentificateScreen extends StatefulWidget {
  @override
  _AuthentificateScreenState createState() => _AuthentificateScreenState();
}

class _AuthentificateScreenState extends State<AuthentificateScreen> {
  final AuthentificationService _authentificationService =
      AuthentificationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState!.reset();
      error = '';
      emailController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              elevation: 0.0,
              title: Text(showSignIn
                  ? 'Sign In Health Sector'
                  : 'Register In Health Sector'),
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () => toggleView(),
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: Text(
                      showSignIn ? 'Register' : 'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'email'),
                        validator: (value) => value != null && value.isEmpty
                            ? "Verify email"
                            : null,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: passwordController,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'password'),
                        obscureText: true,
                        validator: (value) => value != null && value.length < 4
                            ? "Enter a password with at least 6 caracters"
                            : null,
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        child: Text(
                          showSignIn ? "Sign In" : "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            var password = passwordController.value.text;
                            var email = emailController.value.text;

                            dynamic result = showSignIn
                                ? await _authentificationService
                                    .signInWithEmailAndPassword(email, password)
                                : await _authentificationService
                                    .createUserWithEmailAndPassword(
                                        email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 15.0),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
