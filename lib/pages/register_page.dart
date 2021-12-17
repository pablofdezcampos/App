import 'package:app/pages/home_page.dart';
import 'package:app/response/response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static const route = '/register';
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  late String _email, _password;
  //bool _error = false;
  RegisterResponse registerResponse =
      RegisterResponse.unknowError('Unknow Error');

  Future _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      'Register Page',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) => _email = value,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User email',
                          hintText: 'user@gmail.com',
                          hintMaxLines: 1),
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
                      onChanged: (value) => _password = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                          onPressed: _createUser,
                          child: const Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ))),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
