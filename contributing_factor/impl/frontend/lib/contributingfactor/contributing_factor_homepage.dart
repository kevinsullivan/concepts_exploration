import 'package:contributingfactorsite/contributingfactor/bloc/contributing_factor_bloc.dart';
import 'package:contributingfactorsite/contributingfactor/contributing_factor_repository.dart';
import 'package:contributingfactorsite/contributingfactor/view/contributing_factor_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContributingFactorHomepage<T> extends StatelessWidget {
  const ContributingFactorHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ContributingFactorBloc(ContributingFactorRepository()),
        child: const Scaffold(body: Center(child: ContributingFactorRepresentation())));
  }
}
