import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_management/models/user_info.dart';
import 'controllers/MenuController.dart';
import 'components/home.dart';

void main() {
  Map<String, dynamic> _userInfo;
  _userInfo = {
    "displayName": null,
    "loginName": null,
    "userRole": null,
    "email":  null,
    "isAddUser": false,
    "isEditUser": false,
    "isDeleteUser": false,
  };
  runApp(MyApp(userInfo: UserInfo.fromJson(_userInfo)));
}

class MyApp extends StatelessWidget {
  final UserInfo userInfo;
  const MyApp({Key? key, required this.userInfo}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Management Dashboard',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: Home(userInfo:userInfo),
      ),
    );
  }
}
