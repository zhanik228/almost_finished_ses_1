import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wsk_china_2024/models/event_model.dart';

class EventCard extends StatefulWidget {
  final String image;
  final EventModel event;
  final String title;
  final String subtitle;
  const EventCard({required this.image, required this.event, required this.title, required this.subtitle, super.key});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {

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

  int hexColor(String color) {
    String newColor = '0xff' + color;
    newColor = newColor.replaceAll('#', '');
    int finalColor = int.parse(newColor);
    return finalColor;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getImg(widget.image),
        builder: (context, snapshot) {
          return Column(
            children: [
              Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(snapshot.data),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                  children: [
                    Spacer(),
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: Color(hexColor(widget.event.color)),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: ListTile(
                            textColor: Colors.white,
                            title: Text(widget.title),
                            subtitle: Text(widget.subtitle),
                          ),
                        ),
                      ),
                    ),
                  ]
                )
                ),
                // Spacer(),
            ]
          );
        },
      );
  }
}