import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_management/models/model_user.dart';

Future<User> addUser(var requestData) async {
  const String url = 'http://localhost:3050/service/users';
  Map<String, Object> responseData;
  try {
    print('Calling addUser()');
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      responseData = {
        "Success": true,
        "StatusCode": response.statusCode,
        "Message": response.body
      };
    } else {
      responseData = {
        "Success": false,
        "StatusCode": response.statusCode,
        "Message": response.body
      };
    }
  } on Exception catch (e) {
    print('ErrorMessage: +$e');
    responseData = {
      "Success": false,
      "StatusCode": 500,
      "Message": 'Error occurred while trying to call : ' + url
    };
  }
  return User.fromJson(responseData);
}

Future<User> deleteUser(var requestData) async {
  String userName = "";
  String url = "";
  Map<String, Object> responseData;
  try {
    print('Calling deleteUser()');
    userName = requestData["username"];
    url = 'http://localhost:3050/service/users/$userName';
    var params = {
      "username": requestData["username"],
    };
    final response = await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      responseData = {
        "Success": true,
        "StatusCode": response.statusCode,
        "Message": response.body
      };
    } else {
      responseData = {
        "Success": false,
        "StatusCode": response.statusCode,
        "Message": response.body
      };
    }
  } on Exception catch (e) {
    print('ErrorMessage: +$e');
    responseData = {
      "Success": false,
      "StatusCode": 500,
      "Message": 'Error occurred while trying to call : ' + url
    };
  }
  return User.fromJson(responseData);
}
Future<User> editUser(var requestData) async {
  String userName = "";
  String url = "";
  Map<String, Object> responseData;
  try {
    print('Calling editUser()');
    userName = requestData["username"];
    url = 'http://localhost:3050/service/users/$userName';
    var params = {
      "username": requestData["username"],
    };
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      responseData = {
        "Success": true,
        "StatusCode": response.statusCode,
        "Message": response.body
      };
    } else {
      responseData = {
        "Success": false,
        "StatusCode": response.statusCode,
        "Message": response.body
      };
    }
  } on Exception catch (e) {
    print('ErrorMessage: +$e');
    responseData = {
      "Success": false,
      "StatusCode": 500,
      "Message": 'Error occurred while trying to call : ' + url
    };
  }
  return User.fromJson(responseData);
}
Future<List<User>> fetchUsers() async {
  List<User> users = [];
  const String url = 'http://localhost:3050/service/users/list';
  try {
    print('Calling fetchUsers()');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      users = list.map((user) => User.fromJson(user)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Unexpected error occurred!');
    }
  } on Exception catch (e) {
    print('Error occurred while fetching users: $e');
    throw Exception('Unexpected error occurred!');
  }
  return users;
}

Future<List<User>> fetchUser(String username) async {
  List<User> users = [];
  String url = 'http://localhost:3050/service/users/$username';
  try {
    print('Calling fetchUser()');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      users = list.map((user) => User.fromJson(user)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Unexpected error occurred!');
    }
  } on Exception catch (e) {
    print('Error occurred while fetching users: $e');
    throw Exception('Unexpected error occurred!');
  }
  return users;
}
