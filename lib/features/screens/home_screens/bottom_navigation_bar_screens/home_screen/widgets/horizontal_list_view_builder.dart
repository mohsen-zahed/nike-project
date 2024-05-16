import 'package:flutter/material.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/features/screens/home_screens/bottom_navigation_bar_screens/home_screen/widgets/single_product_card_widget.dart';

class HorizontalListViewBuilder extends StatelessWidget {
  final List<ProductModel> listViewBuilderlist;
  const HorizontalListViewBuilder({
    super.key,
    required this.listViewBuilderlist,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listViewBuilderlist.length,
          itemBuilder: (context, index) {
            // every latest's card widget
            return SingleProductCardWidget(
              borderRadius: 10,
              isGridView: false,
              latestProduct: listViewBuilderlist[index],
              index: index,
            );
          }),
    );
  }
}
