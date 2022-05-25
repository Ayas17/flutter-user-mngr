import 'dart:async';
import 'package:flutter/material.dart';
import 'package:user_management/main.dart';
import 'package:user_management/models/model_user.dart';
import 'package:user_management/models/user_info.dart';
import 'package:user_management/services/service_user.dart';
import 'package:user_management/constants.dart';

class UserDetails extends StatefulWidget {
  final UserInfo userInfo;
  const UserDetails({Key? key, required this.userInfo}) : super(key: key);

  @override
  createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late Future<List<User>> _users;
  late String? username;
  late UserInfo _userInfo;

  @override
  initState() {
    super.initState();
    _userInfo = widget.userInfo;
    username = _userInfo.loginName;
    if (username != null) {
      _users = fetchUser(username!);
    } else {
      _users = fetchUsers();
    }
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<User> data = snapshot.data!;
            return buildDataTable(data);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  buildDataTable(List<User> data) {
    return Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          //color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: buildSingleChildScrollView(data),
            ),
          ],
        ));
  }

  Widget buildSingleChildScrollView(List<User> data) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: getDataTable(data)
      );

  getDataTable(List<User> data) {
    final columns = ['Display Name', 'User Role', 'Login Name', 'Email', 'Action'];
    return DataTable(
      columnSpacing: defaultPadding,
      columns: getColumns(columns),
      rows: getDataRows(data),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
    label: Text(column,style: const TextStyle(fontStyle: FontStyle.normal)),
  ))
      .toList();

  List<DataRow> getDataRows(List<User> data) {
    if(data.isNotEmpty){
      return data
          .map<DataRow>(
            (user) => DataRow(
                cells: [
          DataCell(Text(user.displayName!)),
          DataCell(Text(user.userRole!)),
          DataCell(Text(user.loginName!)),
          DataCell(Text(user.email!)),
          DataCell(
            Row(children: <Widget>[
              onEditUser(user),
              const SizedBox(
                width: 20,
                height: 20,
              ),
              onDeleteUser(user),
            ]),
          )
        ]),
      ).toList();
    }else{
      return [
        const DataRow(cells: [
          DataCell(Text('')),
          DataCell(Text('')),
          DataCell(Text('No Data Found!')),
          DataCell(Text('')),
          DataCell(Text('')),
        ]),
      ];
    }
  }

  Widget onEditUser(User user) => ElevatedButton.icon(
    onPressed: () {
      setState(() {
        Map<String, dynamic> _userInfo;
        _userInfo = {
          "displayName": user.displayName!,
          "loginName": user.loginName!,
          "userRole": user.userRole!,
          "email": user.email!,
          "isAddUser": false,
          "isEditUser": true,
          "isDeleteUser": false,
        };
        print("User details EDIT page =====" + '$_userInfo');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyApp(userInfo: UserInfo.fromJson(_userInfo))),
        );
      });
    },
    icon: const Icon(Icons.edit),
    label: const Text(""),
  );

  Widget onDeleteUser(User user) => ElevatedButton.icon(
    onPressed: () {
      setState(() {
        Map<String, dynamic> _userInfo;
        _userInfo = {
          "displayName": user.displayName!,
          "loginName": user.loginName!,
          "userRole": user.userRole!,
          "email": user.email!,
          "isAddUser": false,
          "isEditUser": false,
          "isDeleteUser": true,
        };
        print("User details  DELETE page =====" + '$_userInfo');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyApp(userInfo: UserInfo.fromJson(_userInfo))),
        );
      });
    },
    style: ElevatedButton.styleFrom(
      primary: Colors.red,
    ),
    icon: const Icon(Icons.delete),
    label: const Text(""),
  );
}
