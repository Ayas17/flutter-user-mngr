import 'package:user_management/controllers/MenuController.dart';
import 'package:user_management/models/user_info.dart';
import 'package:user_management/responsive.dart';
import 'package:user_management/components/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_management/components/side_menu.dart';

class Home extends StatelessWidget {
  final UserInfo userInfo;
  const Home({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                //flex: 2,
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
             Expanded(
              // It takes 5/6 part of the screen
              flex: 4,
              child: Dashboard(userInfo: userInfo,),
            ),
          ],
        ),
      ),
    );
  }
}
