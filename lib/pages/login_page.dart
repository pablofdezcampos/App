import 'package:app/pages/home_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const route = '/login';
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  late Exception exception;
  bool error = false;
  bool showPassword = false;
  late String _email, _password;

  String emailValidator(String value) {
    final emailValid = RegExp('').hasMatch(value);
    if (!emailValid) {
      return 'Please, insert a correct email';
    } else {
      throw Exception('INCORRECT USER OR PASSWORD');
    }
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  String _emailValidator(String value) {
    final emailValid = RegExp('').hasMatch(value);
    if (!emailValid) {
      return 'Please, insert a valid email';
    }
    throw Exception();
  }

  String _passwordValidator(String value) {
    if (value.length < 3) {
      return 'The length of the password can not be less to 3 characters';
    }
    throw Exception();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                      padding: const EdgeInsets.all(60.0),
                      child: Center(
                        child: Image.asset('assets/images/logo.jpeg'),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User email',
                          hintText: 'user@gmail.com',
                          hintMaxLines: 1),
                      validator: (value) => _emailValidator(value!),
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User password',
                        hintText: '******',
                        hintMaxLines: 1,
                      ),
                      obscureText: !showPassword,
                      validator: (value) => _passwordValidator(value!),
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                  ),
                  if (error)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Incorrect user or password',
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: const Text('Create account')),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                          onPressed: _login,
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ))),
                    ),
                  )
                ]))));
  }
}

/*
() async {
                            try {
                              final user =
                                  await auth.signInWithEmailAndPassword(
                                      email: _email, password: _password);
                              Navigator.pushReplacementNamed(
                                  context, HomePage.route);
                              // ignore: empty_catches
                            } catch (exception) {}
                          },
*/