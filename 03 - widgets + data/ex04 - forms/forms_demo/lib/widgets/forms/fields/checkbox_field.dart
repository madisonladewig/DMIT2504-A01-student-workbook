import 'package:flutter/material.dart';

// Lots of things like TextFields have FormField versions already (TextFormField) where
// internal field state is already managed properly. 

// Some things - sliders, switches, datepickers, checkboxes, for example, don't, so we'd need to make those manually.
// This is going to be genuinely insufferable, but I do want to show you the template for doing that in case you need those in assignment/project work.

class RememberMeField extends FormField<bool> {

  // SomeWidget() : super()  -> basically, for SomeWidget, sometimes we need to run its constructor first with specific params.
  RememberMeField({super.key, super.onSaved, super.validator}) : super(
    // this is where the bulk of our 'element construction' lives
    initialValue: false, // initial state for field
    // all our actual element tree building goes in here, kind of like a build() method
    builder: (FormFieldState<bool> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          CheckboxListTile(
            value: state.value ?? false, // false by default if state.value is null
            onChanged: state.didChange,
            title: const Text('Remember me'),
            controlAffinity: ListTileControlAffinity.leading,
          ),

          // introduce a second child to show error message (TextFormField does exactly this for us already)
          if (state.hasError)
            Text(
              state.errorText!, // state.errorText is a nullable string; here, i KNOW I will have errorText if there is an error
              style: TextStyle(color: Theme.of(state.context).colorScheme.error),
            )
        ]
      );
    }

  );

}