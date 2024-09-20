import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:wsk_china_2024/models/event_data_model.dart';
import 'package:wsk_china_2024/models/event_model.dart';
import 'package:wsk_china_2024/pages/card/card.dart';
import 'package:wsk_china_2024/pages/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  late EventsData eventsData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parseJson();
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

  Future<String> _getImagePath(String key) async {
    String jpegPath = 'assets/session_1/event_images/$key.jpeg';
    String pngPath = 'assets/session_1/event_images/$key.png';

    try {
      await rootBundle.load(jpegPath);
      return jpegPath;
    } catch (_) {
      return pngPath;
    }
  }

  int hexColor(String color) {
    String newColor = '0xff' + color;
    newColor = newColor.replaceAll('#', '');
    int finalColor = int.parse(newColor);
    return finalColor;
  }

  String month(int month_number) {
    switch (month_number) {
      case 1: return 'Jan';
      case 2: return 'Feb';
      case 3: return 'Mar';
      case 4: return 'Apr';
      case 5: return 'May';
      case 6: return 'Jun';
      case 7: return 'Jul';
      case 8: return 'Aug';
    }

    return 'not found';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 70,
              child: SearchEvent()
            ),
            Row(
              children: [
                eventsData != null
                  ? Text('${eventsData.events.length} events found')
                  : Text('Events not found'),
                Spacer(),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.blue)
                  ),
                  child: TabBar(
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          height: 35,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(30),
                          //   border: Border.all(color: Colors.blue, width: 1)
                          // ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.grid_4x4),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 35,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(30),
                          //   border: Border.all(color: Colors.blue, width: 1)
                          // ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.calendar_month),
                          ),
                        ),
                      )
                    ]
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: eventsData == null 
                      ? Center(child: CircularProgressIndicator(),)
                      : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5
                        ),
                        itemCount: eventsData.events.length,
                        itemBuilder:(context, index) {
                          String key = eventsData.events.keys.elementAt(index);
                          EventModel event = eventsData.events[key]!;
                          return FutureBuilder<String>(
                            future: _getImagePath(key),
                            builder:(context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/eventDetails', arguments: [event, key]);
                                  },
                                  child: EventCard(event: event, image: key, title: month(event.date.month) + ' ' + event.date.day.toString(), subtitle: event.name,),
                                );
                              } else {
                                return Center(child: CircularProgressIndicator(),);
                              }
                            },
                          );
                        },
                      ),
                  ),
                  Center(
                    child: Text('a'),
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}