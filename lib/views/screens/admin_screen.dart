import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_project/services/restaurant_provider.dart';

class AdminScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name')),
            TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address')),
            TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone')),
            TextField(
                controller: _ratingController,
                decoration: const InputDecoration(labelText: 'Rating')),
            TextField(
                controller: _latitudeController,
                decoration: const InputDecoration(labelText: 'Latitude')),
            TextField(
                controller: _longitudeController,
                decoration: const InputDecoration(labelText: 'Longitude')),
            TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> newRestaurant = {
                  'name': _nameController.text,
                  'address': _addressController.text,
                  'phone': _phoneController.text,
                  'rating': _ratingController.text,
                  'latitude': double.parse(_latitudeController.text),
                  'longitude': double.parse(_longitudeController.text),
                  'image_url': _imageUrlController.text,
                };
                context.read<RestaurantProvider>().addRestaurant(newRestaurant);
              },
              child: const Text('Add Restaurant'),
            ),
          ],
        ),
      ),
    );
  }
}
