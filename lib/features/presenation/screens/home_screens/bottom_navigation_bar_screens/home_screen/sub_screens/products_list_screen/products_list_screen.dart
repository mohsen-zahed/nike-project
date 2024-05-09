import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/sub_screens/products_list_screen/bloc/products_list_bloc.dart';
import 'package:nike_project/features/presenation/screens/home_screens/bottom_navigation_bar_screens/home_screen/widgets/single_product_card_widget.dart';
import 'package:nike_project/translations/locale_keys.g.dart';
import 'package:nike_project/utils/media_query.dart';
import 'package:nike_project/widgets_common_in_all_screens/default_failed_widget.dart';

class ProductsListScreen extends StatelessWidget {
  final int sortNumber;
  const ProductsListScreen({super.key, required this.sortNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${LocaleKeys.products_list_text.tr()} - ${LocaleKeys.sport_shoes_text.tr()}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocProvider<ProductsListBloc>(
        create: (context) => ProductsListBloc(productRepository)
          ..add(ProductsListStarted(sort: sortNumber)),
        child: BlocBuilder<ProductsListBloc, ProductsListState>(
          builder: (context, state) {
            if (state is ProductsListSuccess) {
              return GridView.builder(
                padding: EdgeInsets.only(
                    top: getMediaQueryHeight(context, 0.02),
                    bottom: getMediaQueryHeight(context, 0.02)),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return SingleProductCardWidget(
                    isGridView: true,
                    borderRadius: 3,
                    index: index,
                    latestProduct: state.products[index],
                  );
                },
              );
            } else if (state is ProductsListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const DefaultFailedWidget();
            }
          },
        ),
      ),
    );
  }
}
