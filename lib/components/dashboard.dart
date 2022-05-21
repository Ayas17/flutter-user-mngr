import 'package:flutter/material.dart';
import 'package:user_management/constants.dart';
import 'package:user_management/components/header.dart';
import 'package:user_management/components/manage_user.dart';
import 'package:user_management/models/user_info.dart';

class Dashboard extends StatelessWidget {
  final UserInfo userInfo;
  const Dashboard({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(userInfo: userInfo,),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children:  [
                      ManageUser(userInfo: userInfo,),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
