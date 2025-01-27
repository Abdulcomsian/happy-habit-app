import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TransitionScreen extends StatelessWidget {
  static const id = '/TransitionScreen';

  const TransitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transition screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RiveAnimation.asset(
              'assets/transitions/f_lofi.riv',
            ),
          ),
        ],
      ),
    );
  }
}
