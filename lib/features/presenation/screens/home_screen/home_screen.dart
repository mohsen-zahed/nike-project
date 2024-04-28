import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_project/core/exception/app_exception.dart';
import 'package:nike_project/features/data/repository/ibanners_repository.dart';
import 'package:nike_project/features/data/repository/iproducts_repository.dart';
import 'package:nike_project/features/data/source/ibanners_repository_remote_source.dart';
import 'package:nike_project/features/data/source/iproducts_repository_remote_source.dart';
import 'package:nike_project/features/presenation/screens/home_screen/bloc/home_bloc.dart';
import 'package:nike_project/packages/dio/dio_package.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final productsBloc = HomeBloc(
          iBannersRepository: bannerRepository,
          iProductsRepository: productRepository,
        );
        productsBloc.add(HomeStarted());
        return productsBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Image.asset(
                            'assets/images/other_type/app_logo/nike_logo.png');
                      default:
                        return Container(
                          color: Colors.black,
                        );
                    }
                  },
                );
              } else if (state is HomeFailed) {
                return Center(
                  child: Text(state.errorMessage.toString()),
                );
              } else if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                throw AppException(errorException: 'state is not provided.');
              }
            },
          ),
        ),
      ),
    );
  }
}
