import '../components/logo.dart';
import '../core/logger.dart';
import '../services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Center(child: Column(children: [_Form()]))));
  }
}

class _Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool hasError = false;
  String currentError = "";
  BuildContext formContext;
  double percent = 0;

  Widget _logo() {
    return Padding(
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
        child: appLogo(context));
  }

  Widget _entryField(String title, TextEditingController controller,
      [bool isPassword = false]) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
        ],
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Container(
          width: double.infinity,
          color: Colors.transparent,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0),
          child: const Text('Se connecter', style: TextStyle(fontSize: 20)),
        ),
        onPressed: _auth,
      ),
    );
  }

  _auth() {
    Scaffold.of(formContext).showSnackBar(new SnackBar(
      duration: Duration(seconds: 3600),
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text("  Signing-In...")
        ],
      ),
    ));

    setState(() {
      this.hasError = false;
      this.currentError = "";
    });

    AuthService()
        .attempt(usernameController.text, passwordController.text)
        .then((value) {
      Log.verbose("[LoginPage] Logged In.");
      Navigator.pushNamedAndRemoveUntil(formContext, "/", (route) => false);
      Scaffold.of(formContext).hideCurrentSnackBar();
    }).catchError((error) {
      Log.info("[LoginPage] Not logged in.", error, StackTrace.current);
      Scaffold.of(formContext).hideCurrentSnackBar();
      setState(() {
        hasError = true;
        currentError = error.toString();
      });
    });
  }

  Widget _error() {
    return Container(
        alignment: Alignment.centerLeft,
        child: Visibility(
          child: Text(currentError, style: TextStyle(color: Colors.red)),
          visible: hasError,
        ));
  }

  @override
  Widget build(BuildContext context) {
    formContext = context;
    return Center(
      child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              _logo(),
              _entryField("Username", usernameController),
              _error(),
              SizedBox(
                height: 20.0,
              ),
              _entryField("Password", passwordController, true),
              _submitButton(context)
            ],
          )),
    );
  }
}
