import 'dart:convert';

import 'package:first_test/model/radio_button_model.dart';
import 'package:first_test/model/text_field_model.dart';

class FormBuilder {
  final List<TextFieldModel> textFieldsList;
  final List<RadioButtonModel> radioButtonsList;
  FormBuilder({
    required this.textFieldsList,
    required this.radioButtonsList,
  });

  factory FormBuilder.fromMap(Map<String, dynamic> json) {
    return FormBuilder(
      textFieldsList: List<TextFieldModel>.from(
          json['input_text_field']?.map((x) => TextFieldModel.fromMap(x))),
      radioButtonsList: List<RadioButtonModel>.from(
          json['radio_button']?.map((x) => RadioButtonModel.fromMap(x))),
    );
  }

  factory FormBuilder.fromJson(String source) =>
      FormBuilder.fromMap(json.decode(source));
}
