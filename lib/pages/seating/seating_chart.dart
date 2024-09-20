import 'package:flutter/material.dart';
import 'package:wsk_china_2024/models/event_model.dart';
import 'package:wsk_china_2024/models/seat_model.dart';

class SeatingChart extends StatefulWidget {
  final EventModel event;
  const SeatingChart({required this.event, super.key});

  @override
  State<SeatingChart> createState() => _SeatingChartState();
}

class _SeatingChartState extends State<SeatingChart> {
  final int rows = 14;

  final int seatsPerRow = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: List.generate(rows, (rowIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  '${rowIndex + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
             ...List.generate(seatsPerRow, (seatIndex) {
                int seatNumber = seatIndex + 1;
                bool isChosen = widget.event.bookedSeats.any(
                  (seat) => seat.row == rowIndex + 1 && seat.seat == seatNumber
                );
                return Padding(
                  padding: EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                      widget.event.bookedSeats.add(new Seat(row: rowIndex + 1, seat: seatNumber));  
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isChosen ? Colors.red : Colors.green,
                        border: Border.all(color: Colors.black)
                      ),
                    ),
                  ),
                );
              }) 
            ]
          );
        })
      ),
    );
  }
}