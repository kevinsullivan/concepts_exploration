import 'package:collectionsite/composedcollection/compositor.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'package:contributingfactorgen/contributingfactorgen.dart' as gen;
import 'package:flutter/material.dart';

void main() {
  // need impl of these
  // need impl of these
  var collectionAll;
  var tall;
  Compositor compositor = Compositor(collectionAll: collectionAll, tall: tall);

  runApp(compositor.composeApp()); // [has_stuff T]
}
