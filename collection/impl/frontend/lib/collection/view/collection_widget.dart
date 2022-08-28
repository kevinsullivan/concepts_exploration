import 'package:collectionsite/collection/view/collection_view.dart';

import '../bloc/collection_bloc.dart';
import 'package:collectiongen/collectiongen.dart' as gen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/collection_bloc.dart' as cbloc;
import 'uirepr/uirepresentation.dart';

class Init<T> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        child: const Text('Init'),
        onPressed: () {
          BlocProvider.of<CollectionBloc>(context).add(cbloc.Init<T>());
        },
      )
    ]);
  }
}

// parameterize by T
class Insert<T> extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        // We are making the decision to construct a new UIRep on insert.
        child: const Text('Insert'),
        onPressed: () {
          // NB: This really needs to be a two step process where the visual
          // representation is created from user input. Then removed.
          BlocProvider.of<CollectionBloc>(context).add(
              cbloc.Insert<T>(toInsert: UIRepresentation<T>().transform()));
          controller.clear();
        },
      )
    ]);
  }
}

class Remove<T> extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        child: const Text('Remove'),
        onPressed: () {
          //
          BlocProvider.of<CollectionBloc>(context).add(
              cbloc.Remove<T>(toRemove: UIRepresentation<T>().transform()));
          controller.clear();
        },
      )
    ]);
  }
}

class Member extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = "";

    return Column(children: [
      TextField(
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: (String val) {
            text = val;
          }),
      ElevatedButton(
        child: const Text('Member'),
        onPressed: () {
          BlocProvider.of<CollectionBloc>(context)
              .add(cbloc.Member<int>(possibleMember: int.parse(text)));
        },
      )
    ]);
  }
}

class CollectionViewer<T> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
      if (state is IsMemberState || state is IsNotMemberState) {
        return this;
      } else if (state is CollectionUpdateState) {
        gen.Collection collection = state.collectionRepresentation;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: collection.value!.length,
          itemBuilder: (context, index) {
            return ListTile(
                // UI REPRESENTATION OF TILE
                // This cast might not be necessary when collection is generic.
                title: UIRepresentation<T>.fromT(
                    collection.value!.elementAt(index) as T));
          },
        );
      } else {
        return const Text("No Initialized Collection");
      }
    });
  }
}
