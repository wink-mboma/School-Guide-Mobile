import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/edu_blog_controller.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/views/widgets/blog_card.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/carousel_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

class EducationBlog extends StatefulWidget {
  const EducationBlog({Key? key}) : super(key: key);

  @override
  State<EducationBlog> createState() => _EducationBlogState();
}

class _EducationBlogState extends State<EducationBlog> {
  final EduBlogController blogController = Get.find();

  final currentBlogs = <EduBlogDetails>[];

  void getAllBlogs() {
    for (var blog in blogController.allBlogPosts) {
      if (blog.publishPost) {
        currentBlogs.add(blog);
      }
    }
    print(currentBlogs.length);
  }

  Future<String> getDev() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }

  String deviceID = '';
  @override
  void initState() {
    getAllBlogs();
    getDev().then((value) => setState(() {
          deviceID = value;
        }));
    super.initState();
  }

  // get views

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: 'Education Blog',
          children: [
            EduCarousel(blogItems: currentBlogs, deviceID: deviceID),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: currentBlogs.length,
              itemBuilder: (BuildContext context, int index) {
                return EduBlogCard(blog: currentBlogs[index], deviceID: deviceID);
              },
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}
