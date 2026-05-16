import 'package:equatable/equatable.dart';
import 'package:mobile/features/cart/data/models/cart_model.dart'; 

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {}

class CartError extends CartState {
  final String message;

  CartError(this.message);

  @override
  List<Object> get props => [message];  
}                                        

class CartLoaded extends CartState {
  final List<CartItemModel> items;

  CartLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class CheckoutSuccess extends CartState {}