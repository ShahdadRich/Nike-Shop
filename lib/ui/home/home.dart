import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nike/data/product.dart';
import 'package:nike/data/repo/banner_repository.dart';
import 'package:nike/data/repo/product_repository.dart';
import 'package:nike/ui/home/bloc/home_bloc.dart';
import 'package:nike/ui/product/product.dart';
import 'package:nike/ui/widgets/error.dart';
import 'package:nike/ui/widgets/slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/img/nike_logo.png',
                            fit: BoxFit.fitHeight,
                            height: 100,
                          ),
                        );
                      case 2:
                        return BannerSlider(
                          banners: state.banners,
                        );
                      case 3:
                        return _HorizanlatProductList(
                          titel: 'جدیدترین',
                          onTab: () {},
                          product: state.lastestProduct,
                        );

                      case 4:
                        return _HorizanlatProductList(
                          titel: 'پربازدید ترین',
                          onTab: () {},
                          product: state.popularProduct,
                        );
                      default:
                        return Container();
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return AppErrorWidget(
                  exception: state.exception,
                  onpress: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                  },
                );
              } else {
                throw Exception('khataye developer');
              }
            },
          ),
        ),
      ),
    );
  }
}

class _HorizanlatProductList extends StatelessWidget {
  final String titel;
  final GestureTapCallback onTab;
  final List<ProductEntity> product;
  const _HorizanlatProductList({
    super.key,
    required this.titel,
    required this.onTab,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(onPressed: onTab, child: const Text('مشاهده همه'))
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
              padding: const EdgeInsets.only(left: 8, right: 8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: product.length,
              itemBuilder: (context, index) {
                final products = product[index];
                return ProductItem(
                  products: products,
                  borderRadius: BorderRadius.circular(12),
                );
              }),
        )
      ],
    );
  }
}
