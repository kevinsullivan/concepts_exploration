import 'package:concept/concept/view/uirepr/uirepresentation.dart';
import 'package:flutter/material.dart';
import 'package:contributingfactorgen/contributingfactorgen.dart' as gen;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contributing_factor_bloc.dart' as cfbloc;
import '../bloc/contributing_factor_bloc.dart';

// This is the iterface need to support parametrization.
class ContributingFactorRepresentation extends StatefulWidget
    implements UIRepresentation<gen.ContributingFactor> {
  // Any pieces needed for transform.
  String _cf = gen.ContributingFactor.values.first.name;

  ContributingFactorRepresentation({Key? key}) : super(key: key);

  ContributingFactorRepresentation.from({Key? key, required gen.ContributingFactor cf})
      : super(key: key) {
    _cf = cf.name;
  }

  @override
  State<StatefulWidget> createState() =>
      ContributingFactorRepresentationState();

  @override
  gen.ContributingFactor transform() {
    return gen.ContributingFactor.valueOf(_cf);
  }
}

// https://docs.flutter.dev/development/ui/interactive#the-parent-widget-manages-the-widgets-state
// NB: Not sure I am being smart about statemanagement here...
class ContributingFactorRepresentationState
    extends State<ContributingFactorRepresentation> {
  void _handleCFChange(String val) {
    setState(() {
      widget._cf = val;
    });
  }

  void _handleDescriptionClick() {
    BlocProvider.of<cfbloc.ContributingFactorBloc>(context).add(
        cfbloc.Description(
            constributingFactor: gen.ContributingFactor.valueOf(widget._cf)));
  }

  void _handleCategoryClick() {
    BlocProvider.of<cfbloc.ContributingFactorBloc>(context).add(cfbloc.Category(
        constributingFactor: gen.ContributingFactor.valueOf(widget._cf)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContributingFactorNameView(onChanged: _handleCFChange),
        const CategoryView(),
        const DescriptionView(),
        GetCategory(onClick: _handleCategoryClick),
        GetDescription(onClick: _handleDescriptionClick),
      ],
    );
  }
}

class DescriptionView extends StatelessWidget {
  const DescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cfbloc.ContributingFactorBloc, ContributingFactorState>(
      buildWhen: (previous, current) {
        return current is ContributingFactorDescriptionUpdateState;
      },
      builder: (context, state) {
        // Builder seems to be called regardless of buildWhen on initialization.
        var description = "";
        if (state is ContributingFactorDescriptionUpdateState) {
          description = state.description;
        }
        return Text(description);
      },
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<cfbloc.ContributingFactorBloc, ContributingFactorState>(
      buildWhen: (previous, current) {
        return current is ContributingFactorCateogryUpdateState;
      },
      builder: (context, state) {
        var category = "";
        if (state is cfbloc.ContributingFactorCateogryUpdateState) {
          category = state.category;
        }
        return Text(category);
      },
    );
  }
}

// Parent is passing down state. I am just managing the visuals and passing back
// clicks.
class GetCategory extends StatelessWidget {
  final VoidCallback onClick;

  const GetCategory({super.key, required this.onClick});

  void _handlePressed() {
    onClick();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text('Get Category'), onPressed: () => _handlePressed());
  }
}

class GetDescription extends StatelessWidget {
  final VoidCallback onClick;

  const GetDescription({super.key, required this.onClick});

  void _handlePressed() {
    onClick();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text('Get Description'),
        onPressed: () => _handlePressed());
  }
}

class ContributingFactorNameView extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const ContributingFactorNameView({super.key, required this.onChanged});

  @override
  State<ContributingFactorNameView> createState() =>
      _ContributingFactorNameViewState();
}

class _ContributingFactorNameViewState
    extends State<ContributingFactorNameView> {
  String dropdownValue = gen.ContributingFactor.values.first.name;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          widget.onChanged(value);
        });
      },
      items: gen.ContributingFactor.values
          .map((p0) => p0.name)
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
