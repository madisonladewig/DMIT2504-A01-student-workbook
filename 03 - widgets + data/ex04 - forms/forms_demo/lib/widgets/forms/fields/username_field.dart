import 'package:flutter/material.dart';

class UsernameField extends StatefulWidget {

  final TextEditingController controller;
  final String                label;

  const UsernameField({
    super.key,
    required this.controller,
    this.label = 'Username',
  });

  @override
  State<UsernameField> createState() => _UsernameFieldState();

}


class _UsernameFieldState extends State<UsernameField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // every formfield has a validator: a conditional expression that returns a value for the error message if failed, or null if succeeded
      controller: widget.controller,
      validator: (value) => value == null || value.trim().isEmpty 
        ? 'Username cannot be empty'  // check fails  -> return error message
        : null,                       // check passes -> return null,                                          
      decoration: InputDecoration(label: Text('Username')),
    );
  }

}