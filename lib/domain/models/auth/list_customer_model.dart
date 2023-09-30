// To parse this JSON data, do
//
//     final listCustomerModel = listCustomerModelFromJson(jsonString);

import 'dart:convert';

ListCustomerModel listCustomerModelFromJson(String str) =>
    ListCustomerModel.fromJson(json.decode(str));

String listCustomerModelToJson(ListCustomerModel data) =>
    json.encode(data.toJson());

class ListCustomerModel {
  final String? odataContext;
  final List<Value>? value;

  ListCustomerModel({
    this.odataContext,
    this.value,
  });

  factory ListCustomerModel.fromJson(Map<String, dynamic> json) =>
      ListCustomerModel(
        odataContext: json["@odata.context"],
        value: json["value"] == null
            ? []
            : List<Value>.from(json["value"]!.map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "@odata.context": odataContext,
        "value": value == null
            ? []
            : List<dynamic>.from(value!.map((x) => x.toJson())),
      };
}

class Value {
  final String? oid;
  final String? photo;
  final DateTime? birthday;
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? email;
  final String? phone;

  Value({
    this.oid,
    this.photo,
    this.birthday,
    this.fullName,
    this.firstName,
    this.lastName,
    this.middleName,
    this.email,
    this.phone,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        oid: json["Oid"],
        photo: json["Photo"],
        birthday:
            json["Birthday"] == null ? null : DateTime.parse(json["Birthday"]),
        fullName: json["FullName"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        middleName: json["MiddleName"],
        email: json["Email"],
        phone: json["Phone"],
      );

  Map<String, dynamic> toJson() => {
        "Oid": oid,
        "Photo": photo,
        "Birthday": birthday?.toIso8601String(),
        "FullName": fullName,
        "FirstName": firstName,
        "LastName": lastName,
        "MiddleName": middleName,
        "Email": email,
        "Phone": phone,
      };
}
