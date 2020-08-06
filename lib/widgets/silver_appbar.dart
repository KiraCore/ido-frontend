import 'package:IDO_Kira/widgets/custom_card.dart';
import 'package:fluid_layout/fluid_layout.dart';
import 'package:flutter/material.dart';

import 'custom_appbar.dart';

class SilverAppBar extends StatelessWidget {
  const SilverAppBar(
    BuildContext context, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FluidCell.fit(
        size: context.fluid(12),
        child: CustomCard(
          color: Color.fromRGBO(32, 32, 32, 1),
          child: Container(
            child: CustomAppBar(),
          ),
        ),
      ),
    );
  }
}
