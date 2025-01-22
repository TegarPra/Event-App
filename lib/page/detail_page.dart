import 'package:flutter/material.dart';
import 'package:event/api/event.dart';
import 'package:event/page/pemesanan_page.dart';
import 'package:provider/provider.dart';
import 'package:event/api/favorite_manager.dart';

class DetailPage extends StatelessWidget {
  final Event event;


  const DetailPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,actions: [
        IconButton(
          icon: Icon(
            favoriteManager.isFavorite(event) ? Icons.favorite : Icons.favorite_border,
            color: favoriteManager.isFavorite(event) ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            favoriteManager.toggleFavorite(event);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  favoriteManager.isFavorite(event)
                      ? '${event.title} added to favorites'
                      : '${event.title} removed from favorites',
                ),
              ),
            );
          },
        ),
      ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Image.asset(
              event.imgUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),

            // Title section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                event.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Description section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                event.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Details section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date & Time
                  Row(
                    children: [
                      const Icon(Icons.event, color: Colors.orange, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Date & Time: ${event.dateTime}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Location: ${event.location}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Refund Policy
                  Row(
                    children: [
                      const Icon(Icons.policy, color: Colors.blue, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Refund Policy: ${event.refundPolicy}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Price and Status
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price: ${event.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'Status: ${event.status}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: event.status == 'Available'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Button for purchasing tickets
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: // Update pada tombol "Beli Tiket"
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PemesananPage(
                        eventTitle: event.title,
                        ticketPrice: double.parse(
                          event.price.replaceAll(RegExp(r'[^\d]'), ''), // Menghapus Rp dan titik
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Beli Tiket'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
