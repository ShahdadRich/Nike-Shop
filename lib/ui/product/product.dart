import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/data/product.dart';
import 'package:nike/ui/product/details.dart';
import 'package:nike/ui/ulids.dart';
import 'package:nike/ui/widgets/image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.products,
    required this.borderRadius,
  });

  final ProductEntity products;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
                  product: products,
                ))),
        child: SizedBox(
          width: 176,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 189,
                    width: 176,
                    child: ImageLoadeService(
                        imgeUrl: products.imgUrl, borderRadius: borderRadius),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(
                        CupertinoIcons.heart,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  products.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  products.previousPrice.withPriceLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(decoration: TextDecoration.lineThrough),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Text(products.price.withPriceLabel),
              )
            ],
          ),
        ),
      ),
    );
  }
}
