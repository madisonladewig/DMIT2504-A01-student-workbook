import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {

  final String title;

  const PageTitle(this.title, {super.key});
  /* why is 'this.title' by itself, whereas {super.key} is in curlies?
     -> curly braces indicate *named parameters*, and it's very similar to JS:
  
     a) in expanded form, this would be PageTitle('Hello", key: someKey)
     b) recall from JS: if I put a variable/param in an object by itself, that's the new property name
          const myValue = 'sup'

          const myObj = { myValue } // this is the same as: { myValue: myValue }
          // if I wanted to change the property name: { newPropName: myValue }
      
     c) back in our example -> I'm not changing the name of the key property, so it can just go in as-is
     
     The way this had to be written in old-school flutter:
         const PageTitle(this.title, {Key? key}) : super(key: key);
     If you wanna do that instead, go nuts  :^)
  */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        )
      )
    );

  }

}