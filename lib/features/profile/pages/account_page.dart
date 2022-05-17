import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/function/snaks.dart';
import '../../../core/utils/navigation/navigator.dart';
import '../../../core/utils/sizeConfig/sizeConfig.dart';
import '../../authentication/viewModel/loginState.dart';
import '../widget/buildListTile.dart';
import '../widget/divider.dart';
import 'change_password.dart';
import 'edit_profile.dart';
import 'language.dart';
import 'notification.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  LoginState? loginState;

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of(context);
    return Scaffold(
      // backgroundColor: Color(0xffE5E5E5
      // ),
      // appBar:  kAppBar("Account Settings", onPress: ()=> pop(context), ),

      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 2.4 * SizeConfig.heightMultiplier,
                ),
                Column(
                  children: [
                    buildListTile(
                      title: "Edit Profile",
                      subTitle: "",
                      onTap: () {
                        pushTo(context, const EditPage());
                      },
                    ),
                    divider(),
                    buildListTile(
                      title: "Change Password",
                      subTitle: "",
                      onTap: () {
                        pushTo(context, ChangePassword());
                      },
                    ),
                    divider(),
                    buildListTile(
                      title: "Language",
                      subTitle: "",
                      onTap: () {
                        pushTo(context, Language());
                      },
                    ),
                    divider(),
                    buildListTile(
                      title: "Notification settings",
                      subTitle: "",
                      onTap: () {
                        pushTo(context, NotificationPage()).then((value) {
                          getuser();
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getuser() async {
    var res = await loginState!
        .getUser(token: loginState!.user.token, id: loginState!.user.id);
    res.fold((l) {
      kShowSnackBar(context, l.props.first.toString());
    }, (r) {});
  }
}
