import 'package:flutter/material.dart';
import 'package:nike_project/features/data/models/product_model.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/sub_screens/product_details_screen/product_details_screen.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/widgets/single_product_card_widget.dart';
import 'package:nike_project/utils/media_query.dart';

class HorizontalListViewBuilder extends StatelessWidget {
  final List<ProductModel> listViewBuilderlist;
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
            return SingleProductCardWidget(
              onSingleProductTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      product: listViewBuilderlist[index],
                    ),
                  ),
                );
              },
              latestProduct: listViewBuilderlist[index],
              index: index,
            );
          }),
    );
  }
}
