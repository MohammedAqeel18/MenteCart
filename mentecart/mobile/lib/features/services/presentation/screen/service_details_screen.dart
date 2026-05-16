import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/core/utils/storage_service.dart';
import 'package:mobile/features/cart/bloc/cart_bloc.dart';
import 'package:mobile/features/services/data/models/service_model.dart';


class ServiceDetailsScreen
    extends StatefulWidget {

  final ServiceModel service;

  const ServiceDetailsScreen({
    super.key,
    required this.service,
  });

  @override
  State<ServiceDetailsScreen>
      createState() =>
          _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState
    extends State<ServiceDetailsScreen> {

  final dateController =
      TextEditingController();

  final slotController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service.title),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: BlocConsumer<CartBloc,
            CartState>(
          listener: (context, state) {

            if (state is CartSuccess) {

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                const SnackBar(
                  content:
                      Text("Added to cart"),
                ),
              );
            }

            if (state is CartError) {

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                  content:
                      Text(state.message),
                ),
              );
            }
          },

          builder: (context, state) {

            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Image.network(
                  widget.service.image,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 16),

                Text(
                  widget.service.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  widget.service.description,
                ),

                const SizedBox(height: 16),

                TextField(
                  controller:
                      dateController,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Date (2026-05-20)",
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller:
                      slotController,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Time Slot",
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () async {

                      final token =
                          await StorageService
                              .getToken();

                      if (token == null) {
                        return;
                      }

                      if (!context.mounted) {
                        return;
                      }

                      context
                          .read<CartBloc>()
                          .add(
                            AddCartItem(
                              token: token,
                              serviceId:
                                  widget
                                      .service.id,
                              date:
                                  dateController
                                      .text,
                              timeSlot:
                                  slotController
                                      .text,
                              quantity: 1,
                            ),
                          );
                    },

                    child:
                        state is CartLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Add To Cart",
                              ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}