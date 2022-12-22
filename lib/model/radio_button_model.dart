class RadioButtonModel {
  final String label;
  final String value;
  final List<dynamic> items;

  RadioButtonModel(
      {required this.label, required this.value, required this.items});
  factory RadioButtonModel.fromMap(Map<String, dynamic> json) {
    return RadioButtonModel(
        items: json['items'], label: json['label'], value: json['value']);
  }
}
