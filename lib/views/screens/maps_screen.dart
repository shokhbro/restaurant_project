import 'package:flutter/material.dart';
import 'package:restaurant_project/services/yandex_map_service.dart';
import 'package:restaurant_project/views/widgets/search_bar_widget.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapsScreen> {
  late YandexMapController mapController;
  List<MapObject>? polylines;
  final List<MapObject> mapObjects = [];
  Point myCurrentLocation = const Point(
    latitude: 41.2856806,
    longitude: 69.9034646,
  );

  Point najotTalim = const Point(
    latitude: 41.2856806,
    longitude: 69.2034646,
  );

  void onMapCreated(YandexMapController controller) async {
    mapController = controller;
    await mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: najotTalim,
          zoom: 16,
        ),
      ),
    );
    setState(() {});
  }

  void onCameraPositionChanged(
    CameraPosition position,
    CameraUpdateReason reason,
    bool finished,
  ) async {
    myCurrentLocation = position.target;

    if (finished) {
      polylines =
          await YandexMapService.getDirection(najotTalim, myCurrentLocation);
    }
    setState(() {});
  }

  void _performSearch(String query) async {
    final placemarks = await YandexMapService.performSearch(query);

    setState(() {
      mapObjects.clear();
      mapObjects.addAll(placemarks);
    });

    if (placemarks.isNotEmpty) {
      await mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: placemarks.first.point,
            zoom: 15,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: onMapCreated,
            onCameraPositionChanged: onCameraPositionChanged,
            mapType: MapType.map,
            mapObjects: [
              PlacemarkMapObject(
                mapId: const MapObjectId("najotTalim"),
                point: najotTalim,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                      "assets/images/route_start.png",
                    ),
                  ),
                ),
              ),
              PlacemarkMapObject(
                mapId: const MapObjectId("myCurrentLocation"),
                point: myCurrentLocation,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                      "assets/images/place.png",
                    ),
                  ),
                ),
              ),
              ...?polylines,
              ...mapObjects,
            ],
          ),
          Positioned(
            top: 90,
            left: 15,
            right: 15,
            child: SearchbarWidget(
              onSearch: _performSearch,
            ),
          ),
        ],
      ),
    );
  }
}
