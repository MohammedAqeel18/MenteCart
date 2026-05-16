import 'package:equatable/equatable.dart';

abstract class ServiceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchServices extends ServiceEvent {}