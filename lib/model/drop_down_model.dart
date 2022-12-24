import 'dart:convert';

class DropDownModel {
  String value;
  final List<dynamic> items;
  final String label;
  DropDownModel({
    required this.value,
    required this.items,
    required this.label,
  });

  factory DropDownModel.fromMap(Map<String, dynamic> map) {
    return DropDownModel(
        value: map['value'], items: map['items'], label: map['label']);
  }

  factory DropDownModel.fromJson(String source) =>
      DropDownModel.fromMap(json.decode(source));
}
