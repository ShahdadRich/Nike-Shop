import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/data/product.dart';
import 'package:nike/data/repo/cart_repository.dart';
import 'package:nike/ui/product/bloc/product_bloc.dart';
import 'package:nike/ui/product/comment/comment_list.dart';
import 'package:nike/ui/ulids.dart';
import 'package:nike/ui/widgets/image.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  StreamSubscription<ProductState>? stateSubscriotion;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  @override
  void dispose() {
    stateSubscriotion?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository);
          stateSubscriotion = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              _scaffoldKey.currentState?.showSnackBar(
                const SnackBar(
                  content: Text('با موفقیت به سبد خرید شما اضافه شد'),
                ),
              );
            } else if (state is ProductAddToCartError) {
              _scaffoldKey.currentState?.showSnackBar(
                SnackBar(
                  content: Text(state.exception.masssage),
                ),
              );
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width - 48,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) => FloatingActionButton.extended(
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(CartAddButtonClick(widget.product.id));
                    },
                    label: state is ProductAddToCartButtonLoading
                        ? CupertinoActivityIndicator(
                            color: Theme.of(context).colorScheme.onSecondary,
                          )
                        : const Text('افزودن به سبد خرید')),
              ),
            ),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  flexibleSpace: ImageLoadeService(
                    imgeUrl: widget.product.imgUrl,
                    borderRadius: BorderRadius.zero,
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.heart))
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.product.previousPrice.withPriceLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                Text(widget.product.price.withPriceLabel),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                            'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال پیدا کند.'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات کاربران',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextButton(onPressed: () {}, child: Text('ثبت نظر'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CommentList(productId: widget.product.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
