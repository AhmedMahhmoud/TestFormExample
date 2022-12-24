import 'dart:convert';

import 'package:first_test/model-2/form_data_model.dart';

class FormBuilder2 {
  final List<FormDataModel> formDataList;
  FormBuilder2({
    required this.formDataList,
  });

  static List<FormDataModel> parseForm(itemsJson) {
    final list = itemsJson['data']['fields'] as List;
    final List<FormDataModel> itemsList =
        list.map((data) => FormDataModel.fromMap(data)).toList();
    return itemsList;
  }

  factory FormBuilder2.fromMap(json) {
    return FormBuilder2(
      formDataList: parseForm(json),
    );
  }

  factory FormBuilder2.fromJson(String source) =>
      FormBuilder2.fromMap(json.decode(source));
}
