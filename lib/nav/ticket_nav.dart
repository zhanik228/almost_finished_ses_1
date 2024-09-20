import 'package:flutter/material.dart';
import 'package:wsk_china_2024/pages/events/ticket_list.dart';

GlobalKey<NavigatorState> ticketNavKey = GlobalKey<NavigatorState>();

class TicketNav extends StatelessWidget {
  const TicketNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: ticketNavKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder:(context) {
            return TicketList();  
          },
        );
      },
    );
  }
}