import 'package:flutter/material.dart';
import 'package:restaurante/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Nome Completo",
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty) return "Nome Invalido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail Invalido";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                      hintText: "Senha",
                    ),
                    obscureText: true,
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length < 6)
                        return "Senha Invalida";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: "Endereço",
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty) return "Endereço Invalida";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        "Criar Conta",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "address": _addressController.text
                          };

                          model.signUp(
                              userData: userData,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {}
  void _onFail() {}
}

