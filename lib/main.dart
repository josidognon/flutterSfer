import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_agrosfer_flutter_app/data.dart';
import 'package:my_agrosfer_flutter_app/profil.dart';
import 'custom_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();
  String email;
  String password;

  String token;

  FocusNode myFocusNodeEmail;
  FocusNode myFocusNodePassword;
  final _formKey = GlobalKey<FormState>();
  final String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String changed;
  String submitted;

  @override
  void initState() {
    super.initState();

    myFocusNodeEmail = FocusNode();
    myFocusNodePassword = FocusNode();
  }

  @override
  void dispose() {
    myControllerEmail.dispose();
    myControllerPassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodePassword.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.height / 6,
              child: new Image.asset('image/group_45.png', fit: BoxFit.fill),
            ),
            new Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 5,
                        child: new Image.asset('image/logoagro.png',
                            fit: BoxFit.contain),
                      ),
                      new Theme(
                        data: new ThemeData(
                            primaryColor: Colors.green,
                            primaryColorDark: Colors.green),
                        child: new TextFormField(
                          focusNode: myFocusNodeEmail,
                          autofocus: true,
                          controller: myControllerEmail,
                          maxLength: 25,
                          cursorColor: Colors.green,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (String string) {
                            setState(() {
                              changed = string;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Veuillez saisir votre adresse email';
                            }
                            RegExp regExp = new RegExp(emailPattern);
                            if (!regExp.hasMatch(value)) {
                              return "Veuillez sasir une Adresse email valide. ";
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                              labelText: 'Email (example@domaine.com)',
                              hintText: 'Adresse email',
                              border: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.green),
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(100.0)))),
                        ),
                      ),
                      new Container(height: 20),
                      new Theme(
                          data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.green),
                          child: new TextFormField(
                            focusNode: myFocusNodePassword,
                            autofocus: true,
                            controller: myControllerPassword,
                            maxLength: 25,
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: Colors.green,
                            obscureText: true,
                            onChanged: (String string) {
                              setState(() {
                                changed = string;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'veuillez saisir votre mot de password';
                              }
                              return null;
                            },
                            decoration: new InputDecoration(
                                hintText: 'Mot de passe',
                                labelText: 'Mot de passe',
                                border: OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.green),
                                    borderRadius: const BorderRadius.all(
                                        const Radius.circular(100.0))),
                                suffixIcon: const Icon(
                                  Icons.remove_red_eye_sharp,
                                  color: Colors.blueGrey,
                                )),
                          )),
                      new Container(height: 20),
                      new RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          email = myControllerEmail.text;
                          password = myControllerPassword.text;

                          if (_formKey.currentState.validate()) {
                            // appelAPI();

                            // Future.delayed(Duration(milliseconds: 5000)).then((_) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profil()));

                            // });
                            //   // myFocusNodeEmail.requestFocus();
                            //   // myFocusNodePassword.requestFocus();
                            //
                            //   // showInSnackbar('Traitement en cours...', context);
                            //
                            //
                            //
                            //
                          }
                        },
                        child: new CustomText("Connexion",
                            factor: 1.5, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0)),
                      ),
                    ],
                  ),
                )),
            new Container(
              height: MediaQuery.of(context).size.height / 5,
              child: Image.asset('image/group_46.png', fit: BoxFit.fill),
            )
          ],
        )));
  }

  void showInSnackbar(String motAAfficher, BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: new Text(motAAfficher)));
  }

  void appelAPI() async {
    List<String> arguments;

    email = myControllerEmail.text;
    password = myControllerPassword.text;
    final client_id = 'agrosfer-2.0';

    // final urlApi = "http://51.38.178.63:8383/auth/realms/agrosferDemo/protocol/openid-connect/token?client_id=$client_id&username=$email&password=$password&grant_type=password";
    final urlApi =
        "http://51.38.178.63:8383/auth/realms/agrosferDemo/protocol/openid-connect/token";

    Map<String, String> body = {
      "client_id": client_id,
      "username": email,
      "password": password,
      "grant_type": "password"
    };

    final response = await http.post(urlApi,
        headers: {
          HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
        },
        body: body);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      token = jsonResponse["access_token"];
      data.token = token;
      data.email = email;
      data.password = password;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    // return data.token;
  }

// void _printeLastedValue(){
//   print()
// }
}
