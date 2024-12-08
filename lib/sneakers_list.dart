import 'package:sneakers/sneakers_card.dart';
import 'package:flutter/material.dart';
import 'sneakers_model.dart';

class SneakersList extends StatelessWidget {
  final List<Sneakers> sneakers;
  const SneakersList(this.sneakers, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: sneakers.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return sneakersCard(sneakers[int]);
      },
    );
  }
}
