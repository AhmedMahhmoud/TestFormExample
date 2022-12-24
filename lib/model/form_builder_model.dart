import 'dart:convert';

import 'package:first_test/model/drop_down_model.dart';
import 'package:first_test/model/radio_button_model.dart';
import 'package:first_test/model/text_field_model.dart';

class FormBuilder {
  final String formName;
  final List<TextFieldModel> textFieldsList;
  final List<RadioButtonModel> radioButtonsList;
  final List<DropDownModel> dropDownList;
  FormBuilder({
    required this.formName,
    required this.textFieldsList,
    required this.radioButtonsList,
    required this.dropDownList,
  });

  factory FormBuilder.fromMap(json) {
    return FormBuilder(
        formName: json['title'],
        dropDownList: parseDropDown(json),
        textFieldsList: parseTextField(json),
        radioButtonsList: parseRadioButtons(json));
  }
  static List<RadioButtonModel> parseRadioButtons(itemsJson) {
    final list = itemsJson["fields"]['radio_button'] as List;
    final List<RadioButtonModel> itemsList =
        list.map((data) => RadioButtonModel.fromMap(data)).toList();
    return itemsList;
  }

  static List<DropDownModel> parseDropDown(itemsJson) {
    print(itemsJson);
    final list = itemsJson["fields"]['drop_down'] as List;
    final List<DropDownModel> itemsList =
        list.map((data) => DropDownModel.fromMap(data)).toList();
    return itemsList;
  }

  static List<TextFieldModel> parseTextField(itemsJson) {
    final list = itemsJson["fields"]['input_text_field'] as List;
    final List<TextFieldModel> itemsList =
        list.map((data) => TextFieldModel.fromMap(data)).toList();
    return itemsList;
  }

  factory FormBuilder.fromJson(String source) =>
      FormBuilder.fromMap(json.decode(source));
}
