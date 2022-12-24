import 'package:first_test/model/drop_down_model.dart';
import 'package:first_test/model/form_builder_model.dart';
import 'package:first_test/model/radio_button_model.dart';
import 'package:first_test/widgets/display_form_fields_list.dart';
import 'package:first_test/widgets/display_radio_fields_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'display_data.dart';
import 'model/text_field_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<TextFormField>? formFieldsList = [];
List<TextEditingController>? formFieldsControllers = [];
List<String>? selectedRadio = []; //initialValue for each radio
List<String>? selectedDropdown = [];
List<List<RadioListTile>>? radioList = [];
List<DropdownButton>? dropDownList = [];
late Future<FormBuilder> getData;
late FormBuilder formData;
bool isFormItemsIntialized = false;

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getData = readJson();

    super.initState();
  }

  Future<FormBuilder> readJson() async {
    await Future.delayed(const Duration(seconds: 1));
    final String response = await rootBundle.loadString('assets/form.json');
    final data = json.decode(response);
    formData = FormBuilder.fromMap(data);
    return formData;
  }

  List<List<RadioListTile>>? fillRadioTiles(
      List<RadioButtonModel> radioFields) {
    if (radioFields.isNotEmpty) {
      for (int i = 0; i < radioFields.length; i++) {
        radioList!.insert(i, []);
        selectedRadio!.insert(i, radioFields[i].value);
        for (int j = 0; j < radioFields[i].items.length; j++) {
          radioList![i].add(RadioListTile(
            value: radioFields[i].items[j],
            groupValue: selectedRadio![i],
            onChanged: (value) {},
          ));
        }
      }
    }

    return radioList;
  }

  List<DropdownButton>? fillDropDownsSelectedItem(
      List<DropDownModel> dropdowns) {
    for (int i = 0; i < dropdowns.length; i++) {
      selectedDropdown!.add(dropdowns[i].value);
    }
    return null;
  }

  List<TextFormField>? fillFormFields(List<TextFieldModel> inputFields) {
    for (int i = 0; i < inputFields.length; i++) {
      formFieldsControllers!.add(TextEditingController());
      formFieldsList!.add(TextFormField(
        validator: (value) {
          if (inputFields[i].requiredField) {
            if (value!.isEmpty) {
              return "Required";
            }
            return null;
          }
          return null;
        },
        onChanged: (newValue) {
          formData.textFieldsList[i].value = newValue;
        },
        controller: formFieldsControllers![i],
        obscureText: inputFields[i].label == "password" ? true : false,
        decoration: InputDecoration(
          label: Text(inputFields[i].label),
          hintText: inputFields[i].label,
        ),
      ));
    }

    return formFieldsList;
  }

  initializeFormDisplay() {
    fillRadioTiles(formData.radioButtonsList);
    fillFormFields(formData.textFieldsList);
    fillDropDownsSelectedItem(formData.dropDownList);
    isFormItemsIntialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 50,
                child: FutureBuilder(
                    future: getData,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (isFormItemsIntialized == false) {
                          initializeFormDisplay();
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              if (formFieldsList!.isNotEmpty)
                                DisplayFormFieldList(
                                  textFormFields: formFieldsList!,
                                ),
                              if (formData.dropDownList.isNotEmpty)
                                SizedBox(
                                  width: double.infinity,
                                  height: formData.dropDownList.length * 50,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            formData.dropDownList[index].label,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          DropdownButton(
                                            items: formData
                                                .dropDownList[index].items
                                                .map((items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items),
                                              );
                                            }).toList(),
                                            value: selectedDropdown![index],
                                            onChanged: (value) {
                                              setState(() {
                                                selectedDropdown![index] =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: formData.dropDownList.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                  ),
                                ),
                              const Divider(),
                              if (radioList!.isNotEmpty)
                                for (int i = 0; i < radioList!.length; i++)
                                  DisplayRadioFieldsList(
                                    label: formData.radioButtonsList[i].label,
                                    radioFunc: (val) {
                                      selectedRadio![i] = val;
                                      formData.radioButtonsList[i].value = val;
                                      setState(() {});
                                    },
                                    radioListTile: radioList![i],
                                    selectedRadioVal: selectedRadio![i],
                                  ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
              MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayForm(
                              selectedRadios: formData.radioButtonsList,
                              textFields: formData.textFieldsList),
                        ));
                  } else {
                    return;
                  }
                },
                child: Column(
                  children: const [
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    Text("Submit"),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
