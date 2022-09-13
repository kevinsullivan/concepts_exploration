// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:contributingfactorgen/contributingfactorgen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter value should be incremented', () {
    // print(ContributingFactor.patientAggressiveTreatment);
    // print(ContributingFactor.patientAggressiveTreatment.name);
    // print(ContributingFactor.valueOf(
    //     ContributingFactor.patientAggressiveTreatment.name));
    final val = 'team_poor_communication';

    print(serializers.deserializeWith(ContributingFactor.serializer, val));
    //print(serializers.serializeWith(ContributingFactor.serializer, ContributingFactor.patientAggressiveTreatment));
    //print(x.wireName);
  });

  //testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //  // Build our app and trigger a frame.
  //});
}
