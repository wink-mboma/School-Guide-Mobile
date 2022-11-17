import 'package:flutter/material.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';

class DisplayGallery extends StatelessWidget {
  const DisplayGallery({Key? key, this.title, this.school, required this.imageIndex}) : super(key: key);
  final String? title;
  final SchoolDetails? school;
  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    var controller = PageController(keepPage: true, initialPage: imageIndex);

    return Scaffold(
      appBar: const CustomAppBar(backIconAvailable: true, showAbout: true, isHomeAppBar: true),
      body: PageView.builder(
          controller: controller,
          itemCount: school!.gallery.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 120,
                    height: 60,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: InteractiveViewer(
                      panEnabled: false,
                      boundaryMargin: const EdgeInsets.all(2),
                      minScale: 0.5,
                      maxScale: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedImage(
                          imageUrl: school!.gallery[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 15,
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${index + 1} / ${school!.gallery.length}',
                        style: const TextStyle(color: AppColors.primaryColor, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
