import 'package:flutter/material.dart';
import 'package:wsk_china_2024/models/event_model.dart';
import 'package:wsk_china_2024/pages/events/buy_ticket.dart';
import 'package:wsk_china_2024/pages/events/choose_seat.dart';
import 'package:wsk_china_2024/pages/events/event_details.dart';
import 'package:wsk_china_2024/pages/events/home_page.dart';
import 'package:wsk_china_2024/pages/events/ticket_list.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

  GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();
class _HomeNavState extends State<HomeNav> {

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: homeNavigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder:(context) {

          if (settings.name == '/eventSeats') {
            final List<dynamic> args = settings.arguments as List<dynamic>;
            final EventModel event = args[0];
            final String key = args[1];
            return ChooseSeat(event: event, image: key);
          }

          if (settings.name == '/ticket') {
            final List<dynamic> args = settings.arguments as List<dynamic>;
            final EventModel event = args[0];
            final String key = args[1];
            return BuyTicket(event: event, image: key,);
          }

          if (settings.name == '/ticketList') {
            return TicketList();
          }

          if (settings.name == '/eventDetails') {
            final List<dynamic> args = settings.arguments as List<dynamic>;
            final EventModel event = args[0];
            final String key = args[1];
            return EventDetails(event: event, image: key);
          }
          return HomePage();
        },);
      },
    );
  }
}