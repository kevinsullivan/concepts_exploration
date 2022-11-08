import 'package:flutter/material.dart';
import 'int_widgets.dart';

class IntLayout extends StatelessWidget {
  const IntLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [Viewer(), Get(), Set()],
    );
  }
}
