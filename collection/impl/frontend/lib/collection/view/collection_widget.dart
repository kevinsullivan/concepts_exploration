import 'package:collectionsite/collection/view/collection_view.dart';
import 'package:collectionsite/collection/view/uirepr/ui_representation_factory.dart';

import '../bloc/collection_bloc.dart';
import 'package:collectiongen/collectiongen.dart' as gen;
import 'package:contributingfactorgen/contributingfactorgen.dart' as cfgen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/collection_bloc.dart' as cbloc;
import 'package:concept/concept/view/uirepr/uirepresentation.dart';

// TODO: Collection should be a UI repr too.

class Init<T> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        child: const Text('Init'),
        onPressed: () {
          BlocProvider.of<CollectionBloc<T>>(context).add(cbloc.Init<T>());
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
          BlocProvider.of<CollectionBloc<T>>(context).add(cbloc.Insert<T>(
              toInsert: UIRepresentationFactory.construct<T>().transform()));
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
          BlocProvider.of<CollectionBloc<T>>(context).add(cbloc.Remove<T>(
              toRemove: UIRepresentationFactory.construct<T>().transform()));
          controller.clear();
        },
      )
    ]);
  }
}

class Member<T> extends StatelessWidget {
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

class CollectionViewer<T> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(T.toString());
    return BlocBuilder<CollectionBloc<T>, CollectionState>(
        builder: (context, state) {
      if (state is IsMemberState || state is IsNotMemberState) {
        return this;
      } else if (state is CollectionUpdateState) {
        gen.Collection collection = state.collectionRepresentation;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: collection.value!.length,
          itemBuilder: (context, index) {
            T element;
            // HACK.
            if (T.toString() == "ContributingFactor") {
              //final collectionBuilder = gen.CollectionBuilder();
              //var x = repr.value!.map((p0) => p0!.asString).map((e) => cfgen.serializers
              //    .deserializeWith(cfgen.ContributingFactor.serializer, e));
              //collectionBuilder.value = ListBuilder(x);
              //active = collectionBuilder.build();
              var str = collection.value!.elementAt(index)!.asString;
              element = cfgen.serializers
                  .deserializeWith(cfgen.ContributingFactor.serializer, str) as T;
            } else {
              element = collection.value!.elementAt(index)!.value as T;
            }
            return ListTile(
                title: UIRepresentationFactory.constructFromT<T>(element));
          },
        );
      } else {
        return const Text("No Initialized Collection");
      }
    });
  }
}
