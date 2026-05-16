import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/core/utils/storage_service.dart';
import 'package:mobile/features/bookings/bloc/booking_bloc.dart';



class BookingsScreen
    extends StatefulWidget {

  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() =>
      _BookingsScreenState();
}

class _BookingsScreenState
    extends State<BookingsScreen> {

  @override
  void initState() {
    super.initState();

    loadBookings();
  }

  Future<void> loadBookings() async {

    final token =
        await StorageService.getToken();

    if (token == null) return;

    if (!mounted) return;

    context.read<BookingBloc>().add(
          FetchBookings(token: token),
        );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("My Bookings"),
      ),

      body:
          BlocBuilder<BookingBloc,
              BookingState>(
        builder: (context, state) {

          if (state
              is BookingLoading) {

            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (state
              is BookingError) {

            return Center(
              child:
                  Text(state.message),
            );
          }

          if (state
              is BookingLoaded) {

            if (state.bookings.isEmpty) {
              return const Center(
                child:
                    Text("No bookings"),
              );
            }

            return ListView.builder(
              itemCount:
                  state.bookings.length,

              itemBuilder:
                  (context, index) {

                final booking =
                    state.bookings[index];

                return Card(
                  margin:
                      const EdgeInsets.all(
                    12,
                  ),

                  child: ListTile(
                    title: Text(
                      'Booking #${booking.id.substring(0, 6)}',
                    ),

                    subtitle: Text(
                      'Status: ${booking.status}',
                    ),

                    trailing: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [

                        Text(
                          '\$${booking.totalAmount}',
                        ),

                        if (booking.status ==
                            'confirmed')

                          TextButton(
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
                                      BookingBloc>()
                                  .add(
                                    CancelBooking(
                                      token:
                                          token,
                                      bookingId:
                                          booking.id,
                                    ),
                                  );
                            },

                            child: const Text(
                              "Cancel",
                            ),
                          ),
                      ],
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