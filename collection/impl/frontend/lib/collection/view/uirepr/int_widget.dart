part of 'uirepresentation.dart';
// widgets have to parametrized by other widgets / ui reprs.
// parametric polymorhpism has to happen at each layers representation.
// ui reprs can be serialized
// ui reprs need inits

//

// Extend the StatefulWidget to adhere to the interface restrictions put on
// us by UIRepresentation.


// oh i think i need a notifier. because I cannot modify val
class IntUIRepresentation extends StatefulWidget
    implements UIRepresentation<int> {
  // Any pieces needed for transform.
  final int val;

  const IntUIRepresentation({Key? key, this.val = 0}) : super(key: key);

  @override
  int transform() {
    final potentiallyMoreComplexStateFetching = val;
    return potentiallyMoreComplexStateFetching;
  }

  @override
  State<StatefulWidget> createState() => IntUIRepresentationState();
}

// ui repr

// parent widget handling state.
class IntUIRepresentationState extends State<IntUIRepresentation> {
  int _val = 0;

  // Handle increments from the widget.
  void _handleIncrement() {
    setState(() {
      _val++;
    });
    // Pass to bloc.
  }

  void _handleDecrement() {
    setState(() {
      _val++;
    });
    // Pass to bloc.
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ViewInt(val: _val),
        Increment(val: _val, onIncrement: _handleIncrement),
        Decrement(val: _val, onDecrement: _handleDecrement)
      ],
    );
  }
}

class ViewInt extends StatelessWidget {
  final int val;

  const ViewInt({super.key, required this.val});
  @override
  Widget build(BuildContext context) {
    return Text(val.toString());
  }
}

// Parent is passing down state. I am just managing the visuals and passing back
// clicks.
class Increment extends StatelessWidget {
  final int val;
  final VoidCallback onIncrement;

  const Increment({super.key, required this.val, required this.onIncrement});

  void _handlePressed() {
    onIncrement();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text('Increment'), onPressed: () => _handlePressed());
  }
}

class Decrement extends StatelessWidget {
  final int val;
  final VoidCallback onDecrement;

  const Decrement({super.key, required this.val, required this.onDecrement});

  void _handlePressed() {
    onDecrement();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text('Decrement'), onPressed: () => _handlePressed());
  }
}
