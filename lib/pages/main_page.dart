import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wsk_china_2024/nav/home_nav.dart';
import 'package:wsk_china_2024/pages/events/home_page.dart';
import 'package:wsk_china_2024/pages/events/ticket_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    homeNavigatorKey
  ];

  Future<bool> _systemBackButtonPressed() async {
    if (_navigatorKeys[_selectedIndex].currentState?.canPop() == true) {
      _navigatorKeys[_selectedIndex].currentState?.pop(_navigatorKeys[_selectedIndex].currentContext);
      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true;
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket),
              label: 'Tickets'
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: IndexedStack(
            index: _selectedIndex,
            children: pages,
          ),
        ),
      ),
    );
  }

  final pages = const [
    HomeNav(),
    TicketList(),
  ];
}