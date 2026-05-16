
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/core/utils/storage_service.dart';
import 'package:mobile/features/cart/bloc/cart_bloc.dart';



class CartScreen
    extends StatefulWidget {

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() =>
      _CartScreenState();
}

class _CartScreenState
    extends State<CartScreen> {

  @override
  void initState() {
    super.initState();

    loadCart();
  }

  Future<void> loadCart() async {

    final token =
        await StorageService.getToken();

    if (token == null) return;

    if (!mounted) return;

    context.read<CartBloc>().add(
          FetchCartItems(token: token),
        );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),

      body: BlocConsumer<CartBloc,
          CartState>(
        listener: (context, state) {

          if (state
              is CheckoutSuccess) {

            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content:
                    Text("Booking Created"),
              ),
            );
          }
        },

        builder: (context, state) {

          if (state is CartLoading) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (state is CartError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is CartLoaded) {

            int total = 0;

            for (var item in state.items) {
              total +=
                  item.price *
                  item.quantity;
            }

            return Column(
              children: [

                Expanded(
                  child: ListView.builder(
                    itemCount:
                        state.items.length,

                    itemBuilder:
                        (context, index) {

                      final item =
                          state.items[index];

                      return ListTile(
                        leading:
                            Image.network(
                          item.image,
                          width: 60,
                        ),

                        title: Text(
                          item.serviceTitle,
                        ),

                        subtitle: Text(
                          '${item.date} | ${item.timeSlot}',
                        ),

                        trailing: Text(
                          '\$${item.price}',
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  child: Column(
                    children: [

                      Text(
                        'Total: \$${total}',
                        style:
                            const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      SizedBox(
                        width:
                            double.infinity,

                        child: ElevatedButton(
                          onPressed:
                              () async {

                            final token =
                                await StorageService
                                    .getToken();

                            if (token ==
                                null) {
                              return;
                            }

                            if (!context
                                .mounted) {
                              return;
                            }

                            context
                                .read<
                                    CartBloc>()
                                .add(
                                  CheckoutCart(
                                    token:
                                        token,
                                  ),
                                );
                          },

                          child: const Text(
                            "Checkout",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}