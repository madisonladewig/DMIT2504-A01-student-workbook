import 'package:flutter/material.dart';

import 'fields/username_field.dart';
import 'fields/password_field.dart';
import 'fields/checkbox_field.dart';


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

    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    // unfortunately & imo unjustifiably, we can't read stateful values directly from the fields;
    // we need these to be able to do that (and then e.g. POST those values to a backend).

    bool _rememberMe = false;

    @override
    void dispose() { // {widget}.dispose() is a teardown method that runs when a widget unmounts
      // kind of like cleaning up event listeners - listeners, device-native text editing state, etc. don't automatically get cleaned up. classic memory leak noob trap
      _usernameController.dispose();
      _passwordController.dispose();
      super.dispose(); // note: i'm doing the parent class (generic state)'s cleanup method LAST
    }


  // FormFieldValidator<String?> requiredField(String fieldname) {
  //   // ternary gang!    condition ? ifTrue : ifFalse
  //   // You've noticed callbacks in flutter are usually () {} instead of () => {} as in JS.
  //   // You use () {} when returning a code block, or () => someValue when returning a value directly.
  //   return (value) => value == null || value.trim().isEmpty 
  //     ? '$fieldname cannot be empty'  // check fails  -> return error message
  //     : null;                       // check passes -> return null
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          const Text('New User Form', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),

          // These custom fields were written "the easy way" to show you how to subclass existing formfields
          // that you want to customise but reuse.
          UsernameField(controller: _usernameController),
          PasswordField(controller: _passwordController),

          // I could also have just written uname/pw fields this way too; then I wouldn't need controllers (or any assoc'd code) either.
          // I would just have state for each field that lives in the form.
          RememberMeField(
            onSaved: (value) => _rememberMe = value ?? false,
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
                  SnackBar(
                    content: Text(
                      """Sending your login information to the FBI!
                      u: ${_usernameController.text}
                      p: ${_passwordController.text}
                      remember me? 
                      """
                    )
                  )
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