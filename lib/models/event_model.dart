import 'package:wsk_china_2024/models/seat_model.dart';

class EventModel {
  // final String key;
  final String name;
  final DateTime date;
  final String location;
  final String color;
  final String? price;
  final String description;
  final List<Seat> bookedSeats;

  EventModel({
    // required this.key,
    required this.name,
    required this.date,
    required this.location,
    required this.color,
    required this.price,
    required this.description,
    required this.bookedSeats,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    var seatsFromJson = json['bookedSeats'] as List;
    List<Seat> seatList = seatsFromJson.map((i) => Seat.fromJson(i)).toList();

    return EventModel(
      // key: json['key'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      color: json['color'],
      price: json['price'],
      description: json['description'],
      bookedSeats: seatList
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toIso8601String(),
      'location': location,
      'color': color,
      'price': price,
      'description': description,
      'bookedSeats': bookedSeats.map((seat) => seat.toJson()).toList(),
    };
  }
}