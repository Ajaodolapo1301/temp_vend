import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../authentication/viewModel/loginState.dart';

class TawkPage extends StatefulWidget {
  final String? email;
  final String? fullName;
  TawkPage({this.email, this.fullName});
  @override
  _TawkPageState createState() => _TawkPageState();
}

class _TawkPageState extends State<TawkPage> {
  LoginState? loginState;

  @override
  Widget build(BuildContext context) {
    loginState = Provider.of<LoginState>(context);
    return Scaffold(
      appBar: const CustomAppBar(label: "Contact Support", showAction: true),
      body: Tawk(
        directChatLink:
            'https://tawk.to/chat/61917c556bb0760a49429615/1fkg4rcjc',
        visitor: TawkVisitor(name: widget.fullName, email: widget.email),
        onLoad: () {
          // print('Hello Tawk!');
        },
        onLinkTap: (String url) {
          // print(url);
        },
        placeholder: const Center(child: CupertinoActivityIndicator()
            // Text(
            //   'Loading...',
            //   style: TextStyle(fontSize: 20),
            // ),
            ),
      ),
    );
  }
}
