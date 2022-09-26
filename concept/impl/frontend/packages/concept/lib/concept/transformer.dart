import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository.dart';

abstract class Transformer<I, O> {
  O transform(I input);

  I reverse(O output);
}
