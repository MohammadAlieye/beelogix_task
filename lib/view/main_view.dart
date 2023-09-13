import 'package:beelogix_task/mian/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainScreenController mainScreenController =
        Get.put(MainScreenController());

    Future<void> _handleRefresh() async {
      await mainScreenController.fetchPhotos();
    }

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh, // Triggered when pulled down
          child: Obx(() {
            if (mainScreenController.photos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                ),
                itemCount: mainScreenController.photos.length,
                itemBuilder: (context, index) {
                  final photo = mainScreenController.photos[index];
                  return Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: photo.url,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 48.0,
                              ),
                            ),
                            fit: BoxFit.cover,
                            height: 200.0,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.black.withOpacity(0.6),
                              child: Text(
                                photo.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
