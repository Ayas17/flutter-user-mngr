import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:user_management/main.dart';
import 'package:user_management/models/user_info.dart';
class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Icon(Icons.dashboard),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {

            },
          ),
          DrawerListTile(
            title: "User Management",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyApp(userInfo: UserInfo.fromJson(_userInfo),)),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
       // color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
       // style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
