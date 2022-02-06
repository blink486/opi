import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            backgroundColor: Colors.yellow,
            strokeWidth: 24,
          ),
          height: 120.0,
          width: 120.0,
        ),
      ),
    );
  }
}
