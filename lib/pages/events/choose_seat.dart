import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wsk_china_2024/models/event_model.dart';
import 'package:wsk_china_2024/pages/card/card.dart';
import 'package:wsk_china_2024/pages/seating/seating_chart.dart';

class ChooseSeat extends StatefulWidget {
  final EventModel event;
  final String image;
  const ChooseSeat({required this.event, required this.image, super.key});

  @override
  State<ChooseSeat> createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> {

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
    String newColor = color.replaceAll('#', '');
    newColor = '0xff' + newColor;
    int finalColor = int.parse(newColor);
    return finalColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.transparent,
        // elevation: 0,
        flexibleSpace: EventCard(event: widget.event, image: widget.image, title: 'Choose your seats:', subtitle: widget.event.name,),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(hexColor(widget.event.color)),
        child: Text('Select'),
        onPressed: () {
          Navigator.pushNamed(context, '/ticket', arguments: [widget.event, widget.image]);
        },
      ),
      body: Column(
        children: [
          // EventCard(event: widget.event, image: widget.image, title: 'Choose your seats:', subtitle: widget.event.name,),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1)
              ),
              child: Text('Stage')
            ),
          ),
          Expanded(child: SeatingChart(event: widget.event))
        ],
      )
    );
  }
}