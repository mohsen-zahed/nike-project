import 'package:flutter/material.dart';
import 'package:nike_project/features/presenation/screens/home_screen/widgets/products_card_widget.dart';
import 'package:nike_project/utils/media_query.dart';

class HorizontalListViewBuilder extends StatelessWidget {
  final List<dynamic> listViewBuilderlist;
  const HorizontalListViewBuilder({
    super.key,
    required this.listViewBuilderlist,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getMediaQueryWidth(context),
      height: getMediaQueryHeight(context, 0.4),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listViewBuilderlist.length,
          itemBuilder: (context, index) {
            // every latest's card widget
            return ProductsCardWidget(
              index: index,
              latestProducts: listViewBuilderlist,
            );
          }),
    );
  }
}
