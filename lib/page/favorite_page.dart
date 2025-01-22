import 'package:flutter/material.dart';
import 'package:event/api/event.dart';
import 'package:provider/provider.dart';
import 'package:event/api/favorite_manager.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteManager.favorites.isEmpty
          ? const Center(
        child: Text("No favorite events yet."),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favoriteManager.favorites.length,
        itemBuilder: (context, index) {
          final event = favoriteManager.favorites[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    event.imgUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),

                // Detail
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      // Deskripsi
                      Text(
                        event.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 16),

                      // Harga dan Tombol
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price: ${event.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              favoriteManager.toggleFavorite(event);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${event.title} removed from favorites',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
