import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/services/restaurant_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Restaurants')),
      body: Consumer<RestaurantProvider>(
        builder: (context, restaurantProvider, child) {
          return FutureBuilder(
            future: restaurantProvider.fetchRestaurants(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching restaurants'));
              } else {
                return ListView.builder(
                  itemCount: restaurantProvider.restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurantProvider.restaurants[index];
                    return ListTile(
                      title: Text(restaurant['name']),
                      subtitle: Text(restaurant['address']),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
