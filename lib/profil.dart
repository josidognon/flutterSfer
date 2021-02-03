import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_agrosfer_flutter_app/data.dart';
import 'package:my_agrosfer_flutter_app/users.dart';
import 'custom_text.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http ;


class Profil extends StatefulWidget{
  @override
  _ProfilState createState() => new _ProfilState();

  }



class _ProfilState extends State<Profil> {

  final myControllerCommune = TextEditingController();
  final myControllerArrondissement = TextEditingController();
  final myControllerQuatier = TextEditingController();
  final myControllerTelephone = TextEditingController();
  final myControllerLogin = TextEditingController();
  final myControllermotdepasse = TextEditingController();
  final myControllerDernieremiseajour = TextEditingController();
  final myControllerVersion = TextEditingController();


  @override
  void initState(){
    super.initState();
    appelAPIprofil();

  }

  @override
  void dispose() {

    myControllerCommune.dispose();
     myControllerArrondissement.dispose();
    myControllerQuatier.dispose();
    myControllerTelephone.dispose();
    myControllerLogin.dispose();
    myControllermotdepasse.dispose();
    myControllerDernieremiseajour.dispose();
    myControllerVersion.dispose();

  }

  Widget build(BuildContext context) {    super.dispose();

  // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title:  new CustomText('Profil'),
      ),
      body: SingleChildScrollView(
        child : new Center(
            child: new Card(
              margin: EdgeInsets.only(top: 25.0,bottom : 20.0),
                elevation: 15,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    new Container(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Container(height: 20,),

                          new Text('TOWANOU Martine'),

                          new Text('Technicien'),

                          new DefaultTabController(length: 2,
                              initialIndex: 0,
                              child:new Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  new Container(
                                    child:  new TabBar(
                                        labelColor: Colors.black,
                                        unselectedLabelColor: Colors.black,
                                        tabs:[
                                          Tab( text: 'Informations Personnelles'),
                                          Tab(text: 'Informations Systeme')
                                        ]
                                    ),
                                  ),
                                  new Container(
                                    height: 400,
                                    decoration: BoxDecoration(
                                        border: Border(top: BorderSide(color: Colors.grey,width: 0.5))
                                    ),

                                    child: TabBarView(
                                        children: <Widget>[
                                          new Container(
                                            child: Center(
                                              child: Column(
                                                children:<Widget> [
                                                  new Container(height: 20,),
                                                  new Row(
                                                    children: <Widget>[
                                                      new Text('Commune :'),
                                                      new Container(width: 70,),
                                                      new Text('ZE')
                                                    ],
                                                  ),
                                                  new Container(height: 20,),
                                                  new Row(
                                                    children: <Widget>[
                                                      new Text('Arrondissement :'),
                                                      new Container(width: 35,),
                                                      new Text('ADJAN')
                                                    ],
                                                  ),
                                                  new Container(height: 20,),
                                                  new Row(
                                                    children: <Widget>[
                                                      new Text('Quatier/Village :'),
                                                      new Container(width: 35,),
                                                      new Text('ADJAN')
                                                    ],

                                                  ),
                                                  new Container(height: 20,),
                                                  new Row(
                                                    children: <Widget>[
                                                      new Text('N° de Telephone :'),
                                                      new Container(width: 35,),
                                                      new Text('+229 96 02 03 50 ')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          new Container(
                                            child: Center(
                                              child: Column(
                                                children:<Widget> [
                                                  new Container(height: 20,),
                                                  new Row(
                                                    children: <Widget>[
                                                      new Text('Login :'),
                                                      new Container(width: 25,),
                                                      new Text(data.email),
                                                    ],
                                                  ),
                                                  new Container(height: 20,),
                                                  new Row(
                                                    children: <Widget>[
                                                      new Text('Mot de  passe :'),
                                                      new Container(width: 25,),
                                                      new Text('********')
                                                    ],
                                                  ),
                                                  new Container(height: 20,),
                                                  new Row(
                                                    children: <Widget>[
                                                      new Text('Dernière mise a jour :'),
                                                      new Container(width: 25,),
                                                      new Text('2020-12-08')
                                                    ],
                                                  ),
                                                  new Container(height: 20,),
                                                  new Row(
                                                    children: <Widget>[
                                                      new Text('Version application'),
                                                      new Container(width: 25,),
                                                      new Text('2.0')
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )

                                        ]
                                    ),
                                  )
                                ],

                              )

                          )

                        ],
                      ),
                    )
                  ],
                )
            )

        ),
      )
    );
  }

  void appelAPIprofil() async {
    List<String> arguments;


    final urlApi = "http://51.38.177.36:8787/shared-service/api/users/by-login/${data.email}";

      var token = data.token;

    final response = await http.get(urlApi, headers: {
     HttpHeaders.authorizationHeader: "Bearer $token"
    } );
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      data.currentusers = Users.fromJson(jsonResponse);
      print(data.currentusers);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

  }



}