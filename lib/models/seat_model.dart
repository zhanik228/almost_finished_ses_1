class Seat {
  final int row;
  final int seat;

  Seat({required this.row, required this.seat});

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      row: json['row'],
      seat: json['seat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'row': row,
      'seat': seat,
    };
  }
}