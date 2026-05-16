import 'package:equatable/equatable.dart';
import 'package:mobile/features/services/data/models/service_model.dart';

abstract class ServiceState extends Equatable {
  @override
  List<Object> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<ServiceModel> services;

  ServiceLoaded(this.services);

  @override
  List<Object> get props => [services];
}

class ServiceFailure extends ServiceState {
  final String message;

  ServiceFailure(this.message);

  @override
  List<Object> get props => [message];
}