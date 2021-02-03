import 'package:flutter/material.dart';

class Users{

  var address;
  var iconUrl;
  String birthDate;
  String birthPlace;
  String dialects ='';
  String firstName ='';
  String gender;
  String id;
  String language ='';
  String lastName='';
  String  login ='';
  String nationality;
  String lastModifiedDate='';
   String roles;
  var  customers;

Users();



  static List<Users> listFromJson(List<dynamic> json) {
    return json == null ? [] : json.map((e) => Users.fromJson(e)).toList();
  }

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    this.address=json ['address'];
    this.iconUrl =json['iconUrl'];
    this.birthDate = json['birthDate'] ;
    this.birthPlace =json['birthPlace'] ;
    this.dialects = json['dialects'];
    this.firstName = json['firstName'];
    this.gender = json['gender'];

    this.id = json['id'];
    this.language = json['language'];
    this.lastName = json['lastName'];
    this.login = json['login'];
    this.nationality = json['nationality'];
    this.lastModifiedDate= json['lastModifiedDate'];
    this.roles= json['roles'];
    this.customers = json['customers'];
  }

@override
  String toString() {

    return 'Users{ address:$address,'
        'iconUrl: $iconUrl,'
        'birthDate:$birthDate,'
        'birthPlace:$birthPlace,'
        'dialects:$dialects,'
        'firstName:$firstName,'
        'gender:$gender,'
        'id:$id,'
        'language:$language,'
        'lastName:$lastName,'
        'login:$login,'
        'nationality:$nationality,'
        'lastModifiedDate=$lastModifiedDate,'
        'roles=$roles,'
        'customers:$customers}';
  }


}