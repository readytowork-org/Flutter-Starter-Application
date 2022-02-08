import 'package:flutter/material.dart';

class TextFieldComponent extends StatefulWidget {
  final Function onChanged;
  final String? labelText;
  final String hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const TextFieldComponent({
    Key? key,
    required this.onChanged,
    this.labelText,
    required this.hintText,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  _TextFieldComponentState createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  final FocusNode _textFieldFocus = FocusNode();
  Color? _color = Colors.grey[160];

  @override
  void initState() {
    super.initState();
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = Colors.white;
        });
      } else {
        setState(() {
          _color = Colors.grey[100];
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Required";
        }
        if (widget.labelText == "Password" ||
            widget.labelText == "Confirm Password") {
          if (value.length < 6) {
            return "Password length must be at least six characters";
          }
        }
        return null;
      },
      obscureText: widget.obscureText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) => widget.onChanged(value),
      decoration: InputDecoration(
        filled: true,
        fillColor: _color,
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      focusNode: _textFieldFocus,
    );
  }
}
