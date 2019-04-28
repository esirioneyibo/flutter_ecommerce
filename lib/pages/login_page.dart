import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../services/auth.dart' as authService;

const _PASSWORD_MIN_LENGTH = 6;

class LoginPage extends StatefulWidget {
  static const ROUTE = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting = false, _obscurePassword = true;
  String _email, _password;

  Widget _showTitle() {
    return Text("Welcome back!", style: Theme.of(context).textTheme.headline);
  }

  Widget _showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => _email = value,
        validator: (value) => !isEmail(value) ? 'Enter a valid email' : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Email",
            hintText: "Enter your email...",
            icon: Icon(Icons.mail)),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (value) => _password = value,
        validator: (value) => !isLength(value, _PASSWORD_MIN_LENGTH)
            ? 'Password must be longer than $_PASSWORD_MIN_LENGTH characters'
            : null,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () => setState(() => _obscurePassword = !_obscurePassword),
              child: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off),
            ),
            border: OutlineInputBorder(),
            labelText: "Password",
            hintText: "Enter your password...",
            icon: Icon(Icons.lock)),
      ),
    );
  }

  Widget _showFormActions() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          _isSubmitting
              ? CircularProgressIndicator()
              : RaisedButton(
                  onPressed: () => _handleSubmit(),
                  color: Theme.of(context).accentColor,
                  child: Text("Log in"),
                  textColor: Colors.red[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                  ),
                ),
          FlatButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/register'),
            child: Text("Create a new account now!"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _obscurePassword = true;
    return Scaffold(
      key: _scaffoldKey,
      /* appBar: AppBar(
        title: Text("Log In"),
      ), */
      backgroundColor: Colors.grey[200],
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _showTitle(),
                  _showEmailInput(),
                  _showPasswordInput(),
                  _showFormActions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(message, type) {
    final color = (type == 'success')
        ? Colors.green
        : type == 'error' ? Colors.red : Colors.amber;
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _handleSubmit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() => _isSubmitting = true);
      try {
        final response = await authService.loginUser(_email, _password);
        if (response['ok']) {
          form.reset();
          return _handleLoginSuccess();
        }
        _showSnackBar(response['message'], 'error');
      } catch (e) {
        _showSnackBar(e.toString(), 'error');
      } finally {
        setState(() => _isSubmitting = false);
      }
    } else {
      print('Invalid form!');
    }
  }

  void _handleLoginSuccess() {
    Navigator.pushReplacementNamed(context, '/products'); // Go to products page
  }
}
