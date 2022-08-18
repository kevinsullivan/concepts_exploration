import '../../editor/editor.dart';
import '../bloc/int_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
This hand-crafted file defines the home page of the 
GetSet app, constructed using build, returning bloc 
provider that provides access to IntBloc
*/
class IntHomepage extends StatelessWidget {
  final Editor e;
  const IntHomepage({required this.e, Key? key}) : super(key: key);

  @override
  /*
  Creates the BlocProvider widget that creates an IntBloc and exposes
  it to the IntView
  */
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => (e.getBloc() as IntBloc),
        child: Scaffold(body: Center(child: e.getView())));
  }
}
