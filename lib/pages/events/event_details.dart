import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wsk_china_2024/models/event_model.dart';
import 'package:wsk_china_2024/pages/card/card.dart';

class EventDetails extends StatefulWidget {
  final EventModel event;
  final String image;
  const EventDetails({required this.event, required this.image, super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

  Future<String> _getImagePath(name) async {
    String jpegPath = 'assets/session_1/event_images/$name.jpeg';
    String pngPath = 'assets/session_1/event_images/$name.png';

    try {
      await rootBundle.load(jpegPath);
      return jpegPath;
    } catch(_) {
      return pngPath;
    }
  }

  int hexColor(String color) {
    String newColor = '0xff' + color;
    newColor = newColor.replaceAll('#', '');
    final finalColor = int.parse(newColor);
    return finalColor;
  }

  @override
  Widget build(BuildContext context) {
    // final EventModel args = ModalRoute.of(context)!.settings.arguments as EventModel;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(hexColor(widget.event.color)),
        onPressed: () {
          Navigator.pushNamed(context, '/eventSeats', arguments: [widget.event, widget.image]);
        },
        child: Container(
          child: Text('Buy Ticket', style: TextStyle(color: Colors.white),),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.transparent,
        // elevation: 0,
        flexibleSpace: EventCard(event: widget.event, image: widget.image, title: '', subtitle: '',),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FutureBuilder(
          //   future: _getImagePath(widget.image), 
          //   builder:  (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       return Center(
          //         child: 
          //           Image.asset(
          //             snapshot.data!, 
          //             width: MediaQuery.of(context).size.width, 
          //             height: 300,
          //             fit: BoxFit.cover,
          //           )
          //         );
          //     } else {
          //       return CircularProgressIndicator();
          //     }
          //   },
          // ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.event.name}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_month),
                              Text('${widget.event.date}')
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.gps_fixed),
                              Text('${widget.event.location}')
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  child: Column(
                    children: [
                      Text(
                        '${widget.event.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Color(hexColor(widget.event.color))
                        ),
                      ),
                      Text('${7 * 16 - widget.event.bookedSeats.length} seats available')
                    ],
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('About Event', style: TextStyle(fontWeight: FontWeight.bold),),
                Text('${widget.event.description}')
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}