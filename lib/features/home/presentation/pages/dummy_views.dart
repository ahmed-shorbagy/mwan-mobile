import 'package:flutter/material.dart';

class TwoHandsView extends StatelessWidget {
  const TwoHandsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Two Hands View',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Users View',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
