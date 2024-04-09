import 'dart:convert';

List<CustomerModel> userInformationFromJson({required List<String> str}) =>
    List<CustomerModel>.from(
        str.map((e) => CustomerModel.fromJson(json.decode(e))).toList());

List<String> userInformationToJson(List<CustomerModel> data) =>
    List<String>.from(data.map((x) => jsonEncode(x.toJson())));

class CustomerModel {
  String username;
  List<Datum> data;

  CustomerModel({
    required this.username,
    required this.data,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        username: json["username"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  List<dynamic> booking;
  bool paid;

  Datum({
    required this.booking,
    required this.paid,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        booking: List<dynamic>.from(json["booking"].map((x) => x)),
        paid: json["paid"],
      );

  Map<String, dynamic> toJson() => {
        "booking": List<dynamic>.from(booking.map((x) => x)),
        "paid": paid,
      };
}
