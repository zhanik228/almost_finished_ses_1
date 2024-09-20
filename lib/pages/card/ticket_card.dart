import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wsk_china_2024/models/event_model.dart';
import 'package:wsk_china_2024/models/seat_model.dart';

class TicketCard extends StatelessWidget {
  final EventModel? event;
  final List<Seat> eventSeats;
  final eventKey;
  const TicketCard({required this.event, required this.eventKey, required this.eventSeats, super.key});

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
    return Scaffold(
      // body: ListTile( 
      //         leading: FutureBuilder(
      //           future: _getImg(eventKey),
      //           builder: (context, snapshot) {
      //             if (snapshot.connectionState == ConnectionState.done) {
      //               return Image.asset('${snapshot.data}', fit: BoxFit.cover, width: 300, height: 500,);
      //             }
      //             return CircularProgressIndicator();
      //           },
      //         ),
      //         title: Text(event?.name ?? 'Unknown Event'),
      //         subtitle: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text('Rows  Seat'),
      //             Expanded(
      //               child: ListView.builder(
      //                 itemCount: eventSeats.length,
      //                 itemBuilder:(context, index) {
      //                   return Text('${eventSeats[index].row}  ${eventSeats[index].seat}');
      //                 },
      //               ),
      //             )
      //           ],
      //         ), // Display seats if needed
      //       )
      body: Container(
        width: 500,
        child: Column(
          children: [
            FutureBuilder(
              future: _getImg(eventKey), 
              builder:(context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Image.asset(snapshot.data, height: 200, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,);
                }
                return CircularProgressIndicator();
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 4,
              color: Color(hexColor(event!.color)),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Text(event!.name),
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        Text(month(event!.date.month) + ' ' + event!.date.month.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.gps_fixed),
                        Text(event!.location),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text('Rows'),
                          Spacer(),
                          Text('Seat'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: eventSeats.length,
                        itemBuilder:(context, index) {
                          return Row(
                            children: [
                              Expanded(child: Text('${eventSeats[index].row}')),
                              Spacer(),
                              Expanded(child: Text('${eventSeats[index].seat}'))
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}