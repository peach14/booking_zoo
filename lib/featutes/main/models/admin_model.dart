import 'dart:convert';

AdminModel adMinFromJson({required String str}) =>
    AdminModel.fromJson(json.decode(str));

String adMinToJson(AdminModel data) => jsonEncode(data.toJson());

class AdminModel {
  String useName;
  List<Round> round;
  List<Room> room;
  List<Animal> animal;

  AdminModel({
    required this.useName,
    required this.round,
    required this.room,
    required this.animal,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        useName: json["use_name"],
        round: List<Round>.from(json["round"].map((x) => Round.fromJson(x))),
        room: List<Room>.from(json["room"].map((x) => Room.fromJson(x))),
        animal:
            List<Animal>.from(json["animal"].map((x) => Animal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "use_name": useName,
        "round": List<dynamic>.from(round.map((x) => x.toJson())),
        "room": List<dynamic>.from(room.map((x) => x.toJson())),
        "animal": List<dynamic>.from(animal.map((x) => x.toJson())),
      };
}

class Animal {
  String type;
  String imagePath;
  String gene;
  String timeShow;
  String nameAnimal;

  Animal({
    required this.type,
    required this.imagePath,
    required this.gene,
    required this.timeShow,
    required this.nameAnimal,
  });

  factory Animal.fromJson(Map<String, dynamic> json) => Animal(
        type: json["type"],
        imagePath: json["image_path"],
        gene: json["gene"],
        timeShow: json["time_show"],
        nameAnimal: json["name_animal"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "image_path": imagePath,
        "gene": gene,
        "time_show": timeShow,
        "name_animal": nameAnimal,
      };
}

class Room {
  String nameRoom;
  List<Seat> seat;
  String price;
  List<dynamic> gane;

  Room({
    required this.nameRoom,
    required this.seat,
    required this.price,
    required this.gane,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        nameRoom: json["name_room"],
        seat: List<Seat>.from(json["seat"].map((x) => Seat.fromJson(x))),
        price: json["price"],
        gane: List<dynamic>.from(json["gane"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name_room": nameRoom,
        "seat": List<dynamic>.from(seat.map((x) => x.toJson())),
        "price": price,
        "gane": List<dynamic>.from(gane.map((x) => x)),
      };
}

class Seat {
  String value;
  bool sttus;

  Seat({
    required this.value,
    required this.sttus,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        value: json["value"],
        sttus: json["sttus"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "sttus": sttus,
      };
}

class Round {
  List<One> one;

  Round({
    required this.one,
  });

  factory Round.fromJson(Map<String, dynamic> json) => Round(
        one: List<One>.from(json["one"].map((x) => One.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "one": List<dynamic>.from(one.map((x) => x.toJson())),
      };
}

class One {
  String roomRound;
  String animalRound;
  String time;

  One({
    required this.roomRound,
    required this.animalRound,
    required this.time,
  });

  factory One.fromJson(Map<String, dynamic> json) => One(
        roomRound: json["room_round"],
        animalRound: json["animal_round"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "room_round": roomRound,
        "animal_round": animalRound,
        "time": time,
      };
}
