import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {

  final TextEditingController controller;
  final String                label;

  const PasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();

}


class _PasswordFieldState extends State<PasswordField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // every formfield has a validator: a conditional expression that returns a value for the error message if failed, or null if succeeded
      controller: widget.controller,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) => value == null || value.trim().isEmpty 
        ? 'Password cannot be empty'  // check fails  -> return error message
        : null,                       // check passes -> return null,                                          
      decoration: InputDecoration(label: Text('Password')),
    );
  }

}