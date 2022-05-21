import 'dart:async';
import 'package:flutter/material.dart';
import 'package:user_management/models/model_user.dart';
import 'package:user_management/models/user_info.dart';
import 'package:user_management/services/service_user.dart';
import 'package:user_management/components/user_details.dart';
import 'package:user_management/main.dart';

// Create a Form widget.
class ManageUser extends StatefulWidget {
  final UserInfo userInfo;
  const ManageUser({Key? key, required this.userInfo})
      : super(key: key);

  @override
  ManageUserState createState() {
    return ManageUserState();
  }
}

class ManageUserState extends State<ManageUser> {
  final _formKey = GlobalKey<FormState>();
  final displayNameCtr = TextEditingController();
  final loginNameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  String? selectedValue;
  String? displayName;
  String? loginName;
  String? email;
  late Future<User> _responseData;
  late bool success;
  bool? isAddUser = false;
  bool? isEditUser = false;
  bool? isDeleteUser = false;
  late UserInfo _userInfo;

  @override
  initState() {
    super.initState();
    _userInfo = widget.userInfo;
    isAddUser = _userInfo.isAddUser;
    isEditUser = _userInfo.isEditUser;
    isDeleteUser = _userInfo.isDeleteUser;

    if(isEditUser == true || isDeleteUser == true){
      displayNameCtr.text = _userInfo.displayName!;
      loginNameCtr.text = _userInfo.loginName!;
      emailCtr.text = _userInfo.email!;
      selectedValue = _userInfo.userRole!;
    }
  }

  @override
  dispose() {
    super.dispose();
    displayNameCtr.dispose();
    loginNameCtr.dispose();
    emailCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getUserAction(isAddUser!, isEditUser!, isDeleteUser!),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            onAddUser(),
          ],
        ),
        const SizedBox(
          width: 50,
          height: 20,
        ),
        getCurrentWidget(isAddUser!, isEditUser!, isDeleteUser!),
      ],
    );
  }

  Widget onAddUser() => ElevatedButton.icon(
    onPressed: isAddUser! || isEditUser! || isDeleteUser!
        ? null
        : () {
      setState(() {
        isAddUser = true;
        isEditUser = false;
        isDeleteUser = false;
      });
    },
    icon: const Icon(Icons.add),
    label: const Text("Add New"),
  );

  String getUserAction(bool add, bool edit, bool delete) {
    String res;
    if (add == true) {
      res = 'Add User';
    } else if (edit == true) {
      res = 'Edit User';
    }  else if (delete == true) {
      res = 'Delete User';
    } else {
      res = 'Manage User';
    }
    return res;
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("Administrator"), value: "Administrator"),
      const DropdownMenuItem(child: Text("Developer"), value: "Developer"),
      const DropdownMenuItem(child: Text("Manager"), value: "Manager"),
      const DropdownMenuItem(child: Text("System"), value: "System"),
      const DropdownMenuItem(child: Text("User"), value: "User"),
      const DropdownMenuItem(child: Text("Clerk"), value: "Clerk"),
    ];
    return menuItems;
  }

  Widget getCurrentWidget(bool isAddUser, bool isEditUser, bool isDeleteUser) {
    if (isAddUser == true || isEditUser == true || isDeleteUser == true) {
      return _createUserForm(isAddUser, isEditUser, isDeleteUser);
    } else {
      return UserDetails(userInfo: _userInfo,);
    }
  }

  Form _createUserForm(bool isAddUser, bool isEditUser, bool isDeleteUser) {
    // Build a Form widget using the _formKey created above.
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            // The validator receives the text that the user has entered.
            controller: displayNameCtr,
            readOnly: isDeleteUser,
            decoration: const InputDecoration(
              label: Text('Display Name: '),
              hintText: 'Enter Display Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Display name can not be empty';
              }
             displayName = value;
              return null;
            },
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            controller: loginNameCtr,
            readOnly: isDeleteUser,
            decoration: const InputDecoration(
              label: Text('Login Name: '),
              hintText: 'Enter Login Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Login name can not be empty';
              }
              loginName = value;
              return null;
            },
          ),
          TextFormField(
            // The validator receives the text that the user has entered.
            controller: emailCtr,
            readOnly: isDeleteUser,
            decoration: const InputDecoration(
              label: Text('Email: '),
              hintText: 'Enter Email',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email can not be empty';
              }
              email = value;
              return null;
            },
          ),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                label: Text('User Role: '),
                hintText: 'Select Role',
              ),
              validator: (value) => value == null ? "Select a role" : null,
              value: selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: dropdownItems),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      var data = {
                        "display_name": displayName!,
                        "username": loginName!,
                        "email": email!,
                        "user_role": selectedValue!
                      };
                      setState(() {
                        if(isEditUser == true) {
                          _responseData = editUser(data);
                          isEditUser = false;
                        }
                        if(isAddUser == true) {
                          _responseData = addUser(data);
                          isAddUser = false;
                        }
                        if(isDeleteUser == true) {
                          _responseData = deleteUser(data);
                          isDeleteUser = false;
                        }
                      });
                      cleanup();
                      _responseData.then((user) => {
                            if (user.success == true)
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(user.message!),
                                    backgroundColor: Colors.green,
                                    duration: const Duration(
                                        seconds: 10, milliseconds: 500),
                                  ),
                                )
                              }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(user.message!),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(
                                        seconds: 10, milliseconds: 500),
                                  ),
                                )
                              }
                          });
                    }
                  },
                  icon: Icon(getIcon(isAddUser, isEditUser,isDeleteUser)),
                  label: Text(getButtonName(isAddUser, isEditUser, isDeleteUser)),
                ),
              ),
              const SizedBox(
                width: 50,
                height: 50,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyApp(userInfo: UserInfo.fromJson(_userInfo),)),
                    );
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text("Cancel"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void cleanup(){
    displayNameCtr.clear();
    loginNameCtr.clear();
    emailCtr.clear();
  }

  String getButtonName(bool add, bool edit, bool delete) {
    String btnName;
    if (add == true) {
      btnName = 'Save';
    } else if (edit == true) {
      btnName = 'Edit';
    } else if (delete == true) {
      btnName = 'Delete';
    }else {
      btnName = 'Submit';
    }
    return btnName;
  }

  IconData getIcon(bool add, bool edit, bool delete) {
    IconData _icon;
    if (add == true) {
      _icon = Icons.save;
    } else if (edit == true) {
      _icon = Icons.edit;
    } else if (delete == true) {
      _icon = Icons.delete;
    } else {
      _icon = Icons.add;
    }
    return _icon;
  }
}
