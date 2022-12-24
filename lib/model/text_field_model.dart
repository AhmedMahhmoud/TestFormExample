class TextFieldModel {
  final String label;
  final bool requiredField;
  String? value;

  TextFieldModel(
      {required this.label, required this.requiredField, this.value});
  factory TextFieldModel.fromMap(json) {
    return TextFieldModel(
        requiredField: json['required'],
        label: json['label'],
        value: json['value']);
  }
}
