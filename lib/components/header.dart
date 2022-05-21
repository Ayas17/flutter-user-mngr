import 'package:user_management/controllers/MenuController.dart';
import 'package:user_management/models/user_info.dart';
import 'package:user_management/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:user_management/main.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  final UserInfo userInfo;
  const Header({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(
            child: SearchField(
          userInfo: userInfo,
        )),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        //color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          const Icon(Icons.login),
          if (!Responsive.isMobile(context))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Admin User"),
            ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  final UserInfo userInfo;
  SearchField({Key? key, required this.userInfo}) : super(key: key);
  final loginNameCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: loginNameCtr,
      decoration: InputDecoration(
        hintText: "Search by Login Name",
        //fillColor: secondaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {
            Map<String, dynamic> _userInfo;
            _userInfo = {
              "displayName": null,
              "loginName": loginNameCtr.text,
              "userRole": null,
              "email": null,
              "isAddUser": false,
              "isEditUser": false,
              "isDeleteUser": false,
            };
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyApp(userInfo: UserInfo.fromJson(_userInfo)),
                ));
          },
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              //color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
