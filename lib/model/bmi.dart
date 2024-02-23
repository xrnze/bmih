import 'package:intl/intl.dart';

const Map<int, String> Gender = {
  0: "unknown",
  1: "Laki-laki",
  2: "Perempuan",
};

class Calculation {
  String id = "";
  int height = 0;
  int weight = 0;
  int gender = 0;
  int date = 0;
  double result = 0;

  Calculation(
      {required this.id,
      required this.height,
      required this.weight,
      required this.gender,
      required this.date,
      required this.result});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'height': height,
      'weight': weight,
      'gender': gender,
      'date': date,
      'result': result
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    print(map['date'].runtimeType);
    return Calculation(
        id: map['id'],
        height: map['height'],
        weight: map['weight'],
        gender: map['gender'],
        date: map["date"],
        result: map["result"]);
  }

  @override
  String toString() {
    return 'Calculation (id: $id, date: $date, height: $height, weight: $weight, color: ${Gender[gender]})';
  }
}
