import 'package:collectionsite/collection/view/collection_layout.dart';
import 'package:collectionsite/collection/view/uirepr/ui_representation_factory.dart';
import 'package:flutter/foundation.dart';

import '../bloc/collection_bloc.dart';
import 'package:collectiongen/collectiongen.dart' as gen;
import 'package:contributingfactorgen/contributingfactorgen.dart' as cfgen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/collection_bloc.dart' as cbloc;
import 'package:concept/concept/view/uirepr/uirepresentation.dart';

class InitInt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        child: const Text('Init'),
        onPressed: () {
          BlocProvider.of<CollectionBlocInt>(context).add(cbloc.Init<int>());
        },
      )
    ]);
  }
}

// parameterize by T
class InsertInt extends StatelessWidget {
  final controller = TextEditingController();

  // TODO.
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        child: const Text('Insert'),
        onPressed: () {
          BlocProvider.of<CollectionBlocInt>(context)
              .add(cbloc.Insert<int>(toInsert: 0));
          controller.clear();
        },
      )
    ]);
  }
}

class RemoveInt extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        child: const Text('Remove'),
        onPressed: () {
          BlocProvider.of<CollectionBlocInt>(context)
              .add(cbloc.Remove<int>(toRemove: 0));
          controller.clear();
        },
      )
    ]);
  }
}

class MemberInt extends StatelessWidget {
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
          //BlocProvider.of<CollectionBloc<T>>(context)
          //    .add(cbloc.Member<int>(possibleMember: int.parse(text)));
        },
      )
    ]);
  }
}

class CollectionViewerInt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBlocInt, CollectionStateInt>(
        builder: (context, state) {
      if (state is IsMemberStateInt || state is IsNotMemberStateInt) {
        return this;
      } else if (state is CollectionUpdateStateInt) {
        gen.CollectionInt collection = state.collectionRepresentation;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: collection.value!.length,
          itemBuilder: (context, index) {
            int element = collection.value!.elementAt(index);
            return ListTile(title: Text(element.toString()));
          },
        );
      } else {
        return const Text("No Initialized Collection");
      }
    });
  }
}
