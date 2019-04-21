import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../services/auth.dart' as authService;

const _USERNAME_MIN_LENGTH = 6;
const _PASSWORD_MIN_LENGTH = 6;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSubmitting = false, _obscurePassword = true;
  String _username, _email, _password;

  Widget _showTitle() {
    return Text("Welcome!", style: Theme.of(context).textTheme.headline);
  }

  Widget _showUsernameInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (value) => _username = value,
        validator: (value) => !isLength(value, _USERNAME_MIN_LENGTH)
            ? 'Username must be longer than $_USERNAME_MIN_LENGTH'
            : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Username",
            hintText: "Enter a username...",
            icon: Icon(Icons.face)),
      ),
    );
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
            hintText: "Enter an email...",
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
            hintText: "Enter a password...",
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
                  child: Text("Create account"),
                  textColor: Colors.red[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                  ),
                ),
          FlatButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            child: Text("Already a user? Login"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: Text("Register"),
      // ),
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
                  _showUsernameInput(),
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
        final Map<String, dynamic> response =
            await authService.registerUser(_username, _email, _password);

        if (response['ok']) {
          form.reset();
          return _handleRegisterSuccess();
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

  void _handleRegisterSuccess() {
    _showSnackBar("User $_username successfully registered!", "success");
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
          context, '/products'); // Go to products page
    });
  }
}
