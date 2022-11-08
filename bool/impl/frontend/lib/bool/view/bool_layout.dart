import 'package:flutter/material.dart';
import 'bool_widgets.dart';

class BoolLayout extends StatelessWidget {
  const BoolLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Viewer(), Get(), Set()],
    );
  }
}
