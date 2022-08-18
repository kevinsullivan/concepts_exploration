import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import "int_widget.dart";
import '../bloc/int_bloc.dart';
import '../getset_viewproxy_int.dart';

class IntView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Incorporate this into editorstuff.
    final i = GetSet_ViewProxy_int(intbloc: context.read<IntBloc>());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Get(val: i), Set(val: i)],
    );
  }
}
