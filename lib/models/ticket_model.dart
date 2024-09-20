import 'package:wsk_china_2024/models/seat_model.dart';

class Ticket {
  final String eventId;
  final List<Seat> seats;

  Ticket({
    required this.eventId,
    required this.seats,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    var seatsFromJson = json['seats'] as List;
    List<Seat> seatList = seatsFromJson.map((seat) => Seat.fromJson(seat)).toList();

    return Ticket(
      eventId: json['eventId'],
      seats: seatList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'seats': seats.map((seat) => seat.toJson()).toList(),
    };
  }
}