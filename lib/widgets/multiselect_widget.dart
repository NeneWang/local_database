import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class MultiSelectWithAdd extends StatefulWidget {
  final List<String> options;
  final String Function(String value) validator;
  final void Function(List<String> values) onSaved;

  MultiSelectWithAdd({
    required this.options,
    required this.validator,
    required this.onSaved,
  });

  @override
  _MultiSelectWithAddState createState() => _MultiSelectWithAddState();
}

class _MultiSelectWithAddState extends State<MultiSelectWithAdd> {
  List<String> _selectedValues = [];
  String? _newValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiSelectFormField(
          autovalidate: AutovalidateMode.disabled,
          // chipDisplay: MultiSelectChipDisplay(
          //   onTap: (value) {
          //     setState(() {
          //       _selectedValues.remove(value);
          //     });
          //   },
          // ),
          title: Text("Select values"),
          dataSource: widget.options
              .map((option) => MultiSelectItem<String>(option, option))
              .toList(),
          initialValue: _selectedValues,
          onSaved: (values) {
            setState(() {
              _selectedValues = values ?? [];
            });
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Add value",
          ),
          onSaved: (value) {
            if (value != null && value.isNotEmpty) {
              widget.onSaved([..._selectedValues, value]);
            } else {
              widget.onSaved(_selectedValues);
            }
          },
          onChanged: (value) {
            _newValue = value;
          },
          onFieldSubmitted: (value) {
            if (value.isNotEmpty) {
              setState(() {
                _selectedValues.add(value);
                _newValue = "";
              });
            }
          },
        ),
      ],
    );
  }
}
