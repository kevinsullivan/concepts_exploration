import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intsite/editorstuff/editorstuff.dart';
import 'package:intsite/int/int_repository.dart';
import 'package:intsite/int/view/view.dart';

import '../bloc/int_bloc.dart';

/*
This hand-crafted file defines the home page of the 
GetSet app, constructed using build, returning bloc 
provider that provides access to IntBloc
*/
class IntHomepage extends StatelessWidget {
  final EditorStuff e;
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
