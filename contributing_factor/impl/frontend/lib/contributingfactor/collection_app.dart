import 'package:flutter/material.dart';

import 'contributing_factor_homepage.dart';

class ContributingFactorApp extends StatelessWidget {
  const ContributingFactorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "ContributingFactor", home: ContributingFactorHomepage());
  }
}
