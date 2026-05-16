import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddCartItem extends CartEvent {
  final String token;
  final String serviceId;
  final String date;
  final String timeSlot;
  final int quantity;

  AddCartItem({
    required this.token,
    required this.serviceId,
    required this.date,
    required this.timeSlot,
    required this.quantity,
  });

  @override
  List<Object> get props => [token, serviceId, date, timeSlot, quantity];
}                                       

class FetchCartItems extends CartEvent {
  final String token;

  FetchCartItems({required this.token});

  @override
  List<Object> get props => [token];
}

class CheckoutCart extends CartEvent {
  final String token;

  CheckoutCart({required this.token});

  @override
  List<Object> get props => [token];
}