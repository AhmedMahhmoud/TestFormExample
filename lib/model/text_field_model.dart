class TextFieldModel {
  final String label;
  final bool required;
  final String? value;

  TextFieldModel({required this.label, required this.required, this.value});
  factory TextFieldModel.fromMap(Map<String, dynamic> json) {
    return TextFieldModel(
        required: json['required'], label: json['label'], value: json['value']);
  }
}
