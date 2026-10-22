import 'package:flutter/material.dart';


// To set up a form, we 1) convert all our fields to formfields, 2) wrap everything in a Form.
// The point here is, all formfields within a form will validate at the same time when the form submission/validation is triggered.
class UserSignupForm extends StatefulWidget {

  const UserSignupForm({super.key});

  @override
  State<UserSignupForm> createState() => _UserSignupFormState();

}


class _UserSignupFormState extends State<UserSignupForm> {

  // objectively horrible language design, but necessary to access the form & its contents after it's been instantiated
  final _formKey = GlobalKey<FormState>(); // just remember to call an instance of it (); we want Key<T>() instance, not Key<T> type definition

  /* This is just something annoying you have to memorise and include when you use a form.
      a) we need a unique identifier for the form & be able to reference it to e.g. validate & submit
      b) we also need to give it state that is separate & contained from the State<T> of the widget e.g. _UserSignupFormState
  */

  FormFieldValidator<String?> requiredField(String fieldname) {
    // ternary gang!    condition ? ifTrue : ifFalse
    // You've noticed callbacks in flutter are usually () {} instead of () => {} as in JS.
    // You use () {} when returning a code block, or () => someValue when returning a value directly.
    return (value) => value == null || value.trim().isEmpty 
      ? '$fieldname cannot be empty'  // check fails  -> return error message
      : null;                       // check passes -> return null
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          const Text('New User Form', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),

          TextFormField(
          // every formfield has a validator: a conditional expression that returns a value for the error message if failed, or null if succeeded
            validator: requiredField('Username'),                                          
            decoration: InputDecoration(label: Text('Username')),
          ),

          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            validator: requiredField('Password'),                                          
            decoration: InputDecoration(label: Text('Password')),
          ),

          ElevatedButton( // this is just for me; I like how it looks better and this doesn't affect behaviour
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) { // exclamation mark is a forced type assertion, a.k.a. "trust me bro"
              /* If you removed the exclamation mark, your compiler would error out, telling you:
                  _formKey.currentState.validate() is not valid because .currentState() is nullable (mouse over it) -> null.validate() doesn't exist.
                  *we* 'know' that we'll always get correctly formed state because our Form is wired up to its key properly.
              */
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sending your login information to the FBI!"))
                );
              }
            },
            child: const Text('Sign Up'),
          ),

        ],
      ),
    );
  }
}