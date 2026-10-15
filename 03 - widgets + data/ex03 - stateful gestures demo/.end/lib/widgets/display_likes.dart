import 'package:flutter/material.dart';

class DisplayLikes extends StatelessWidget {
  // something to think about ahead of time: Why is this stateless?

  // instance attributes
  final int  numLikes;
  final bool forDislikes; // false -> for likes, true -> dislikes 

  // constructor
  const DisplayLikes({
    this.numLikes = 0,
    this.forDislikes = false,
    super.key
  });

  // build method
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16),
      child: Row(
        children: <Widget>[

          Text(
            forDislikes ? "Dislikes: " : "Likes: ", // dynamic text based off boolean
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            )
          ),

          Text(
            '$numLikes',
            style: const TextStyle(
              fontSize: 24.0,
            )
          )

        ]
      ),
    );
  }
}