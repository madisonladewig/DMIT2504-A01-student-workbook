import 'package:flutter/material.dart';

class DisplayLikes extends StatelessWidget {
  // why is this stateless? I'm just going to use it as a display container that is passed down values.

  // instance attributes
  final int  numLikes;
  final bool forDislikes; // false for likes, true for dislikes

  // constructor
  const DisplayLikes({
    this.numLikes    = 0,
    this.forDislikes = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16),
      child: Row(
        children: <Widget> [

          Text(
            forDislikes ? "Dislikes: " : "Likes: ", // dynamic text based on boolean 
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)
          ),

          Text('$numLikes', style: const TextStyle(fontSize: 18.0)),

        ]
      )
    );
  }

}