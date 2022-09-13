import 'package:contributingfactor/contributingfactor/view/contributing_factor_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/contributing_factor_bloc.dart';
import 'contributing_factor_repository.dart';

class ContributingFactorHomepage<T> extends StatelessWidget {
  const ContributingFactorHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ContributingFactorBloc(ContributingFactorRepository()),
        child:
            Scaffold(body: Center(child: ContributingFactorRepresentation())));
  }
}
