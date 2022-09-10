import 'package:concept/concept/view/uirepr/uirepresentation.dart';
import 'package:flutter/material.dart';


class BoolUIRepresentation extends StatefulWidget
    implements UIRepresentation<bool> {
  final bool val;

  const BoolUIRepresentation({Key? key, this.val = true}) : super(key: key);

  @override
  bool transform() {
    final potentiallyMoreComplexStateFetching = val;
    return potentiallyMoreComplexStateFetching;
  }

  @override
  State<StatefulWidget> createState() => BoolUIRepresentationState();
}

class BoolUIRepresentationState extends State<BoolUIRepresentation> {
  bool _val = false;

  void _handleNegate() {
    setState(() {
      _val = !_val;
    });
    // Pass to bloc.
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ViewBool(val: _val),
        Negate(val: _val, onToggle: _handleNegate),
      ],
    );
  }
}

class ViewBool extends StatelessWidget {
  final bool val;

  const ViewBool({super.key, required this.val});
  @override
  Widget build(BuildContext context) {
    if (val) {
      return const Icon(Icons.flashlight_on);
    }

    return const Icon(Icons.flashlight_off);
  }
}

class Negate extends StatelessWidget {
  final bool val;
  final VoidCallback onToggle;

  const Negate({super.key, required this.val, required this.onToggle});

  void _handlePressed() {
    onToggle();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text('Negate'), onPressed: () => _handlePressed());
  }
}
