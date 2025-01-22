import 'package:flutter/material.dart';
import 'package:event/api/event.dart';

class FavoriteManager extends ChangeNotifier {
  List<Event> _favorites = [];

  List<Event> get favorites => _favorites;

  void toggleFavorite(Event event) {
    if (_favorites.contains(event)) {
      _favorites.remove(event);
    } else {
      _favorites.add(event);
    }
    notifyListeners();
  }

  bool isFavorite(Event event) {
    return _favorites.contains(event);
  }
}
