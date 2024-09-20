import 'package:wsk_china_2024/models/event_model.dart';
import 'package:wsk_china_2024/models/ticket_model.dart';

class EventsData {
  Map<String, EventModel> events;
  final List<Ticket> myTickets;

  EventsData({
    required this.events,
    required this.myTickets,
  });

  factory EventsData.fromJson(Map<String, dynamic> json) {
    var eventsFromJson = json['events'] as Map<String, dynamic>;
    Map<String, EventModel> eventMap = eventsFromJson.map(
      (key, value) => MapEntry(key, EventModel.fromJson(value))
    );

    var ticketsFromJson = json['myTickets'] as List;
    List<Ticket> ticketList = ticketsFromJson.map(
      (ticket) => Ticket.fromJson(ticket)
    ).toList();

    return EventsData(
      events: eventMap,
      myTickets: ticketList
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'events': events.map((key, value) => MapEntry(key, value.toJson())),
      'myTickets': myTickets.map((ticket) => ticket.toJson()).toList(),
    };
  }
}