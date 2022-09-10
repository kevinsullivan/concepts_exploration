import 'package:flutter/material.dart';


// T is bloc parametrization
abstract class UIRepresentation<T> implements StatefulWidget {
  // Transformation from UIRepresentation to Bloc Representation.
  T transform();
}