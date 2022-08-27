import '../bloc/collection_bloc.dart';
import 'package:collectiongen/collectiongen.dart' as gen;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/collection_bloc.dart' as cbloc;

class Init extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        child: const Text('Init'),
        onPressed: () {
          BlocProvider.of<CollectionBloc>(context).add(const cbloc.Init<int>());
        },
      )
    ]);
  }
}

// parameterize by T
class Insert extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String text = "";

    return Column(children: [
      TextField(
          controller: controller,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: (String val) {
            text = val;
          }),
      ElevatedButton(
        child: const Text('Insert'),
        onPressed: () {
          BlocProvider.of<CollectionBloc>(context)
              .add(cbloc.Insert<int>(toInsert: int.parse(text)));
          controller.clear();
        },
      )
    ]);
  }
}

class Remove extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String text = "";

    return Column(children: [
      TextField(
          controller: controller,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          onChanged: (String val) {
            text = val;
          }),
      ElevatedButton(
        child: const Text('Remove'),
        onPressed: () {
          BlocProvider.of<CollectionBloc>(context)
              .add(cbloc.Remove<int>(toRemove: int.parse(text)));
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
        child: const Text('Remove'),
        onPressed: () {
          BlocProvider.of<CollectionBloc>(context)
              .add(cbloc.Member<int>(possibleMember: int.parse(text)));
        },
      )
    ]);
  }
}

class CollectionViewer extends StatelessWidget {
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
              title: Text(collection.value!.elementAt(index).toString()),
            );
          },
        );
      } else {
        return const Text("No Initialized Collection");
      }
    });
  }
}
