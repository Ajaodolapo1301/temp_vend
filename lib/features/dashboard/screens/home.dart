import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/textStyleConstants.dart';
import '../../../core/utils/styles/color_utils.dart';
import '../../chat/Pages/chat_page.dart';
import '../../myOrder/page/myOrder.dart';
import '../../profile/pages/profile_page.dart';
import '../../wallet/pages/wallet.dart';
import 'dashboardPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("pushhshs${PushNotificationsManager.deviceToken}");
    List<Widget> children = [
      DashBoardPage(
        onOrderHistory: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
      MyOrder(),
      WalletPage(),
      Messages(),
      ProfilePage()
    ];
    return Scaffold(
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: complementary,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "${imagePath}dashboard/${_currentIndex == 0 ? "home.svg" : "homeBlue.svg"}",
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "${imagePath}dashboard/${_currentIndex == 1 ? "orderBlue.svg" : "order.svg"}",
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "${imagePath}dashboard/${_currentIndex == 2 ? "walletSelect.svg" : "wallet.svg"}"),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                "${imagePath}dashboard/${_currentIndex == 3 ? "wallettBlue.svg" : "chat.svg"}"),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "${imagePath}dashboard/${_currentIndex == 4 ? "personBlue.svg" : "person.svg"}",
              color: _currentIndex == 4 ? primaryColor : null,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
