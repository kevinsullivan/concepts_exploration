import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intsite/int/int_repository.dart';
import 'package:intsite/int/view/view.dart';

import '../bloc/int_bloc.dart';

class IntRoute extends StatelessWidget {
  const IntRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => IntBloc(repository: IntRepository()),
        child: Scaffold(body: Center(child: IntView())));
  }
}
