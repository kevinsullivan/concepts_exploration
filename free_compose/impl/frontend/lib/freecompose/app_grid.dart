import 'package:flutter/material.dart';

class AppGrid extends StatelessWidget {
  final List<Widget> apps;

  const AppGrid({super.key, required this.apps});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, i) => apps[i],
      itemCount: apps.length,
    );
  }
}
