import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/common/exception.dart';
import 'package:nike/data/banner.dart';
import 'package:nike/data/product.dart';
import 'package:nike/data/repo/banner_repository.dart';
import 'package:nike/data/repo/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;

  HomeBloc({required this.bannerRepository, required this.productRepository})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      try {
        emit(HomeLoading());
        if (event is HomeStarted || event is HomeRefresh) {
          final banners = await bannerRepository.getAll();
          final lastestProduct =
              await productRepository.getAll(ProductSort.latest);
          final popularProduct =
              await productRepository.getAll(ProductSort.popular);
          emit(HomeSuccess(
              banners: banners,
              lastestProduct: lastestProduct,
              popularProduct: popularProduct));
        }
      } catch (e) {
        emit(HomeError(exception: e is AppException ? e : AppException()));
      }
    });
  }
}
