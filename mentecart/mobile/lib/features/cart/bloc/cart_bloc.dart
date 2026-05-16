import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/cart/bloc/cart_event.dart';
import 'package:mobile/features/cart/bloc/cart.state.dart';
import 'package:mobile/features/cart/data/repoaitories/cart_repository.dart';

export 'cart_event.dart';
export 'cart.state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(CartInitial()) {
    on<AddCartItem>(_onAddCartItem);
  }

  Future<void> _onAddCartItem(
    AddCartItem event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoading());
      await repository.addToCart(
        token: event.token,
        serviceId: event.serviceId,
        date: event.date,
        timeSlot: event.timeSlot,
        quantity: event.quantity,
      );
      emit(CartSuccess());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}