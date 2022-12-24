import 'dart:convert';

class FormDataModel {
  final String label;
  final String dataType;
  String? value;
  List<dynamic>? items;
  bool? isRequired;
  FormDataModel({
    required this.label,
    required this.dataType,
    this.value,
    this.items,
    this.isRequired,
  });

  factory FormDataModel.fromMap(Map<String, dynamic> map) {
    return FormDataModel(
      dataType: map['type'],
      label: map['label'],
      value: map['value'],
      items: map['items'],
      isRequired: map['required'],
    );
  }

  factory FormDataModel.fromJson(String source) =>
      FormDataModel.fromMap(json.decode(source));
}
