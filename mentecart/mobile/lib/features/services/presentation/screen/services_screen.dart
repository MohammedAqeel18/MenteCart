import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/features/services/bloc/service_bloc.dart';

class ServicesScreen
    extends StatefulWidget {

  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() =>
      _ServicesScreenState();
}

class _ServicesScreenState
    extends State<ServicesScreen> {

  @override
  void initState() {
    super.initState();

    context.read<ServiceBloc>().add(
          FetchServices(),
        );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Services"),
      ),

      body:
          BlocBuilder<ServiceBloc,
              ServiceState>(
        builder: (context, state) {

          if (state is ServiceLoading) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (state is ServiceFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is ServiceLoaded) {

            return ListView.builder(
              itemCount:
                  state.services.length,

              itemBuilder: (context, index) {

                final service =
                    state.services[index];

                return Card(
                  margin:
                      const EdgeInsets.all(12),

                  child: ListTile(
                    leading: Image.network(
                      service.image,
                      width: 60,
                      fit: BoxFit.cover,
                    ),

                    title:
                        Text(service.title),

                    subtitle: Text(
                      service.category,
                    ),

                    trailing: Text(
                      '\$${service.price}',
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}