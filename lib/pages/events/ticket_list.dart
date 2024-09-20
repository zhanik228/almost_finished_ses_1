import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wsk_china_2024/models/event_data_model.dart';
import 'package:wsk_china_2024/pages/card/ticket_card.dart';

class TicketList extends StatefulWidget {
  const TicketList({super.key});

  @override
  State<TicketList> createState() => _TicketListState();
}

class _TicketListState extends State<TicketList> {

    late EventsData eventsData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseJson();
  }

  Future _getImg(String name) async {
    String jpegPath = 'assets/session_1/event_images/${name}.jpeg';
    String pngPath = 'assets/session_1/event_images/${name}.png';

    try {
      await rootBundle.load(jpegPath);
      return jpegPath;
    } catch (_) {
      return pngPath;
    }
  }

  // Future<bool> _onBackButtonPressed() {
    
  // }

  parseJson() async {
    var jsondata = await rootBundle.loadString('assets/session_1/Data.json');
    var data = json.decode(jsondata) as Map<String, dynamic>;
    setState(() {
      eventsData = EventsData.fromJson(data);
      eventsData.events = Map.fromEntries(
        eventsData.events.entries.toList()
        ..sort((a, b) => a.value.date.compareTo(b.value.date))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Material(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.redAccent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.redAccent
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('UPCOMING'),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('PAST'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: Text('Upcoming'),
                  ),
                  Center(
                    child: CarouselSlider(
                      items: eventsData.myTickets.map((ticket) {
                        final eventKey = ticket.eventId;
                        final eventSeats = ticket.seats;
                        final event = eventsData.events[eventKey];
                        
                        return TicketCard(event: event, eventKey: eventKey, eventSeats: eventSeats);
                      }).toList(),
                      options: CarouselOptions(
                        height: 400.0,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                      ),
                    ),
                  ),
                ]
              ),
            )
          ],
        ),
      )
    );
  }
}