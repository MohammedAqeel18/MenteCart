import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/services/bloc/service.event.dart';
import 'package:mobile/features/services/bloc/service.state.dart';
import 'package:mobile/features/services/data/repositories/service_repository.dart';

export 'service.event.dart';
export 'service.state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository repository;

  ServiceBloc(this.repository) : super(ServiceInitial()) {
    on<FetchServices>(_onFetchServices);
  }

  Future<void> _onFetchServices(
    FetchServices event,
    Emitter<ServiceState> emit,
  ) async {
    try {
      emit(ServiceLoading());
      final services = await repository.getServices();
      emit(ServiceLoaded(services));
    } catch (e) {
      emit(ServiceFailure(e.toString()));
    }
  }
}