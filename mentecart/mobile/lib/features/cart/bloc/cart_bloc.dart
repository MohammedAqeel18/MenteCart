import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/cart/bloc/cart_event.dart';
import 'package:mobile/features/cart/bloc/cart_bloc.dart';       
import 'package:mobile/features/cart/data/repositories/cart_repository.dart';

export 'cart_event.dart';
export 'cart.state.dart';                                              

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(CartInitial()) {
    on<AddCartItem>(_onAddCartItem);       
    on<FetchCartItems>(_onFetchCartItems); 
    on<CheckoutCart>(_onCheckoutCart);     
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

  Future<void> _onFetchCartItems(
    FetchCartItems event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoading());
      final items = await repository.getCartItems(
        token: event.token,
      );
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onCheckoutCart(
    CheckoutCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoading());
      await repository.checkout(
        token: event.token,
      );
      emit(CheckoutSuccess());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}