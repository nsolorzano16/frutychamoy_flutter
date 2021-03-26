import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'productsState.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());
}
