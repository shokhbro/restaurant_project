import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _restaurants = [];

  List<Map<String, dynamic>> get restaurants => _restaurants;

  Future<void> fetchRestaurants() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('restaurants').get();
      _restaurants = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching restaurants: $e');
    }
  }

  Future<void> addRestaurant(Map<String, dynamic> restaurantData) async {
    try {
      await _firestore.collection('restaurants').add(restaurantData);
      await fetchRestaurants(); // Refresh the list
    } catch (e) {
      print('Error adding restaurant: $e');
    }
  }

  Future<void> updateRestaurant(
      String id, Map<String, dynamic> restaurantData) async {
    try {
      await _firestore.collection('restaurants').doc(id).update(restaurantData);
      await fetchRestaurants(); // Refresh the list
    } catch (e) {
      print('Error updating restaurant: $e');
    }
  }

  Future<void> deleteRestaurant(String id) async {
    try {
      await _firestore.collection('restaurants').doc(id).delete();
      await fetchRestaurants(); // Refresh the list
    } catch (e) {
      print('Error deleting restaurant: $e');
    }
  }
}
