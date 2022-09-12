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
  final String cf;

  const ContributingFactorRepresentation({Key? key, this.cf = ""})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ContributingFactorRepresentationState();

  @override
  gen.ContributingFactor transform() {
    return gen.ContributingFactor.valueOf(cf);
  }
}

// https://docs.flutter.dev/development/ui/interactive#the-parent-widget-manages-the-widgets-state
// NB: Not sure I am being smart about statemanagement here...
class ContributingFactorRepresentationState
    extends State<ContributingFactorRepresentation> {
  String _cf = gen.ContributingFactor.patientAggressiveTreatment.toString();

  void _handleDescriptionClick() {
    setState(() {
      BlocProvider.of<cfbloc.ContributingFactorBloc>(context).add(
          cfbloc.Description(
              constributingFactor: gen.ContributingFactor.valueOf(_cf)));
    });
  }

  void _handleCategoryClick() {
    setState(() {
      BlocProvider.of<cfbloc.ContributingFactorBloc>(context).add(
          cfbloc.Category(
              constributingFactor: gen.ContributingFactor.valueOf(_cf)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ContributingFactorNameView(name: _cf),
        const CategoryView(),
        const DescriptionView(),
        GetCategory(onClick: _handleCategoryClick),
        GetDescription(onClick: _handleDescriptionClick),
      ],
    );
  }
}

class ContributingFactorNameView extends StatelessWidget {
  final String name;

  const ContributingFactorNameView({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    // dropdown of all the names?
    return Text(name);
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
