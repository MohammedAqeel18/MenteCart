import 'package:flutter/material.dart';
import 'package:mobile/core/utils/storage_service.dart';
import 'package:mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:mobile/features/bookings/presentation/screens/bookings_screen.dart';
import 'package:mobile/features/cart/presentation/screens/cart_screen.dart';
import 'package:mobile/features/services/presentation/screen/services_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout(
    BuildContext context,
  ) async {

    await StorageService.clearToken();

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const LoginScreen(),
      ),
    );
  }

  Widget buildCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {

    return GestureDetector(
      onTap: onTap,

      child: Card(
        elevation: 4,

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16),
        ),

        child: Container(
          padding:
              const EdgeInsets.all(20),

          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(16),

            color: color.withOpacity(0.1),
          ),

          child: Row(
            children: [

              Icon(
                icon,
                size: 40,
                color: color,
              ),

              const SizedBox(width: 20),

              Expanded(
                child: Text(
                  title,

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "MenteCart",
        ),

        actions: [

          IconButton(
            onPressed: () =>
                logout(context),

            icon:
                const Icon(Icons.logout),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Welcome Back 👋",

              style: TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Manage your services and bookings easily.",

              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            buildCard(
              context: context,

              title: "Browse Services",

              icon: Icons.miscellaneous_services,

              color: Colors.blue,

              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ServicesScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            buildCard(
              context: context,

              title: "My Cart",

              icon: Icons.shopping_cart,

              color: Colors.orange,

              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const CartScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            buildCard(
              context: context,

              title: "My Bookings",

              icon: Icons.receipt_long,

              color: Colors.green,

              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const BookingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}